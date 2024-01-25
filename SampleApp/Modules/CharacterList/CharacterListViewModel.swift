import SwiftUI
import Combine

class CharacterListViewModel: ViewModel, ObservableObject {
    // MARK: Stored Properties
    private unowned let coordinator: CharacterListCoordinator
    private var cancellableSet = Set<AnyCancellable>()
    private let ramDataInteractor: RAMDataInteractor
    private(set) var nextPage = 1
    
    // MARK: Published Properties
    @Published var charactersList = [RAMCharacter]()
    

    // MARK: Initialization
    init(coordinator: CharacterListCoordinator, ramDataInteractor: RAMDataInteractor) {
        self.coordinator = coordinator
        self.ramDataInteractor = ramDataInteractor
        super.init()
    }
        
    // MARK: Public methods
    override func load() { super.load() }
    override func unload() { super.unload() }
    
    func getNextPage() async {
        guard !isLoading else { return }
        do {
            self.isLoading = true
            let response = try await ramDataInteractor.getRAMCharacterList(page: nextPage)
            await MainActor.run {
                var newList = self.charactersList
                newList.append(contentsOf: response.results)
                self.charactersList = newList
                nextPage += 1
                self.isLoading = false
            }
        }
        catch {
            print("Show error \(error)")
            //TODO: Manage error properly
            await MainActor.run { self.isLoading = false }
        }
    }
    
    func onTap(character: RAMCharacter) {
        coordinator.openDetail(character: character)
    }

}

// MARK: Private methods
fileprivate extension CharacterListViewModel {
    
}
