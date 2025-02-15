import SwiftUI
import SwiftData

struct MenuScreen: View {
    

    var body: some View {
        GeometryReader { geometry in
            var isLandscape = geometry.size.width > geometry.size.height
            ZStack {
                if isLandscape {
                    VStack {
                        HStack {
                            Image(.logo)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 240, height: 120)
                        }
                        HStack {
                            ButtonTemplateSmall(image: "rulesButton", action: {NavPanel.shared.currentScreen = .RULES})
                            VStack {
                                ButtonTemplateSmall(image: "game1", action: {NavPanel.shared.currentScreen = .GAME})
                                
                                ButtonTemplateSmall(image: "game2", action: {NavPanel.shared.currentScreen = .GAMESECOND})
                            }
                            ButtonTemplateSmall(image: "settingsButton", action: {NavPanel.shared.currentScreen = .SETTINGS})
                        }
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

        }
    }
}



struct ButtonTemplate: View {
    var image: String
    var action: () -> Void

    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 90)
                .cornerRadius(10)
                .shadow(radius: 10)
//
//            Text(text)
//                .foregroundColor(.white)
//                .fontWeight(.heavy)
//                .font(.title3)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.2)) {
                action()
            }
        }
    }
}

struct ButtonTemplateSmall: View {
    var image: String
    var action: () -> Void

    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 90)
                .cornerRadius(10)
                .shadow(radius: 10)
//
//            Text(text)
//                .foregroundColor(.white)
//                .fontWeight(.heavy)
//                .font(.title3)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.2)) {
                action()
            }
        }
    }
}

#Preview {
    MenuScreen()
}

