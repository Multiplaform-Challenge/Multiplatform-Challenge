//
//  MultiplatformChallengeApp.swift
//  Shared
//
//  Created by Rodrigo Matos Aguiar on 18/05/21.
//

import SwiftUI

@main
struct MultiplatformChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                #if os(macOS)
                Sidebar()
                ContentView()
//                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
//                    .frame(minWidth: 500)
                #else
                ContentView()
//                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
//                    .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
                #endif
            }
        }
    }
}
