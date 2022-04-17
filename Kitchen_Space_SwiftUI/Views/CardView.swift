//
//  CardView.swift
//  Kitchen_Space_SwiftUI
//
//  Created by Arjun Doel on 17/04/2022.
//

import SwiftUI
import CachedAsyncImage

struct CardView: View {
    var meal: Meal
    
    var body: some View {
        VStack(alignment: .leading) {
            CachedAsyncImage(url: URL(string: meal.strMealThumb), content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350, height: 500)
                    .clipped()
            }, placeholder: {
                ProgressView()
            })
            .offset(y: -100)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(meal.strMeal)
                    .font(.headline)
                Text(meal.strArea ?? "")
                    .font(.subheadline)
            }
            .padding()
            .offset(y: -100)
            
        }
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .frame(width: 350, height: 500)
        .padding()
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CardView(meal: ExampleMeal.mealExamples.first!)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}
