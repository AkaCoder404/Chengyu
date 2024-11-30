//
//  chinese_idiom_of_the_dayApp.swift
//  chinese idiom of the day Watch App
//
//  Created by George Li on 11/24/24.
//

import SwiftUI

@main
struct chinese_idiom_of_the_day_Watch_AppApp: App {
    init() {
        // Request notification permission on app launch
        requestNotificationPermission()
        
        // Schedule daily notifications
        scheduleNotificationsIfAllowed()
    }
        
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


