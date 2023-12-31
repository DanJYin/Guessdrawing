//
//  GameView.swift
//  Guess the Doodle
//
//  Created by DY on 6/14/23.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var matchManager:MatchManager
    @State var drawingGuess = ""
    @State var eraserEnabled = false
    
    func makeGuess() {
        
    }
    
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                Image(matchManager.currentlydrawing ? "drawerBg" :
                        "guesserBg")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
                .scaleEffect(1.3)
                
                VStack{
                    topBar
                    
                    ZStack{
                        DrawingView(matchManager: matchManager, eraserEnabled: $eraserEnabled)
                            .aspectRatio(1, contentMode: .fit)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black, lineWidth: 10)
                            )
                        VStack {
                            HStack {
                                Spacer()
                                if matchManager.currentlydrawing {
                                    Button {
                                        eraserEnabled.toggle()}
                                label: {
                                    Image(systemName: eraserEnabled ?
                                          "eraser.fill": "eraser")
                                    .font(.title)
                                    .foregroundColor(Color ("primaryPurple"))
                                    .padding(.top,10)
                                }
                                }
                            }
                            Spacer()
                            
                        }
                        .padding()
                    }
                    pastGuesses
                }
                .padding(.horizontal, 30)
                .ignoresSafeArea(.keyboard, edges: .bottom)
            }
            VStack {
                Spacer()
                promptGroup
            }
            .ignoresSafeArea(.container)
        }
    }
    var topBar: some View {
        ZStack{
            HStack{
                Button {
                    
                } label:{
                    Image(systemName: "arrowshape.turn.up.left.circle.fill")
                        .font(.largeTitle)
                        .tint(Color(matchManager.currentlydrawing ? "primaryYellow" : "primaryPurple"))
                }
                Spacer()
                Label("\(matchManager.remainingTime)",
                      systemImage: "clock.fill")
                .bold()
                .font(.title2)
                .foregroundColor(Color(matchManager.currentlydrawing ? "primaryYellow" : "primaryPurple"))
            }
        }
        .padding(.vertical,15)
    }
    var pastGuesses: some View {
        ScrollView {
            ForEach(matchManager.pastGuesses) { guess in HStack {
                Text(guess.message)
                    .font(.title2)
                    .bold(guess.correct)
                if guess.correct {
                    Image(systemName: "hand.thumbsup.fill")
                        .foregroundColor(matchManager.currentlydrawing ?
                                         Color(red:0.808, green:0.345, blue:0.776) :
                                            Color(red:0.243, green: 0.773, blue:0.745))
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 1)
                
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            (matchManager.currentlydrawing ?
             Color(red:0.808, green:0.345, blue:0.776) : Color("primaryYellow")
            )
            .brightness(-0.2)
            .opacity(0.5)
        )
        .cornerRadius(20)
        .padding(.vertical)
        .padding(.bottom, 130)
    }
    var promptGroup: some View {
        VStack {
            if matchManager.currentlydrawing {
                     Label("DRAW", systemImage: "exclamationmark.bubble.fill")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                Text(matchManager.drawPrompt.uppercased())
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .foregroundColor(Color("primaryYellow"))
            } else {
                HStack {
                    Label("GUESS THE DRAWING!:", systemImage: "exclamationmark.bubble.fill")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color("primaryPurple"))
                    Spacer()
                }
                
                HStack{
                    TextField("Type your guess", text:$drawingGuess)
                        .padding()
                        .background(
                            Capsule(style: .circular)
                                .fill(.white)
                        )
                        .onSubmit(makeGuess)
                    
                    Button {
                        makeGuess()
                    } label: {
                        Image(systemName: "chevron.right.circle.fill")
                            .renderingMode(.original)
                            .foregroundColor(Color("primaryPurple"))
                            .font(.system(size: 50))
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding([.horizontal, .bottom], 30)
        .padding(.vertical)
        .background(
            (matchManager.currentlydrawing ?
             Color(red:0.243, green:0.733, blue:0.745) :
            Color("primaryYellow"))
            .opacity(0.5)
            .brightness(-0.2)
        )
    }
    
}
    struct GameView_Previews: PreviewProvider {
        static var previews: some View {
            GameView(matchManager: MatchManager())
        }
    }

