import SwiftUI

struct TimerView: View {
    @State var progressTime: Int = 0
    @State private var timer: Timer?
    @State var timerRunning = false
    @State var date: Date = Date.now

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Session.entity(), sortDescriptors: [])
    private var sessions: FetchedResults<Session>
    
    @EnvironmentObject var appData: AppData
    
    var hour: Int {
        progressTime / 216000
    }
    
    var minutes: Int {
        ( progressTime / 3600 ) % 60
    }
    
    var seconds: Int {
        ( progressTime / 100 ) % 60
    }
    
    var miliseconds: Int {
        progressTime % 100
    }
    
    var body: some View {
        VStack{
            
            HStack() {
                VStack(alignment: .leading){
                    Text("Timer,")
                        .font(.title)
                        .fontWeight(.thin)
                        .foregroundColor(Color.white)
                    
                    Text("\(getStringTime(dateInput: date))")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                    
                }
                Spacer()
            }
            .padding()
            
            ZStack(){
                Circle()
                    .stroke(Color(hex:"181718"), lineWidth: 10)

                HStack() {
                    Text("\(minutes)")
                        .frame(width: 60, height: 50)
                    Text(":")
                    Text("\(minutes)")
                        .frame(width: 60, height: 50)
                    Text(":")
                    Text("\(seconds)")
                        .frame(width: 60, height: 50)
                    Text(".")
                    Text("\(miliseconds)")
                        .frame(width: 60, height: 50)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: 30))
                .foregroundColor(Color.white)
            }
            .padding()
            .frame(minHeight: 200)
            
            Spacer()
            
            HStack{
                Button(action: {
                    if (self.timerRunning == false) {
                        self.timerRunning = true
                        startTimer()
                    }else {
                        self.timerRunning = false
                        self.timer?.invalidate()
                    }
                })
                {
                    Text(timerRunning ? "Pause" : "Start")
                        .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity, minHeight: 44)
                .font(.title)
                .foregroundColor(Color.black)
                .background(Color.white)
                .cornerRadius(12)
                
                Button(action: {
                    appData.rootViewId = UUID()
                    saveSession()
                })
                {
                    Text("Finish")
                        .frame(maxWidth: .infinity)
                    
                }
                .frame(maxWidth: .infinity, minHeight: 44)
                .font(.title)
                .foregroundColor(Color.black)
                .background(Color.white)
                .cornerRadius(12)
            }
            
            Button(
                action: {appData.rootViewId = UUID()}
            )
            {
                Text("Cancel")
            }
            .frame(maxWidth: .infinity, minHeight: 44)
            .font(.title)
            .foregroundColor(Color.black)
            .background(Color.white)
            .cornerRadius(12)
            .buttonStyle(.plain)
            
        }
        .padding()
        .onDisappear {
            timer?.invalidate()
        }
        .background(Color.black)
        Spacer()
        
    }
    
    private func getStringTime(dateInput:Date ) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { _ in
            progressTime += 1
        })
    }
    
    private func saveSession() {
        withAnimation {
            let session = Session(context: viewContext)
            session.time = Int64(progressTime)
            session.date = date
            saveContext()
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("An error occured: \(error)")
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
