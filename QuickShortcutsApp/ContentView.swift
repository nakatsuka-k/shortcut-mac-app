//
//  ContentView.swift
//  QuickShortcutsApp
//
//  Created by nakatsuka_kirito on 2025/08/03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ShortcutListView()
    }
}

#Preview {
    ContentView()
        .environmentObject(ShortcutStore())
}
