//
//  ContentView.swift
//  FastingTimer
//
//  Created by abdallah negm on 09/05/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var fastingManager = FastingManager()
    
    var title: String {
        switch fastingManager.fastingState {
        case .fasting:
            return "You are now Fasting"
        case .feeding:
            return "You are now Feeding"
        case .notStarted:
            return ""
        }
    }
    
    var body: some View {
        ZStack {
            // MARK: Background
            
            Color(#colorLiteral(red: 0.05506101627, green: 0, blue: 0.1144057765, alpha: 1))
                .ignoresSafeArea()
            
            content
        }
    }
    
    var content: some View {
        ZStack {
            VStack(spacing: 65) {
                //MARK: Title
                
                
                //MARK: Fasting Plan
                
                Text(fastingManager.fastingPlan.rawValue)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                
                
                    
                //MARK: Progress Ring
                
                ProgressRing()
                    .environmentObject(fastingManager)
                
                HStack(spacing: 60) {
                    //MARK: Start time
                    
                    VStack(spacing: 5) {
                        Text(fastingManager.fastingState == .notStarted ? "Start" : "Started")
                            .opacity(0.7)
                        
                        Text(fastingManager.startTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    }
                    
                    //MARK: End time
                    
                    VStack(spacing: 5) {
                        Text(fastingManager.fastingState == .notStarted ? "End" : "Ends")
                            .opacity(0.7)
                        
                        Text(fastingManager.endTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    }
                }
                //MARK: Button
                
                Button {
                    fastingManager.toggleFastingState()
                } label: {
                    Text(fastingManager.fastingState == .fasting ? "End fast" : "Start Fasting")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                }

            }
            .padding()
        }
        .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
