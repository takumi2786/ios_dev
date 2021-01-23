//
//  ContentView.swift
//  ObjectDetection
//
//  Created by Takumi  on 2020/09/01.
//  Copyright © 2020 Takumi . All rights reserved.
//

import SwiftUI // アップル公式のUIライブラリ


struct ContentView: View {
var body: some View {
    VStack{
        Text("Volume!")
            .font(.title)
        
        HStack {
            Image(systemName: "speaker.fill")
            Slider(value: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant(10)/*@END_MENU_TOKEN@*/)
            Image(systemName: "speaker.3.fill")
            
        }
        .accentColor(.gray)
        .foregroundColor(.gray)
        .padding(.all)
        
        HStack {
            Image(systemName: "speaker.fill")
            Slider(value: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant(10)/*@END_MENU_TOKEN@*/)
                .accessibility(hidden: true)
            Image(systemName: "speaker.3.fill")
            
        }
        .accentColor(.gray)
        .foregroundColor(.gray)
        .padding(.all)
        
        
        
        Image(systemName: "smiley")
            .resizable()
            .padding(.all)
            .frame(width: 200.0, height: 200.0)
            .blur(radius: /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
            .foregroundColor(/*@START_MENU_TOKEN@*/.green/*@END_MENU_TOKEN@*/)
            
        Text("Smile!")
            .font(.title)
            .multilineTextAlignment(.center)
        
        
    }
   
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}







//Text("sekiro死ぬほどむずい")
//    .font(.largeTitle)
//    .foregroundColor(Color.orange)
//    .fontWeight(Font.Weight.bold)
