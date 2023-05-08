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
    @State private var counter = 0
    @State private var gameOver:Bool = false
    @State private var finalScore = 0
    @State private var youLosed = false
    @State private var buttonScale: [CGFloat] = [1.0, 1.0, 1.0]
    @State private var buttonOpacity: [Double] = [1.0, 1.0, 1.0]

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
                    ForEach(0..<3) { index in
                        Button(action: {
                            flagTapped(index)
                        }) {
                            Image(countries[index])
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 5)
                        }
                        .scaleEffect(buttonScale(index))
                        .opacity(buttonOpacity(index))
                        .animation(.easeInOut(duration: 0.1))
                        .onTapGesture {
                            withAnimation {
                                buttonScale[index] = 0.95
                                buttonOpacity[index] = 0.8
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    buttonScale[index] = 1.0
                                    buttonOpacity[index] = 1.0
                                }
                            }
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
        .alert("You Won", isPresented: $gameOver){
            Button("Play Again", action: askQuestions)
        } message:{
                    Text("Your score is \(finalScore) out of 8")
            }
        .alert("Game Over!", isPresented: $youLosed){
            Button("Play Again", action: askQuestions)
        }
    }
    
    
    private func flagTapped(_ number : Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            score += 1
            showingScore = true
            counter += 1
        }
        else {
            if score == 0 {
                youLosed = true
                counter = 0
            }
            else{
                scoreTitle = "Wrong! \n That’s the flag of \(countries[number])"
                score -= 1
                showingScore = true
                counter += 1
            }
        }
        
    }
    private func askQuestions (){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        if counter == 7 {
            gameOver = true
            finalScore = score
            score = 0
        }
        
    }
    func buttonScale(_ index: Int) -> CGFloat {
        buttonScale[index]
    }

    func buttonOpacity(_ index: Int) -> Double {
        buttonOpacity[index]
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
