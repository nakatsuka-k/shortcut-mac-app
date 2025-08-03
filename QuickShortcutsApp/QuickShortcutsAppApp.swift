import SwiftUI

@main
struct QuickShortcutsApp: App {
    @StateObject private var store = ShortcutStore()
    @StateObject private var localization = LocalizationManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .environmentObject(localization)
                .frame(minWidth: 520, minHeight: 380)
        }
        .commands { 
            CommandGroup(replacing: .newItem) { }
        }
        .windowToolbarStyle(.unified)
    }
}
