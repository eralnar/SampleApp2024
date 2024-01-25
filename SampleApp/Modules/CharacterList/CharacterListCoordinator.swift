import SwiftUI


protocol CharacterListCoordinatorParent: AnyObject { }

class CharacterListCoordinator: ObservableObject, Identifiable {
    private weak var parent: CharacterListCoordinatorParent?

    @Published var viewModel: CharacterListViewModel!
    @Published var characterDetailCoord: CharacterDetailCoordinator!
    
    init(parent: CharacterListCoordinatorParent?, ramDataInteractor: RAMDataInteractor) {
        self.parent = parent
        self.viewModel = .init(coordinator: self, ramDataInteractor: ramDataInteractor)
    }
    
    func openDetail(character: RAMCharacter) {
        characterDetailCoord = CharacterDetailCoordinator(parent: self, character: character)
    }
    
}

extension CharacterListCoordinator: CharacterDetailCoordinatorParent {
    
}

struct CharacterListCoordinatorView: View {
    @ObservedObject var coordinator: CharacterListCoordinator
    
    init(coordinator: CharacterListCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        CharacterListView(viewModel: coordinator.viewModel)
            .navigation(item: $coordinator.characterDetailCoord) { coord in
                CharacterDetailCoordinatorView(coordinator: coord)
            }
    }
}

