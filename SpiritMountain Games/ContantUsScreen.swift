import SwiftUI
import WebKit

// Основной экран с WebView
struct ContactUsScreen: View {
    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.all)

            WebView(url: contactUs)

            HStack {
                VStack {
                    Button {
                        NavPanel.shared.currentScreen = .MENU
                    } label: {
                        Image("back")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    Spacer()
                }
                .padding()
                Spacer()
            }
        }
        
    }
}

#Preview {
    ContactUsScreen()
}
