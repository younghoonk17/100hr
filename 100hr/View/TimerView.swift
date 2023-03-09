import SwiftUI

struct TimerView: View {
    @State var progressTime = 0
    @State private var timer: Timer?
    @State var timerRunning = false
    
    @EnvironmentObject var appData: AppData
    
    @State var shouldAnimate = false
    
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
            
            VStack(spacing: 50){
                HStack {
                    Circle()
                        .fill(Color.init(hex: "01327C"))
                        .frame(width: 50, height: 20)
                        .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                        .animation(shouldAnimate ? Animation.easeInOut(duration: 0.5).repeatForever().delay(0) : Animation.default)
                    Circle()
                        .fill(Color.init(hex: "01327C"))
                        .frame(width: 50, height: 20)
                        .scaleEffect(shouldAnimate ? 1.0 : 0.5)
//                        .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.3), value: shouldAnimate)
                        .animation(shouldAnimate ? Animation.easeInOut(duration: 0.5).repeatForever().delay(0.3) : Animation.default)

                    Circle()
                        .fill(Color.init(hex: "01327C"))
                        .frame(width: 50, height: 20)
                        .scaleEffect(shouldAnimate ? 1.0 : 0.5)
//                        .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.6), value: shouldAnimate)
                        .animation(shouldAnimate ? Animation.easeInOut(duration: 0.5).repeatForever().delay(0.6) : Animation.default)

                }
                
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
            .frame(minHeight: 200)
            .padding()
            .padding(5)
            .background(Color(hex: "181718"))
            .cornerRadius(15)
            
            Spacer()
            
            HStack{
                Button(action: {
                    if (self.timerRunning == false) {
                        self.timerRunning = true
                        self.shouldAnimate = true
                        startTimer()
                    }else {
                        self.timerRunning = false
                        self.shouldAnimate = false
                        self.timer?.invalidate()
                    }
                })
                {
                    Text(timerRunning ? "Pause" : "Start")
                        .frame(maxWidth: .infinity)
                }
                .font(.title)
                .foregroundColor(Color.black)
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                
                Button(action: {
                    appData.progressTime += progressTime
                    appData.rootViewId = UUID()
                })
                {
                    Text("Finish")
                        .frame(maxWidth: .infinity)
                    
                }
                .font(.title)
                .foregroundColor(Color.black)
                .padding()
                .background(Color.white)
                .cornerRadius(15)
            }
            
            Button(
                action: {appData.rootViewId = UUID()}
            )
            {
                Text("Cancel")
                    .frame(maxWidth: .infinity)
            }
            .font(.title)
            .foregroundColor(Color.black)
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .buttonStyle(.plain)
            
        }
        .onDisappear {
            timer?.invalidate()
        }
        .background(Color.black)
        Spacer()
        
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { _ in
            progressTime += 1
        })
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
