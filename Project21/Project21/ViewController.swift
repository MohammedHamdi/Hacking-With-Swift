//
//  ViewController.swift
//  Project21
//
//  Created by Mohammed Hamdi on 9/16/19.
//  Copyright © 2019 Mohammed Hamdi. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
    }

    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
    }
    
    @objc func scheduleLocal() {
        registerCategories()
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more...", options: .foreground)
        let remindLater = UNNotificationAction(identifier: "remindLater", title: "Remind me later", options: .destructive)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show, remindLater], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                // the user swiped to unlock
                print("Default identifier")
                let ac = UIAlertController(title: "Default", message: "You swiped on the notification.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
                
            case "show":
                //the user tapped our "Tell me more..." button
                print("Show me more information...")
                let ac = UIAlertController(title: "Tell me more", message: "You clicked tell me more.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Horay", style: .default))
                present(ac, animated: true)
                
            case "remindLater":
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: false)
                let content = response.notification.request.content
                let request = UNNotificationRequest(identifier: "alarm", content: content, trigger: trigger)
                center.add(request)
                
            default:
                break
            }
        }
        
        // you must call the completion handler when you're done
        completionHandler()
    }
}

