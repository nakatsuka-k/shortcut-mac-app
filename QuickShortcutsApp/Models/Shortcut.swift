//
//  Shortcut.swift
//  QuickShortcutsApp
//
//  Created by nakatsuka_kirito on 2025/08/03.
//

import Foundation

enum ShortcutKind: String, Codable, CaseIterable, Identifiable {
    case shell, app, file  // fileはローカルファイルまたはhttp(s) URL
    
    var id: String { rawValue }
    
    func displayName(localization: LocalizationManager) -> String {
        switch self {
        case .shell:
            return localization.localizedString("Shell Command")
        case .app:
            return localization.localizedString("Application")
        case .file:
            return localization.localizedString("File/URL")
        }
    }
    
    var iconName: String {
        switch self {
        case .shell:
            return "terminal"
        case .app:
            return "app"
        case .file:
            return "doc"
        }
    }
}

struct Shortcut: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var name: String
    var kind: ShortcutKind
    var target: String   // コマンド、パス、URLなど
    
    init(name: String, kind: ShortcutKind, target: String) {
        self.name = name
        self.kind = kind
        self.target = target
    }
}
