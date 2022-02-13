//
//  ContentView.swift
//  KennyCard
//
//  Created by Kenny Cabral on 2/13/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 0.09, green: 0.63, blue: 0.52, opacity: 1)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("Kenny_Image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150.0, height: 150.0)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 5)
                    )
                
                Text("Kenny Cabral")
                    .font(Font.custom("Pacifico-Regular", size: 40))
                    .bold()
                .foregroundColor(.white)
                Text("iOS Developer")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                Divider()
                ZStack {
                    VStack {
                        InfoView(text: "+1 234 567 8910", imageName: "phone.fill")
                        InfoView(text: "noName@doesntmatter.com", imageName: "envelope.fill")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice(PreviewDevice(rawValue: "iPhone 13"))
    }
}
