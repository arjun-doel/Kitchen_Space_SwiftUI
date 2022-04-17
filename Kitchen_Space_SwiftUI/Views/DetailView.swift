//
//  DetailView.swift
//  Kitchen_Space_SwiftUI
//
//  Created by Arjun Doel on 17/04/2022.
//

import SwiftUI
import CachedAsyncImage

struct DetailView: View {
    @EnvironmentObject var mealVM: MealsViewModel
    
    var meal: Meal
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    detailImage
                    Divider()
                    subHeadline
                    Divider()
                    description
                    Divider()
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Ingredients")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text(meal.strIngredient1 ?? "")
                    }
                    .padding()
                }
            }
            .navigationTitle(meal.strMeal)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(meal: ExampleMeal.mealExamples.first!)
            .environmentObject(MealsViewModel())
    }
}

extension DetailView {
    private var detailImage: some View {
        CachedAsyncImage(url: URL(string: meal.strMealThumb), content: { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width)
                .clipped()
        }, placeholder: {
            ProgressView()
        })
        .cornerRadius(20)
    }
    
    private var subHeadline: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(meal.strArea ?? "")
                .font(.subheadline)
                .fontWeight(.bold)
            Text(meal.strCategory ?? "")
                .font(.subheadline)
                .fontWeight(.light)
        }
        .padding()
    }
    
    private var description: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Instructions")
                .font(.title2)
                .fontWeight(.semibold)
            Text(meal.strInstructions ?? "No Instructions")
                .font(.body)
        }
        .padding()
    }
}
