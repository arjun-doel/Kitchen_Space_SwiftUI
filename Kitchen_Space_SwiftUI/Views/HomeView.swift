//
//  HomeView.swift
//  Kitchen_Space_SwiftUI
//
//  Created by Arjun Doel on 17/04/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var mealVM: MealsViewModel
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Spacer()
                textSearch
                cardStack
            }
            .background(LinearGradient(colors: [.orange, .red], startPoint: .top, endPoint: .bottom))
            .navigationBarTitle("Kitchen Space Test")
            .sheet(item: $mealVM.sheetMeal) { meal in
                DetailView(meal: meal)
            }
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
            .textFieldStyle(.plain)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .padding()
    }
    
    private var cardStack: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(mealVM.meals) { meal in
                    CardView(meal: meal)
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
}
