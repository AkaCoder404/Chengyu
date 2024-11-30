//
//  IdiomNotifications.swift
//  chinese idiom of the day Watch App
//
//  Created by George Li on 11/29/24.
//

import Foundation
import UserNotifications

func requestNotificationPermission() {
	UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in 
		if let error = error {
			print("Error requesting notification permission: \(error)")
		}
	}
}

func scheduleNotificationsIfAllowed() {
    UNUserNotificationCenter.current().getNotificationSettings { settings in
        if settings.authorizationStatus == .authorized {
            // Schedule the notification
            scheduleDailyIdiomNotification()
        } else {
            print("Notifications are not authorized.")
        }
    }
}

// Schedule daily notification
func scheduleDailyIdiomNotification() {
    let idiom = getDailyIdioms().first ?? placeHolderIdiom()

    let content = UNMutableNotificationContent()
    content.title = "Idiom of the Day"
    content.body = "\(idiom.idiom) \(idiom.pinyin) : \(idiom.translation)"
    content.sound = .default

    // Original daily schedule (commented out for testing)
     var dateComponents = DateComponents()
     dateComponents.hour = 8 // Schedule for 8 AM
     let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

    // Testing: Trigger notification in 1 minute
//    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
    
    let request = UNNotificationRequest(identifier: "dailyIdiomTest", content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("Error scheduling notifications \(error)")
        } else {
            print("Test notification scheduled successfully!")
        }
    }
}
