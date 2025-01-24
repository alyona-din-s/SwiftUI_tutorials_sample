//
//  NotificationView.swift
//  SwiftUIProject
//
//  Created by admin_user on 22/01/25.
//

import SwiftUI
import UserNotifications
 import OSLog

struct NotificationView: View {
    @State private var showOfferView = false
    @State private var logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "notification")
    
    var body: some View {
        VStack {
            
            NotificationAskView( logger: $logger)
            Text("Main View")
        }
    }
}
 
struct NotificationAskView: View {
    @State private var permissionGranted: Bool = false
    @State private var showAlert = false
    @Binding var logger:  Logger
    @StateObject private var notificationManager = NotificationManager()

    var body: some View {
        if let lastNotification = notificationManager.lastNotification {
            Text("Last notification: \(lastNotification)")
        }
        Button("Schedule Notification") {
            if permissionGranted {
                createSimpleAlert()
            } else {
                
            }
        }
        .onAppear(){
            requestNotificationPermission()
        }
        .alert("Notification Permission Required", isPresented: $showAlert) {
            Button("Open Settings") {
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
            }
                    Button("Cancel", role: .cancel) {}
        } message: {
            Text("Please allow local notifications in Settings to receive important updates.")
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didReceiveMemoryWarningNotification)) { notification in

        }
    }
     
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                self.permissionGranted = granted
                self.showAlert = !granted

                if granted {
                        UIApplication.shared.registerForRemoteNotifications()
                     logger.info("Granted Permission fro Notification")
                } else {
                    let errorLine : String = error?.localizedDescription ?? "Not Granted Permission for Notification "
                    logger.error("Action failed: \(errorLine)")
                }
            }
        }
    }
    
    func createSimpleAlert(){
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Don't forget to water the plants!"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
                   if let error = error {
                       logger.error("Error scheduling notification: \(error.localizedDescription)")
                   }
               }
    }
    
}

class NotificationManager: ObservableObject {
    @Published var lastNotification: String?
    
    func handleNotification(_ notification: UNNotification) {
        let userInfo = notification.request.content.userInfo

        let content = notification.request.content
        lastNotification = content.body
    }
}


#Preview {
    NotificationView()
}
