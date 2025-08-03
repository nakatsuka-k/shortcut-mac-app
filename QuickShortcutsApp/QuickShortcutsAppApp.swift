import SwiftUI

@main
struct QuickShortcutsApp: App {
    @StateObject private var store = ShortcutStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .frame(minWidth: 520, minHeight: 380)
        }
        .commands { 
            CommandGroup(replacing: .newItem) { }
        }
        .windowToolbarStyle(.unified)
    }
}
