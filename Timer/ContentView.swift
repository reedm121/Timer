//
//  ContentView.swift
//  Counter
//
//  Created by Reed Gantz on 12/2/24.
//

import SwiftUI

struct ContentView: View {
    @State var count: Int = 60
    @State var timerStarted: Bool = false
    @State var timer: Timer?
    
    @State var timerName: String = ""
    @FocusState var timerNameFocused: Bool
    
    //@State var msg: String = ""
    @State var totalTime: Int = 60
    
    var body: some View {
        VStack (spacing: 8){
            TextField("Timer name", text: $timerName)
                .padding()
                .background(Color(.systemGray6))
                .clipShape(Capsule())
                .padding(.horizontal, 64)
                .focused($timerNameFocused)
            
            Text("\(count)s")
                .font(.system(size: 64))
            
            HStack{
                ProgressView(value: CGFloat(count)/CGFloat(totalTime))
                Text("\(totalTime)")
            }
            
            HStack(spacing: 20) {
                //-5s button
                Button {
                    count -= 5
                    totalTime -= 5
                } label: {
                    Text("- 5s")
                        .frame(width: 50, height: 50)
                        .font(.title2)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.circle)
                .disabled(count <= 4)
                
                //+5s button
                Button {
                    count += 5
                    totalTime += 5
                } label: {
                    Text("+ 5s")
                        .frame(width: 50, height: 50)
                        .font(.title2)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.circle)
                
            }.padding(.bottom)
            
            Button(timerStarted ? "Pause" : "Start Timer"){
                if timerStarted{
                    stopTimer()
                }
                else{
                    startTimer()
                }
            }.buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .padding(.bottom)
                .tint(timerStarted ? .red : .blue)
                .disabled(count == 0)
            
        }
        .padding()
    }
    
    func startTimer() {
        timerNameFocused = false
        totalTime = count
        guard !timerStarted else { return } // Prevent multiple timers
        timerStarted = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if count > 0 {
                count -= 1
            } else {
                stopTimer() // Stop the timer when the count reaches 0
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate() // Invalidate the timer
        timer = nil
        timerStarted = false
    }
}

#Preview {
    NavigationView{
        ContentView()
            .navigationTitle("Timer App")
    }
    
}
