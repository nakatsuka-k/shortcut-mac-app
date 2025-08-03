//
//  ShortcutStore.swift
//  QuickShortcutsApp
//
//  Created by nakatsuka_kirito on 2025/08/03.
//

import Foundation
import SwiftUI

class ShortcutStore: ObservableObject {
    @Published var shortcuts: [Shortcut] = []
    
    private let userDefaults = UserDefaults.standard
    private let shortcutsKey = "QuickShortcuts_SavedShortcuts"
    
    init() {
        loadShortcuts()
    }
    
    func addShortcut(_ shortcut: Shortcut) {
        shortcuts.append(shortcut)
        saveShortcuts()
    }
    
    func updateShortcut(_ shortcut: Shortcut) {
        if let index = shortcuts.firstIndex(where: { $0.id == shortcut.id }) {
            shortcuts[index] = shortcut
            saveShortcuts()
        }
    }
    
    func deleteShortcut(_ shortcut: Shortcut) {
        shortcuts.removeAll { $0.id == shortcut.id }
        saveShortcuts()
    }
    
    func executeShortcut(_ shortcut: Shortcut) {
        switch shortcut.kind {
        case .shell:
            executeShellCommand(shortcut.target)
        case .app:
            openApplication(shortcut.target)
        case .file:
            openFileOrURL(shortcut.target)
        }
    }
    
    private func executeShellCommand(_ command: String) {
        let task = Process()
        task.launchPath = "/bin/zsh"
        task.arguments = ["-c", command]
        
        do {
            try task.run()
        } catch {
            print("Failed to execute shell command: \(error)")
        }
    }
    
    private func openApplication(_ appPath: String) {
        let workspace = NSWorkspace.shared
        if appPath.hasSuffix(".app") {
            workspace.openApplication(at: URL(fileURLWithPath: appPath), configuration: NSWorkspace.OpenConfiguration()) { _, _ in }
        } else {
            // アプリ名で検索して開く
            workspace.launchApplication(appPath)
        }
    }
    
    private func openFileOrURL(_ target: String) {
        if target.hasPrefix("http://") || target.hasPrefix("https://") {
            // URL
            if let url = URL(string: target) {
                NSWorkspace.shared.open(url)
            }
        } else {
            // ローカルファイル
            let url = URL(fileURLWithPath: target)
            NSWorkspace.shared.open(url)
        }
    }
    
    private func saveShortcuts() {
        do {
            let data = try JSONEncoder().encode(shortcuts)
            userDefaults.set(data, forKey: shortcutsKey)
        } catch {
            print("Failed to save shortcuts: \(error)")
        }
    }
    
    private func loadShortcuts() {
        guard let data = userDefaults.data(forKey: shortcutsKey) else {
            // サンプルデータを追加
            shortcuts = [
                Shortcut(name: "Terminal", kind: .app, target: "Terminal"),
                Shortcut(name: "List Files", kind: .shell, target: "ls -la"),
                Shortcut(name: "GitHub", kind: .file, target: "https://github.com")
            ]
            return
        }
        
        do {
            shortcuts = try JSONDecoder().decode([Shortcut].self, from: data)
        } catch {
            print("Failed to load shortcuts: \(error)")
            shortcuts = []
        }
    }
}
