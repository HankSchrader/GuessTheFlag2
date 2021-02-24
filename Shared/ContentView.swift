//
//  ContentView.swift
//  Shared
//
//  Created by Erik Mikac on 2/18/21.
//

import SwiftUI
// Day 20.
struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Poland", "Russia", "Spain", "Nigeria", "US", "UK"].shuffled()
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var currentScore = 0
    @State private var chosenAnswer = ""
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
                }) {
                    Image(self.countries[number])
                        .renderingMode(.original)
                        .clipShape(Capsule()).overlay(Capsule().stroke(Color.black, lineWidth: 1))
                        .shadow(color: .black, radius: 3 )
                }
            }
            Text("Current Score: \(currentScore).").foregroundColor(.white)
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(chosenAnswer), dismissButton: .default(Text("Continue")) {
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

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
