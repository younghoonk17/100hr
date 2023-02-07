//
//  TimerView.swift
//  100hr
//
//  Created by young hoon kim on 4/02/23.
//

import SwiftUI

struct TimerView: View {
    @State private var progressTime = 0
    @State private var timer: Timer?
    var hours: Int {
        progressTime / 3600
    }
    
    var minutes: Int {
        (progressTime % 3600) / 60
    }
    
    var seconds: Int {
        progressTime % 60
    }
    
    var body: some View {
        VStack{
            Text("\(hours):\(minutes):\(seconds)")
                .font(.largeTitle)
            
        }
        .onAppear(perform: startTimer)
        
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            progressTime += 1
        })
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        
        VStack {
            
            TimerView()
            
            VStack {
//                NavigationLink(destination: HomeView().id(<#T##id: Hashable##Hashable#>)) {
//                    Text("Grind")
//                        .font(.title)
//                        .foregroundColor(Color.black)
//                }
//                .frame(maxWidth: .infinity)
                
            }
            .padding()
            .padding(5)
            .background(Color.white)
            .cornerRadius(15)
            
        }
        
        
    }
}
