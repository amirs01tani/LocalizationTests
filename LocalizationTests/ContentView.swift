//
//  ContentView.swift
//  LocalizationTests
//
//  Created by Amir on 3/28/24.
//

import SwiftUI

struct ContentView: View {
    var presenter = ContentViewPresenter()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(presenter.title)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
