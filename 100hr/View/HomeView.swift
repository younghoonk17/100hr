import SwiftUI

struct HomeView: View {
    @State private var goal: String? = "Code an app"

    @EnvironmentObject var appData: AppData
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Session.entity(), sortDescriptors: [])
    private var sessions: FetchedResults<Session>
    
    var body: some View {

        let quotesCount = appData.quotes.count
        let randomInt = Int.random(in: 1..<quotesCount)
        
        let oneQuote = appData.quotes[randomInt]
        
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
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(hex: "181718"))
                .cornerRadius(15)
                
                HStack {
                    NavigationLink(destination: TestView()){
                        Text("Total grind time: ")
                            .font(.title)
                            .foregroundColor(Color.white)
                        Text("\(sessions.map{$0.time}.reduce(0,+))")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "181718"))
                    .cornerRadius(15)
                }

                Spacer()
                
                VStack {
                    NavigationLink(destination: TimerView().navigationBarBackButtonHidden(true)){
                        Text("Grind")
                            .font(.title)
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity)
                    }
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
            .environmentObject(AppData())

    }
}

