//
//  FastingManager.swift
//  FastingTimer
//
//  Created by abdallah negm on 10/05/2023.
//

import Foundation

enum FastingState {
    case notStarted
    case fasting
    case feeding
    
}

enum FaastingPlan: String {
    case beginner = "12:12"
    case intermediate = "16:8"
    case advanced = "20:4"
    
    var fastingPeriod: Double {
        switch self {
        case .beginner:
            return 12
        case .intermediate:
            return 16
        case .advanced:
            return 20
        }
    }
}

class FastingManager: ObservableObject {
    @Published private(set) var fastingState: FastingState = .notStarted
    @Published private(set) var fastingPlan: FaastingPlan = .intermediate
    @Published private(set) var startTime: Date {
        didSet { print("scheduledTime", startTime.formatted(.dateTime.month().day().hour().minute().second()))
            if fastingState == .fasting {
                endTime = startTime.addingTimeInterval(fastingTime)
            } else {
                endTime = startTime.addingTimeInterval(feedingTime)
            }
        }
    }
    @Published private(set) var endTime: Date {
        didSet {
            print("endTime", endTime.formatted(.dateTime.month().day().hour().minute().second()))
        }
    }
    
    @Published private(set) var elapsed: Bool = false
    @Published private(set) var elapsedTime: Double = 0.0
    @Published private(set) var progress: Double = 0.0
    
    var fastingTime: Double {
        return fastingPlan.fastingPeriod * 60 * 60
    }
    var feedingTime: Double {
        return (24 - fastingPlan.fastingPeriod) * 60 * 60
    }
    
    init() {
        let calender = Calendar.current
        
//        var components = calender.dateComponents([.year, .month, .day, .hour], from: Date())
//        components.hour = 20
//        print(components)
//
//        let scheduledTime = calender.date(from: components) ?? Date.now
//
//        print("scheduledTime", scheduledTime.formatted(.dateTime.month().day().hour().minute().second()))
//
        
        let components = DateComponents(hour: 20)
        
        let scheduledTime = calender.nextDate(after: .now, matching: components, matchingPolicy: .nextTime)!
        print("scheduledTime", scheduledTime.formatted(.dateTime.month().day().hour().minute().second()))
        
        
        startTime = scheduledTime
        endTime = scheduledTime.addingTimeInterval(FaastingPlan.intermediate.fastingPeriod * 60 * 60)
    }
    
    func toggleFastingState() {
        fastingState = fastingState == .fasting ? .feeding : .fasting
        startTime = Date()
        elapsedTime = 0.0
    }
    
    func truck() {
        guard fastingState != .notStarted else { return }
        print("now", Date().formatted(.dateTime.month().day().hour().minute().second()))
        
        if endTime >= Date() {
            print("Not elapsed")
            elapsed = false
        } else {
            print("elapsed")
            elapsed = true
        }
        elapsedTime += 1
        print("elapsedTime" , elapsedTime)
        
        let totalTime = fastingState == .fasting ? fastingTime : feedingTime
        progress = (elapsedTime / totalTime * 100).rounded() / 100
        print("progress" , progress)
    }
}


