//
//  ContentView.swift
//  Dicee
//
//  Created by Kenny Cabral on 2/13/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var leftDiceNumber = Int.random(in: 1...6)
    @State var rightDiceNumber = Int.random(in: 1...6)
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable().edgesIgnoringSafeArea(.all)
            VStack{
                Image("diceeLogo")
                Spacer()
                HStack {
                    DiceView(diceNumber: leftDiceNumber)
                    DiceView(diceNumber: rightDiceNumber)
                }
                .padding(.horizontal)
                Spacer()
                Button {
                    self.leftDiceNumber = Int.random(in: 1...6)
                    self.rightDiceNumber = Int.random(in: 1...6)
                } label: {
                    Text("Roll")
                        .font(.system(size: 50))
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                }
                .background(Color.red)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
        }
    }
}

struct DiceView: View {
    
    let diceNumber: Int
    
    var body: some View {
        Image("dice\(diceNumber)")
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
    }
}


