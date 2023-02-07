
import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


struct HomeView: View {
    @State private var goal: String? = "Code an app"
    @ObservedObject var data = Data()
//    @EnvironmentObject var data: Data
    
    var body: some View {
        
        let quotesCount = data.quotes.count
        let randomInt = Int.random(in: 1..<quotesCount)
        
        let oneQuote = data.quotes[randomInt]
        let totalTime = String(data.totalTime)
        
        NavigationView {
            VStack {
                
                if(goal != nil) {
                    HStack() {
                        VStack(alignment: .leading){
                            Text("Goal,")
                                .font(.title)
                                .fontWeight(.thin)
                                .foregroundColor(Color.white)
                            
                            Text(goal!)
                                .font(.largeTitle)
                                .foregroundColor(Color.white)
                            
                        }
                        Spacer()
                    }
                    .padding()
                    
                }else {
                    HStack() {
                        VStack(alignment: .leading){
                            
                            Text("Lets set some goals")
                                .font(.largeTitle)
                                .foregroundColor(Color.white)
                            
                        }
                        Spacer()
                    }
                    .padding()
                }
                
                
                VStack {
                    Text(oneQuote)
                        .foregroundColor(Color.white)
                }
                .padding()
                .padding(5)
                .background(Color(hex: "181718"))
                .cornerRadius(15)
                
                
                VStack {
                    Text(totalTime)
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                }
                .padding()
                .padding(5)
                .background(Color(hex: "181718"))
                .cornerRadius(15)
                
                
                Spacer()
                
                
                VStack {
                    NavigationLink(destination: TimerView().navigationBarBackButtonHidden(true)) {
                        Text("Grind")
                            .font(.title)
                            .foregroundColor(Color.black)
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                .padding()
                .padding(5)
                .background(Color.white)
                .cornerRadius(15)
                
            }
            .background(Color.black)
            Spacer()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        HomeView()
    }
}

