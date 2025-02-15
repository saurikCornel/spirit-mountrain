import Foundation


enum AvailableScreens {
    case MENU
    case LOADING
    case RULES
    case SETTINGS
    case GAME
    case CONTACTUS
    case GAMESECOND

}

class NavPanel: ObservableObject {
    @Published var currentScreen: AvailableScreens = .LOADING
    static var shared: NavPanel = .init()
}

