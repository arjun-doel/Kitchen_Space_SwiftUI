//
//  HomeView.swift
//  Kitchen_Space_SwiftUI
//
//  Created by Arjun Doel on 17/04/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var mealVM: MealsViewModel

    var body: some View {
        NavigationView {
            ZStack {
                TextField("Search for meal", text: $mealVM.searchTerm)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .shadow(color: .gray, radius: 12, x: 0, y: 1)
                
                Spacer()
            }
            .navigationTitle("Kitchen Space")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(MealsViewModel())
    }
}
