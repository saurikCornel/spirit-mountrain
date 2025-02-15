import SwiftUI
import WebKit



// Основной экран с WebView
struct GameSecondView: View {
    @State private var isWebViewLoaded = false // Состояние для управления загрузкой
    var body: some View {
                GeometryReader { geo in
                    let isLandscape = geo.size.width > geo.size.height
                   if isLandscape {
                       ZStack {
                           Color(hex: "#59A16A")
                               .edgesIgnoringSafeArea(.all)
                           
                           // Показываем WebView всегда, но скрываем его под черным экраном во время загрузки
                           WebView(url: "https://plays.org/game/mountain-rider/")
                               .edgesIgnoringSafeArea(.all)
                               .scaleEffect(1.4)
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



#Preview {
    GameSecondView()
}
