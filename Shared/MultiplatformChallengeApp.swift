//
//  MultiplatformChallengeApp.swift
//  Shared
//
//  Created by Rodrigo Matos Aguiar on 18/05/21.
//

import SwiftUI

@main
struct MultiplatformChallengeApp: App {
    @StateObject var shoppingListVM = ShoppingListViewModel()
    var body: some Scene {
        WindowGroup {
            
                #if os(macOS)
                NavigationView {
                
                Sidebar(shoppingListVM: shoppingListVM)
                ContentView(shoppingListVM: shoppingListVM)
//                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .frame(minWidth: 500)
                }
                #else
                ContentView()
//                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
//                    .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
                #endif
            
        }
    }
}
