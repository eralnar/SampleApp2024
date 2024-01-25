import SwiftUI

struct CharacterListView: View {
    
    @ObservedObject var viewModel: CharacterListViewModel

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 0),GridItem(.flexible(), spacing: 0)], spacing: 0.0) {
                ForEach(viewModel.charactersList) { ch in
                    RAMCharacterCell(ramCharacter: ch)
                        .border(Color.white, width: 1.0)
                        .onTapGesture {
                            viewModel.onTap(character: ch)
                        }
                }
            }
            ProgressView()
                .padding(.top)
                .task {
                    await viewModel.getNextPage()
                }
        }
        .navigationTitle("Characters")
        .task { await viewModel.getNextPage() }
        .onAppear {
            viewModel.load()
        }
        .onDisappear {
            viewModel.unload()
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        let coordinator = CharacterListCoordinator(parent: nil, ramDataInteractor: NetworkTest())
        return CharacterListView(viewModel: coordinator.viewModel)
    }
}

struct RAMCharacterCell: View {
    let ramCharacter: RAMCharacter
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let url = URL(string: ramCharacter.image) {
                AsyncImage(url: url,
                           content: { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                }, placeholder: {
                    Image("RAM-character-placeholder")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                })
            }
            LinearGradient(colors: [Color.white.opacity(0.6), Color.white.opacity(0.0)],
                           startPoint: .bottom,
                           endPoint: .top)
                .frame(height: 70)
            Text(ramCharacter.name)
                .padding(.horizontal)
                .padding(.vertical, 5)
                .lineLimit(3)
                .font(.headline)
                .foregroundColor(.black)
            
        }
        
    }
}
