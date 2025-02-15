import SwiftUI

struct LoadingScreen: View {
    @State private var isActive = false
    @State private var urlToLoad: URL?
    @AppStorage("isNeeded") private var isNeeded: Bool = false

    var body: some View {
        GeometryReader { geo in
            let isLandscape = geo.size.width > geo.size.height

            ZStack {
                // Экран загрузки отображается, только если isActive == false
                if !isActive {
                    if isLandscape {
                        ZStack {
                            Image(.loadingPic)
                                .resizable()
                                .scaledToFit()
                                .scaleEffect(1.5)
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                    } else {
                        ZStack {
                            Color.black.opacity(0.7)
                                .edgesIgnoringSafeArea(.all)

                            RotateDeviceScreen()
                        }
                    }
                }

                // Основной контент (MenuScreen или BrowserView)
                if isActive {
                    if !isNeeded {
                        if let url = urlToLoad {
                            BrowserView(pageURL: url)
                                .transition(.opacity)
                                .edgesIgnoringSafeArea(.all)
                        }
                    } else {
                        MenuScreen()
                            .transition(.opacity)
                            .edgesIgnoringSafeArea(.all)
                            .frame(width: geo.size.width, height: geo.size.height)
                    }
                }
            }
        }
        .onAppear {
            Task {
                let validURL = await NetworkManager.isURLValid()

                if validURL, let validLink = URL(string: urlForValidation) {
                    self.urlToLoad = validLink
                    withAnimation {
                        isNeeded = true
                        isActive = true
                    }
                } else {
                    self.urlToLoad = URL(string: urlForValidation)
                    withAnimation {
                        isNeeded = false
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    LoadingScreen()
}
