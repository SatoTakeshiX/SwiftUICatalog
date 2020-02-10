//
//  ContentView.swift
//  SwiftUIOverview
//
//  Created by satoutakeshi on 2020/02/03.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello World")
            .frame(width: 60, height: 30)
    }
}

struct BigImageThanParent: View {
    var body: some View {
        Image("wing")
        .resizable()
        .frame(width: 30, height: 30)
    }
}

struct HorizonStack: View {
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Text("First")
            Image("wing").layoutPriority(2)
            Text("HStackSecondText").layoutPriority(1)
        }
        .frame(width: 200)
    }
}

struct ZIndexStack: View {
    var body: some View {
        ZStack {
            Text("First")
            Image("wing")
            Text("HStackSecondText")
        }
        .frame(width: 200)
    }
}

struct CircleImage: View {
    var body: some View {
        Image("wing")
            .cornerRadius(10)
            .shadow(color: .gray, radius: 10, x: 10, y: 10)
    }
}

struct BindingView: View {
    @State var inputText: String = ""
    var body: some View {
        VStack {
            TextField("", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Text(inputText)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            BigImageThanParent()
            CircleImage()
                .previewLayout(.fixed(width: 300, height: 200))
                .edgesIgnoringSafeArea(.all)
            BindingView()
            HorizonStack()
            ZIndexStack()
        }
    }
}
