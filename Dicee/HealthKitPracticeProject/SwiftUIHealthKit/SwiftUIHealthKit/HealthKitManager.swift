//
//  HealthKitManager.swift
//  SwiftUIHealthKit
//
//  Created by Kenny Cabral on 2/14/22.
//

import Foundation
import HealthKit

class HealthKitManager {
    var healthKitStore: HKHealthStore?
    
    lazy var startDate: Date? = {
        return Calendar.current.date(bySetting: .day, value: -7, of: Date())
    }()
    
    lazy var anchorDate: Date? = {
        return Date().mondayAt12AM()
    }()
    
    private lazy var stepType: HKQuantityType? = {
        return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
    }()
    
    init() {
        // NOTE: make sure to do the isHealthDataAvailable check. otherwise you'll risk a crash due to a nil value
        healthKitStore = HKHealthStore.isHealthDataAvailable() ? HKHealthStore() : nil
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        guard let stepType = stepType,
        let healthKitStore = healthKitStore else {
            print("WARNING - Failed to attempt authorization")
            return
        }
        
        healthKitStore.requestAuthorization(toShare: [], read: [stepType], completion: { didComplete, error in
            if let error = error{
                print("ERROR: - Failed to complete authorization \(error)")
            }
            completion(didComplete)
        })
    }
    
    func calculateSteps(completion: @escaping (HKStatisticsCollection?) -> Void) {
        guard let stepType = stepType else {
            print("Warning @ calculateSteps(): unable to get stepType quantity type")
            return
        }
        
        guard let anchorDate = anchorDate else {
            print("Warning @ calculateSteps(): unable to get anchorDate quantity type")
            return
        }
        let daily = DateComponents(day: 1)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        
        let query = HKStatisticsCollectionQuery(quantityType: stepType,
                                    quantitySamplePredicate: predicate,
                                                options: .cumulativeSum,
                                    anchorDate: anchorDate, intervalComponents: daily)
        query.initialResultsHandler = { query, statisticsCollection, error in
            completion(statisticsCollection)
        }
        if let healthKitStore = healthKitStore {
            healthKitStore.execute(query)
        }
    }
}

extension Date {
    func mondayAt12AM() -> Date? {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))
    }
}
