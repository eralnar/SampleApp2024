import SwiftUI
import Combine

/**
 This a common class to inherit from in every ViewModel, also, you will need to implement ObservableObject protocol to make their @Published variables work.
 We can't implement ObservableObject in here due to a known issue affecting iOS 14 and below: https://stackoverflow.com/questions/57615920/published-property-wrapper-not-working-on-subclass-of-observableobject/67189887#67189887
 */

class ViewModel: NSObject {
    
    @Published var isLoading: Bool = false
    private var cancellableSet = Set<AnyCancellable>()
    
    override init() {
        super.init()
    }
    
    var screenName: String {
        return "SwiftUI-\(Self.self)"
    }
    
    func load() {
        print(screenName + " Loaded")
    }
    
    func unload() {
        print(screenName + " Unloaded")
    }
    
    func goToSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL)
        }
    }

}

