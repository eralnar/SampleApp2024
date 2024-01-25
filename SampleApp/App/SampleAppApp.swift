import SwiftUI

@main
struct SampleAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            NavigationView {
                CharacterListCoordinatorView(coordinator: CharacterListCoordinator(parent: nil, ramDataInteractor: Network.shared))
            }
        }
    }
}
