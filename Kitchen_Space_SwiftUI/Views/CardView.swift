//
//  CardView.swift
//  Kitchen_Space_SwiftUI
//
//  Created by Arjun Doel on 17/04/2022.
//

import SwiftUI
import CachedAsyncImage

struct CardView: View {
    @EnvironmentObject var mealVM: MealsViewModel
    var meal: Meal
    
    var body: some View {
        VStack(alignment: .leading) {
            cardImage
            cardText
        }
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .frame(width: 350, height: 500)
        .padding()
        .onTapGesture {
            mealVM.sheetMeal = meal
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CardView(meal: ExampleMeal.mealExamples.first!)
                .environmentObject(MealsViewModel())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}

extension CardView {
    private var cardImage: some View {
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
    }
    
    private var cardText: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(meal.strMeal)
                .foregroundColor(.white)
                .font(.headline)
            Text(meal.strArea ?? "")
                .foregroundColor(.white)
                .font(.subheadline)
                .fontWeight(.light)
        }
        .padding()
        .offset(y: -100)
    }
}
