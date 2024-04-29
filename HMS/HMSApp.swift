//
//  HMSApp.swift
//  HMS
//
//  Created by Avya Rathod on 18/04/24.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

enum userType: String {
    case patient
    case admin
    case doctor
    case unknown
}

class UserTypeManager: ObservableObject {
    @Published var userType: userType = .unknown
    @Published var userID: String = ""
}


@main
struct HMSApp: App {
    @StateObject var userTypeManager = UserTypeManager()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
                    if userTypeManager.userType == .unknown {
                        LoginView(userTypeManager: userTypeManager) // Pass UserTypeManager here
                    } else {
                        MainTabs()
                            .environmentObject(userTypeManager)
                    }
                }
    }
}


struct MainTabs: View {
    @EnvironmentObject var userTypeManager: UserTypeManager
    
    var body: some View {
        NavigationStack{
            switch userTypeManager.userType {
            case .patient:
                Patient()
            case .admin:
                Admin()
            case .doctor:
                Doc()
            case .unknown:
                ContentView()
            }
        }
    }
}
