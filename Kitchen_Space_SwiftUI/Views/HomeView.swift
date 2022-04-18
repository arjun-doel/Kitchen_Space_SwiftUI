//
//  HomeView.swift
//  Kitchen_Space_SwiftUI
//
//  Created by Arjun Doel on 17/04/2022.
//

import SwiftUI
import CardStack

struct HomeView: View {
    @EnvironmentObject private var mealVM: MealsViewModel
    @State var reloadToken = UUID()
    
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
            .navigationBarTitle("Kitchen Space")
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
            .submitLabel(.done)
    }
    
    private var cardStack: some View {
        VStack(alignment: .center) {
            CardStack(
              direction: EightDirections.direction, // See below for directions
              data: mealVM.meals.shuffled(),
              onSwipe: { card, direction in // Closure to be called when a card is swiped.
                print("Swiped \(card) to \(direction)")
              },
              content: { card, direction, isOnTop in // View builder function
                CardView(meal: card)
              }
            )
            .id(reloadToken)
            .navigationBarItems(trailing:
                  Button(action: {
                    self.reloadToken = UUID()
                    mealVM.meals = mealVM.meals.shuffled()
                  }) {
                    Text("Reload")
                          .fontWeight(.light)
                          .foregroundColor(.white)
                  }
                )
            .environment(\.cardStackConfiguration, CardStackConfiguration(
              maxVisibleCards: 6,
              swipeThreshold: 0.1,
              cardOffset: 40,
              cardScale: 0.2,
              animation: .linear
            ))
        }
        .padding(20)
        .offset(y: 25)
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
