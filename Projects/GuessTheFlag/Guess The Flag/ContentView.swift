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
    @State private var buttonScale: [CGFloat] = [1.0, 1.0, 1.0]
    @State private var buttonOpacity: [Double] = [1.0, 1.0, 1.0]
    @State private var messages = ""
    @State private var btnMsg = ""
    let generator = UINotificationFeedbackGenerator()
                //generator.notificationOccurred(.warning)

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
            Button(btnMsg, action: askQuestions)
        } message: {
            Text(messages)
        }
        .alert(scoreTitle, isPresented: $gameOver) {
            Button(btnMsg, action: askQuestions)
        } message: {
            Text(messages)
        }

    }
    
    
    private func flagTapped(_ number : Int){
        
        if number == correctAnswer{
            scoreTitle = "Correct"
            btnMsg = "Continue"
            generator.notificationOccurred(.success)
            score += 1
            counter += 1
            messages = "You Score in \(score)"
            showingScore = true
        }
        else {
            if score == 0 {
                counter = 0
                generator.notificationOccurred(.warning)
                btnMsg = "Play Again"
                scoreTitle = "You Lost"
                messages = ""
                showingScore = true
            }
            else{
                counter += 1
                generator.notificationOccurred(.error)
                score -= 1
                scoreTitle = "Wrong! \n That’s the flag of \(countries[number])"
                btnMsg = "Continue"
                messages = "Your Score is \(score)"
                showingScore = true
            }
        }
        
    }
    private func askQuestions (){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        if counter == 1{
            if score == 8{
                scoreTitle = "You Won"
            }
            else {
                scoreTitle = "Game Ended"
                
            }
            generator.notificationOccurred(.success)
            btnMsg = "Play Again"
            messages = "Your Score is \(score) ot of 8"
            gameOver = true

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
