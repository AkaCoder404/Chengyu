//
//  Helper.swift
//  chinese idiom of the day Watch App
//
//  Created by George Li on 11/29/24.
//

import Foundation

struct VersionInfo {
    static var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }

    static var buildNumber: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
    }
}
