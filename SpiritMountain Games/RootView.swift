import Foundation
import SwiftUI


struct RootView: View {
    @ObservedObject var nav: NavPanel = NavPanel.shared
    var body: some View {
        switch nav.currentScreen {
                                        
        case .MENU:
            MenuScreen()
        case .LOADING:
            LoadingScreen()
        case .GAME:
            GameView()
        case .RULES:
            RulesView()
        case .SETTINGS:
            SettingsView()
        case .CONTACTUS:
            ContactUsScreen()
        case .GAMESECOND:
            GameSecondView()
        }

    }
}
