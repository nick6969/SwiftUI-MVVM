//
//  ContentView.swift
//  SwiftUI-MVVM
//
//  Created by Nick on 3/3/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("毛豬價格", destination: PetInfoView())
            }.navigationBarTitle("HomePage", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
