import SwiftUI
import WebKit
import UIKit


// WebViewWrapper для отображения URL в WebView
struct WebView: UIViewRepresentable {
    var url: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero)
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

// Основной экран с WebView и анимацией загрузки
struct GameView: View {
    @State private var isWebViewLoaded = false // Состояние для управления загрузкой
    
    var body: some View {
        GeometryReader { geo in
            let isLandscape = geo.size.width > geo.size.height
            
            if isLandscape {
                ZStack {
                    Color(hex: "#59A16A")
                        .edgesIgnoringSafeArea(.all)
                    
                    // Показываем WebView всегда, но скрываем его под черным экраном во время загрузки
                    WebView(url: "https://plays.org/game/clempire/")
                        .opacity(isWebViewLoaded ? 1 : 0) // Скрываем WebView, пока загрузка не завершена
                    
                    if !isWebViewLoaded {
                        ZStack {
                            Color(hex: "#59A16A")
                                .edgesIgnoringSafeArea(.all)
                            
                            // Отображаем GIF-анимацию
                            VStack {
                                Spacer()
                                
                                GIFView(gifName: "anima") // Замените "anima" на имя вашего GIF-файла
                                    .frame(width: 150, height: 150) // Настройте размер анимации
                                
                                Spacer()
                            }
                            .onAppear {
                                // Через 5 секунд показываем WebView
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                    withAnimation {
                                        self.isWebViewLoaded = true
                                    }
                                }
                            }
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                    }
                    
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
            } else {
                RotateDeviceScreen()
            }
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex)
        
        // Пропускаем символ `#`, если он есть
        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hex.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}



// UIViewRepresentable для отображения GIF-анимации
struct GIFView: UIViewRepresentable {
    var gifName: String
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        
        if let gifURL = Bundle.main.url(forResource: gifName, withExtension: "gif"),
           let gifData = try? Data(contentsOf: gifURL),
           let source = CGImageSourceCreateWithData(gifData as CFData, nil) {
            
            var images = [UIImage]()
            let imageCount = CGImageSourceGetCount(source)
            
            for i in 0..<imageCount {
                if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                    images.append(UIImage(cgImage: cgImage))
                }
            }
            
            let imageView = UIImageView()
            imageView.animationImages = images
            imageView.animationDuration = Double(imageCount) / 30.0 // 30 FPS
            imageView.animationRepeatCount = 0 // Бесконечная анимация
            imageView.startAnimating()
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(imageView)
            
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
                imageView.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

#Preview {
    GameView()
}
