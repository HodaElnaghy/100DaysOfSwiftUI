//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Hend on 08/05/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    var body: some View {
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [ .mint, .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess The Flag")
                    .foregroundColor(.white)
                    .font(.largeTitle.bold())
                Spacer()
                VStack(spacing: 30){
                    VStack{
                        Text("Choose The Flage of:")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3){index in
                        Button {
                            flagTapped(index)
                        } label: {
                            Image(countries[index])
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 5)
                        }
                        
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                
                Spacer()
                Spacer()
                Text("Your Score: \(score)")
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(20)
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestions)
        } message: {
            Text("Your score is: \(score)")
        }
        
    }
    
    
    private func flagTapped(_ number : Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            score += 1
        }
        else {
            if score == 0 {
                scoreTitle = "Game Over!"
                
            }
            else{
                scoreTitle = "False"
                score -= 1
            }
        }
        showingScore = true
    }
    private func askQuestions (){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
