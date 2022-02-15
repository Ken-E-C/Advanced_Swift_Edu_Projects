//
//  Step.swift
//  SwiftUIHealthKit
//
//  Created by Kenny Cabral on 2/15/22.
//

import Foundation

struct Step: Identifiable {
    var id = UUID()
    let count: Int
    let date: Date
}
