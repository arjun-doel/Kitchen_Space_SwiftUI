//
//  MealViewModel.swift
//  Kitchen_Space_SwiftUI
//
//  Created by Arjun Doel on 17/04/2022.
//

import Foundation

@MainActor
class MealsViewModel: ObservableObject {
    
    @Published var meals: [Meal] = []
    
    //Typeahead search key
    @Published var searchTerm: String = ""
    
    // Fetch data from URL
    func getData(searchItem: String) async {
        // Contains api link
        let urlString = "www.themealdb.com/api/json/v1/1/search.php?s=\(searchItem.isEmpty ? searchItem : "chicken"))"
        // Attempt to wrap api link in a URL
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        // Attempt to call api
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                self.meals = decodedResponse.meals
            }
        } catch {
            print("oops, something went wrong...")
        }
    }
    
}
