//
//  MenuView.swift
//  Guess the Doodle
//
//  Created by Danjing Yin on 6/14/23.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var matchManager: MatchManager
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("logo")
                .resizable()
                .scaledToFit()
                .padding(30)
            Spacer()
            
            Button {
                
            } label:{
                Text("PLAY")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .bold()
                
            }
            .disabled(matchManager.authenticationState !=
                .authenticated || matchManager.inGame)
            .padding(.vertical,20)
            .padding(.horizontal,100)
            .background(
                Capsule(style: . circular)
                    .fill(matchManager.authenticationState !=
                        .authenticated || matchManager.inGame
                          ?.gray: Color("PlayBtn")))
            
            Text(matchManager.authenticationState.rawValue)
                .font(.headline
                    .weight(.semibold))
                .foregroundColor(Color("primaryYellow"))
                .padding()
            Spacer()
            
            
        }
        .background(
        Image("menuBg")
        .resizable()
        .scaledToFill()
        .scaleEffect(1.3))
        .ignoresSafeArea()
    }
        
}
struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(matchManager: MatchManager())
    }
}
