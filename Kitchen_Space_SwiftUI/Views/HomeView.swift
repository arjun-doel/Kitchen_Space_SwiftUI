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
            VStack() {
                Spacer()
                Spacer()
                Spacer()
                textSearch
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(mealVM.meals) { meal in
                            Text(meal.strMeal)
                        }
                    }
                }
                .onChange(of: mealVM.searchTerm, perform: { value in
                    Task {
                        await mealVM.getData(searchItem: value)
                    }
                })
                .task {
                    await mealVM.getData(searchItem: "")
                }
            }
            .navigationTitle("Kitchen Space")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(MealsViewModel())
            .previewInterfaceOrientation(.portrait)
    }
}

extension HomeView {
    private var textSearch: some View {
        TextField("Search for meal...", text: $mealVM.searchTerm)
            .padding()
            .textFieldStyle(.roundedBorder)
            .shadow(color: .gray, radius: 12, x: 0, y: 1)
    }
}
