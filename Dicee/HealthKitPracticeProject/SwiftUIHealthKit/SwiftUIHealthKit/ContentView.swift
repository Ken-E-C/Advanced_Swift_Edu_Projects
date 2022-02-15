//
//  ContentView.swift
//  SwiftUIHealthKit
//
//  Created by Kenny Cabral on 2/14/22.
//

import SwiftUI
import CoreData
import HealthKit

struct ContentView: View {
    
    private var healthKitManager: HealthKitManager?
    @State private var steps: [Step] = [Step]()
    
    init() {
        healthKitManager = HealthKitManager()
    }
    var body: some View {
        Text("Hello World")
            .onAppear {
                healthKitManager?.requestAuthorization(completion: handleRequestAuthorization)
            }
    }
    
    
    // MARK: - Helper Functions

    private func handleRequestAuthorization(didSucceed: Bool) {
        if didSucceed {
            healthKitManager?.calculateSteps(completion: { stats in
                guard let stats = stats else { return }
                print("\(stats)")
                updateUIFromStatistics(stats)
            })
        }
    }
    
    private func updateUIFromStatistics(_ stats: HKStatisticsCollection) {
        guard let startDate = healthKitManager?.startDate else { return }
        stats.enumerateStatistics(from: startDate, to: Date()) { stat, stop in
            let count = stat.sumQuantity()?.doubleValue(for: .count())
            
            let step = Step(count: Int(count ?? 0), date: stat.startDate)
            steps.append(step)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
    }
}
