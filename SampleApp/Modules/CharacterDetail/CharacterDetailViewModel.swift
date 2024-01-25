import SwiftUI
import Combine



class CharacterDetailViewModel: ViewModel, ObservableObject {
    // MARK: Stored Properties
    private unowned let coordinator: CharacterDetailCoordinator
    private var cancellableSet = Set<AnyCancellable>()
    let character: RAMCharacter
    
    
    // MARK: Published Properties
    

    // MARK: Initialization
    init(coordinator: CharacterDetailCoordinator, character: RAMCharacter) {
        self.coordinator = coordinator
        self.character = character
        super.init()
    }
        
    // MARK: Public methods
    override func load() { super.load() }
    override func unload() { super.unload() }

}

// MARK: Private methods
fileprivate extension CharacterDetailViewModel {
    
}
