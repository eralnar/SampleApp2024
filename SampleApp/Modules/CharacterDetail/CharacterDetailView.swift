import SwiftUI

struct CharacterDetailView: View {
    
    @ObservedObject var viewModel: CharacterDetailViewModel
    @State var navigationController: UINavigationController?

    var body: some View {
        ZStack(alignment: .top) {
            imageView
                .frame(maxWidth: UIScreen.main.bounds.width,
                       maxHeight: UIScreen.main.bounds.height/2)
                .clipped()
            ScrollView {
                Spacer().frame(height: UIScreen.main.bounds.height/2 - 50)
                infoCardView
            }
        }
        .onAppear {
            viewModel.load()
        }
        .onDisappear {
            viewModel.unload()
        }
        .onTapGesture {
            hideKeyboard()
        }
        .navigationBarTitle(viewModel.character.name)
        .edgesIgnoringSafeArea(.top)
    }
    
    var imageView: some View {
        ZStack(alignment: .top) {
            if let url = URL(string: viewModel.character.image) {
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
            LinearGradient(colors: [Color.white.opacity(0.8), Color.white.opacity(0.0)],
                           startPoint: .top,
                           endPoint: .bottom)
                .frame(height: 200)
        }
    }
    
    var infoCardView: some View {
        VStack(alignment: .center) {
            Text("Character Dossier")
                .font(.headline)
                .padding(.vertical)
            Spacer()
            if !viewModel.character.name.isEmpty {
                CharacterInfoCell(title: "Name", info: viewModel.character.name)
            }
            if !viewModel.character.status.isEmpty {
                CharacterInfoCell(title: "Status", info: viewModel.character.status)
            }
            if !viewModel.character.species.isEmpty {
                CharacterInfoCell(title: "Species", info: viewModel.character.species)
            }
            if !viewModel.character.type.isEmpty {
                CharacterInfoCell(title: "Type", info: viewModel.character.type)
            }
            if !viewModel.character.gender.isEmpty {
                CharacterInfoCell(title: "Gender", info: viewModel.character.gender)
            }
            if !viewModel.character.origin.name.isEmpty {
                CharacterInfoCell(title: "Origin", info: viewModel.character.origin.name)
            }
            if !viewModel.character.location.name.isEmpty {
                CharacterInfoCell(title: "Location", info: viewModel.character.location.name)
            }
            Spacer()
        }
        .padding()
        .cardViewStyle(backgroundColor: Color.white, showShadow: true)
        .padding()
    }
}

struct CharacterDetail_Previews: PreviewProvider {
    static var previews: some View {
        let coordinator = CharacterDetailCoordinator(parent: nil, character: RAMCharacter.sample)
        return CharacterDetailView(viewModel: coordinator.viewModel)
    }
}

struct CharacterInfoCell: View {
    let title: String
    let info: String
    
    var infoColor: Color {
        if info == "Alive" { return Color.green }
        else if info == "Dead" { return Color.red }
        else if info == "unknown" { return Color.cyan }
        else { return Color.primary }
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                Text(title)
                    .font(.subheadline.bold())
                Spacer(minLength: 30.0)
                Text(info)
                    .font(.subheadline.italic())
                    .foregroundColor(infoColor)
            }
            Divider()
        }
        .padding(5)
        
    }
    
}
