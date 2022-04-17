//
//  MealViewModel.swift
//  Kitchen_Space_SwiftUI
//
//  Created by Arjun Doel on 17/04/2022.
//

import Foundation

@MainActor
class MealsViewModel: ObservableObject {
    
    // All Meals from api
    @Published var meals: [Meal] = []
    
    //Typeahead search key
    @Published var searchTerm: String = ""
    
    // Fetch data from URL
    func getData(searchItem: String) async {
        // check if search key filled
        let key = searchItem.isEmpty ? "Chicken" : searchItem
        let url = "https://www.themealdb.com/api/json/v1/1/search.php?s=\(key)"
        
        // check validity of URL string
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        
        do {
            // Get data from URL
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                self.meals = decodedResponse.meals
            }
        } catch {
            print("Invalid data")
        }
    }
    
}
