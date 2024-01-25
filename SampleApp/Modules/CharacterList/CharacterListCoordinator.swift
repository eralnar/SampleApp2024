import SwiftUI


protocol CharacterListCoordinatorParent: AnyObject { }

class CharacterListCoordinator: ObservableObject, Identifiable {
    private weak var parent: CharacterListCoordinatorParent?

    @Published var viewModel: CharacterListViewModel!
    
    init(parent: CharacterListCoordinatorParent?, ramDataInteractor: RAMDataInteractor) {
        self.parent = parent
        self.viewModel = .init(coordinator: self, ramDataInteractor: ramDataInteractor)
    }
    
}

struct CharacterListCoordinatorView: View {
    @ObservedObject var coordinator: CharacterListCoordinator
    
    init(coordinator: CharacterListCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        CharacterListView(viewModel: coordinator.viewModel)
    }
}

