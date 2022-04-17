//
//  Meal.swift
//  Kitchen_Space_SwiftUI
//
//  Created by Arjun Doel on 17/04/2022.
//

import Foundation

struct Response: Codable {
    var meals: [Meal]
}

struct Meal: Codable {
    let idMeal: String
    let strMeal: String
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strYoutube: String
    let strIngredients1: String
    let strIngredients2: String
    let strIngredients3: String
    let strIngredients4: String
    let strIngredients5: String
    let strIngredients6: String
    let strIngredients9: String
    let strIngredients10: String
    let strIngredients11: String
    let strIngredients12: String
    let strIngredients13: String
    let strIngredients14: String
    let strIngredients15: String
    let strIngredients16: String
    let strIngredients17: String
    let strIngredients18: String
    let strIngredients19: String
    let strIngredients20: String
    let strSource: String
}
