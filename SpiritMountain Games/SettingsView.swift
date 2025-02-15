import SwiftUI

struct SettingsView: View {
    

    var body: some View {
        GeometryReader { geometry in
            var isLandscape = geometry.size.width > geometry.size.height
            ZStack {
                if isLandscape {
                    VStack {
                        Image(.plateSettings)
                            .resizable()
                            .scaledToFit()
                            .overlay(
                                ZStack {
                                    VStack(spacing: -50) {
                                        Image(.settingsText)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 180, height: 120)
                                        
                                        Image(.rateusButton)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 180, height: 120)
                                            .onTapGesture {
                                                openURLInSafari(urlString: openAppURL)
                                            }
                                        
                                        Image(.contactusButton)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 180, height: 120)
                                            .onTapGesture {
                                                NavPanel.shared.currentScreen = .CONTACTUS
                                            }
                                        
                                        Image(.shareButton)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 180, height: 120)
                                            .onTapGesture {
                                                openURLInSafari(urlString: openAppURL)
                                            }
                                    }
                                }
                            )
                    }
                } else {
                    ZStack {
                        Color.black.opacity(0.7)
                            .edgesIgnoringSafeArea(.all)
                        
                        RotateDeviceScreen()
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .scaleEffect(1.1)
            )
            .overlay(
                ZStack {
                    Image(.back)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70)
                        .position(x: geometry.size.width / 9, y: geometry.size.height / 9)
                        .onTapGesture {
                            NavPanel.shared.currentScreen = .MENU
                        }
                }
            )


        }
    }
}

extension SettingsView {
    func openURLInSafari(urlString: String) {
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Не удалось открыть URL: \(urlString)")
            }
        } else {
            print("Неверный формат URL: \(urlString)")
        }
    }
}







#Preview {
    SettingsView()
}

