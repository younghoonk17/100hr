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
                        .padding()
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "181718"))
                        .cornerRadius(12)
                        .padding([.bottom, .trailing, .leading])
                }

                HStack {
                    NavigationLink(destination: DetailView()){
                        VStack {
                            Text("Total grind time ")
                                .font(.subheadline)
                            
                            Text("\(sessions.map{$0.time}.reduce(0,+))")
                                .font(.largeTitle)
                            Text("hours")
                                .font(.caption)
                        }
                        .padding([.bottom, .top], 20)
                    }
                    .font(.title3)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, minHeight: 66)
                    .background(Color(hex: "181718"))
                    .cornerRadius(12)
                    .padding([.bottom, .leading])
                    
                    NavigationLink(destination: DetailView()){
                        VStack {
                            Text("Total grind sessions ")
                                .font(.subheadline)
                            Text("\(sessions.map{$0.time}.count)")
                                .font(.largeTitle)
                            Text("sessions")
                                .font(.caption)
                        }
                        .padding([.bottom, .top], 20)
                    }
                    .font(.title3)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, minHeight: 66)
                    .background(Color(hex: "181718"))
                    .cornerRadius(12)
                    .padding([.bottom, .trailing, .leading])
                }
                
                VStack {
                    VStack{
                        Text("Streak counter")
                            .font(.title3)
                        Text("\(sessions.map{$0.time}.count)X")
                            .font(.largeTitle)

                    }
                    .padding()

                }
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity, minHeight: 66)
                .background(Color(hex: "181718"))
                .cornerRadius(12)
                .padding([.bottom, .trailing, .leading])


                Spacer()
                
                VStack {
                    NavigationLink(destination: TimerView().navigationBarBackButtonHidden(true)){
                        Text("Grind")
                            .font(.title3)
                            .foregroundColor(Color.black)
                    }
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding()
                }

            }
            .background(Color.black)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AppData())

    }
}

