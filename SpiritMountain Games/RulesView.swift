import SwiftUI

struct RulesView: View {
    

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
                                    VStack(spacing: -80) {
                                        Image(.rulesHead)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 140, height: 120)
                                        
                                        Image(.rulesText)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 320, height: 240)
                                    
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





#Preview {
    RulesView()
}

