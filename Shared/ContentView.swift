//
//  ContentView.swift
//  Shared
//
//  Created by Erik Mikac on 2/18/21.
//

import SwiftUI
// Day 20.
struct ContentView: View {
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top strip blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left strip blue, middle stripe white, right stripe red."
    //TODO Add the rest of the flags.
    ]
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Poland", "Russia", "Spain", "Nigeria", "US", "UK"].shuffled()
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var currentScore = 0
    @State private var chosenAnswer = ""
    @State private var animationAmount = 0.0
    @State private var wrongAnswerOpacity = 1.0
    @State private var scaleAmount: CGFloat = 1
    var body: some View {

        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]),
                           startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
        VStack(spacing: 30) {
            VStack {
                Text("Tap the flag of").foregroundColor(.white)
                
                Text(countries[correctAnswer]).foregroundColor(.white)
                .font(.largeTitle)
                .fontWeight(.bold)
            }
            ForEach(0..<3) { number in
                Button(action: {
                    self.flagTapped(number)
                    withAnimation {
                        self.animationAmount += 360
                        self.wrongAnswerOpacity = 0.4
                        self.scaleAmount += 2
                    }
                }) {
                
                    Image(self.countries[number])
                        .renderingMode(.original)
                        .clipShape(Capsule()).overlay(Capsule().stroke(Color.black, lineWidth: 1))
                        .shadow(color: .black, radius: 3 )
                        .accessibility(label: Text(self.labels[self.countries[number], default: "Unkown flag."]))
                 
                }.rotation3DEffect(.degrees( correctAnswerAnimation(chosenNumber: number) ? animationAmount : 0), axis: (x: 0, y: correctAnswerAnimation(chosenNumber: number) ? 1 : 0, z: 0))
                .opacity(correctAnswerAnimation(chosenNumber: number) ? 1.0 : wrongAnswerOpacity)
                .scaleEffect("\(number)" == chosenAnswer ? scaleAmount : 1)
               
            }
            Text("Current Score: \(currentScore).").foregroundColor(.white)
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(chosenAnswer), dismissButton: .default(Text("Continue")) {
                self.wrongAnswerOpacity = 1.0
                self.scaleAmount = 1
                self.askQuestion()
                })
            }
        }
    }

    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            currentScore += 1
            chosenAnswer = "Good Job!"
        } else {
            scoreTitle = "Wrong"
            if currentScore > 0 {
                currentScore -= 1
            }
            chosenAnswer = "That's the flag of \(countries[number])"
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func correctAnswerAnimation(chosenNumber number: Int) -> Bool {
        return chosenAnswer == "Good Job!" && number == correctAnswer
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
