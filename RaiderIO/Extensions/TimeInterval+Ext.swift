//
//  TimeInterval.swift
//  RaiderIO
//
//  Created by baris on 10.03.2022.
//

import Foundation

extension TimeInterval {
    var hourMinuteSecondMS: String {
        String(format:"%02d:%02d", minute, second)
    }
    var minuteSecondMS: String {
        String(format:"%d:%02d", minute, second)
    }
    var minute: Int {
        Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        Int(truncatingRemainder(dividingBy: 60))
    }
}
