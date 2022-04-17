//
//  Kitchen_Space_SwiftUIApp.swift
//  Kitchen_Space_SwiftUI
//
//  Created by Arjun Doel on 17/04/2022.
//

import SwiftUI

@main
struct Kitchen_Space_SwiftUIApp: App {
    @StateObject private var mealVM = MealsViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(mealVM)
        }
    }
}
