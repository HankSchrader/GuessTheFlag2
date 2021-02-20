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
                Spacer()
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is ???"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
        }

    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            
        } else {
            scoreTitle = "Wrong"
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
