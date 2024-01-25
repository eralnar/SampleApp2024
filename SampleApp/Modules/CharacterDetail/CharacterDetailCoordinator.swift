import SwiftUI


protocol CharacterDetailCoordinatorParent: AnyObject { }

class CharacterDetailCoordinator: ObservableObject, Identifiable {
    private weak var parent: CharacterDetailCoordinatorParent?

    @Published var viewModel: CharacterDetailViewModel!
    
    init(parent: CharacterDetailCoordinatorParent?, character: RAMCharacter) {
        self.parent = parent
        viewModel = .init(coordinator: self, character: character)
    }
    
}

struct CharacterDetailCoordinatorView: View {
    @ObservedObject var coordinator: CharacterDetailCoordinator
    
    init(coordinator: CharacterDetailCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        CharacterDetailView(viewModel: coordinator.viewModel)
    }
}

