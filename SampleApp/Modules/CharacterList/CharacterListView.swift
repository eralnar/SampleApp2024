import SwiftUI

struct CharacterListView: View {
    
    @ObservedObject var viewModel: CharacterListViewModel

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible()), GridItem(.flexible())], spacing: 0.0) {
                ForEach(viewModel.charactersList) { ch in
                    RAMCharacterCell(ramCharacter: ch)
                }
                ProgressView()
                    .task {
                        await viewModel.getNextPage()
                    }
            }
        }
        .navigationTitle("Character List")
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
                    image.resizable()
                        .frame(height: 120.0)
                }, placeholder: {
                    ProgressView()
                })
            }
            Text(ramCharacter.name)
                .padding(5)
                .lineLimit(3)
                .font(.body)
                .foregroundColor(.black)
                .shadow(color: Color.white, radius: 1, x: 0, y: 0)
        }
        
    }
}
