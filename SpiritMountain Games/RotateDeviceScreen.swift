import Foundation
import SwiftUI



struct RotateDeviceScreen: View {
    var body: some View {
        GeometryReader { geometry in
            
            
            
            Image(systemName: "rectangle.landscape.rotate")
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .padding()
                .shadow(radius: 10)
                .frame(width: geometry.size.width)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            
            
        }
        .background(
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            )
        
        
        
    }
}



#Preview {
    RotateDeviceScreen()
}
