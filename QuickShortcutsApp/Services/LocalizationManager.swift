//
//  LocalizationManager.swift
//  QuickShortcutsApp
//
//  Created by nakatsuka_kirito on 2025/08/03.
//

import Foundation
import SwiftUI

enum AppLanguage: String, CaseIterable, Identifiable {
    case english = "en"
    case japanese = "ja"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .english:
            return "English"
        case .japanese:
            return "日本語"
        }
    }
    
    var flag: String {
        switch self {
        case .english:
            return "🇺🇸"
        case .japanese:
            return "🇯🇵"
        }
    }
}

class LocalizationManager: ObservableObject {
    @Published var currentLanguage: AppLanguage {
        didSet {
            UserDefaults.standard.set(currentLanguage.rawValue, forKey: "AppLanguage")
        }
    }
    
    init() {
        let savedLanguage = UserDefaults.standard.string(forKey: "AppLanguage") ?? AppLanguage.english.rawValue
        self.currentLanguage = AppLanguage(rawValue: savedLanguage) ?? .english
    }
    
    func localizedString(_ key: String) -> String {
        return LocalizedStrings.getString(key, language: currentLanguage)
    }
}

struct LocalizedStrings {
    static func getString(_ key: String, language: AppLanguage) -> String {
        switch language {
        case .english:
            return englishStrings[key] ?? key
        case .japanese:
            return japaneseStrings[key] ?? key
        }
    }
    
    private static let englishStrings: [String: String] = [
        // Main View
        "QuickShortcuts": "QuickShortcuts",
        "No shortcuts yet": "No shortcuts yet",
        "Click + to add your first shortcut": "Click + to add your first shortcut",
        "Add new shortcut": "Add new shortcut",
        "Edit shortcut": "Edit shortcut",
        "Run shortcut": "Run shortcut",
        "Language": "Language",
        
        // Shortcut Types
        "Shell Command": "Shell Command",
        "Application": "Application",
        "File/URL": "File/URL",
        
        // Edit View
        "Edit Shortcut": "Edit Shortcut",
        "New Shortcut": "New Shortcut",
        "Name": "Name",
        "Shortcut name": "Shortcut name",
        "Type": "Type",
        "Command": "Command",
        "File Path or URL": "File Path or URL",
        "Cancel": "Cancel",
        "Create": "Create",
        "Update": "Update",
        
        // Placeholders
        "ls -la": "ls -la",
        "Terminal or /Applications/Terminal.app": "Terminal or /Applications/Terminal.app",
        "/path/to/file or https://example.com": "/path/to/file or https://example.com",
        
        // Hints
        "Enter a shell command to execute": "Enter a shell command to execute",
        "Enter app name or full path to .app bundle": "Enter app name or full path to .app bundle",
        "Enter file path or URL (http/https)": "Enter file path or URL (http/https)",
        
        // Sample Data
        "Terminal": "Terminal",
        "List Files": "List Files",
        "GitHub": "GitHub",
        "SSH to aipictors-prod": "SSH to aipictors-prod",
        "AiPictors": "AiPictors"
    ]
    
    private static let japaneseStrings: [String: String] = [
        // Main View
        "QuickShortcuts": "QuickShortcuts",
        "No shortcuts yet": "まだショートカットがありません",
        "Click + to add your first shortcut": "+ をクリックして最初のショートカットを追加",
        "Add new shortcut": "新しいショートカットを追加",
        "Edit shortcut": "ショートカットを編集",
        "Run shortcut": "ショートカットを実行",
        "Language": "言語",
        
        // Shortcut Types
        "Shell Command": "シェルコマンド",
        "Application": "アプリケーション",
        "File/URL": "ファイル/URL",
        
        // Edit View
        "Edit Shortcut": "ショートカットを編集",
        "New Shortcut": "新しいショートカット",
        "Name": "名前",
        "Shortcut name": "ショートカット名",
        "Type": "種類",
        "Command": "コマンド",
        "File Path or URL": "ファイルパスまたはURL",
        "Cancel": "キャンセル",
        "Create": "作成",
        "Update": "更新",
        
        // Placeholders
        "ls -la": "ls -la",
        "Terminal or /Applications/Terminal.app": "ターミナル または /Applications/Terminal.app",
        "/path/to/file or https://example.com": "/path/to/file または https://example.com",
        
        // Hints
        "Enter a shell command to execute": "実行するシェルコマンドを入力",
        "Enter app name or full path to .app bundle": "アプリ名または.appバンドルのフルパスを入力",
        "Enter file path or URL (http/https)": "ファイルパスまたはURL（http/https）を入力",
        
        // Sample Data
        "Terminal": "ターミナル",
        "List Files": "ファイル一覧",
        "GitHub": "GitHub",
        "SSH to aipictors-prod": "aipictors-prodにSSH接続",
        "AiPictors": "AiPictors"
    ]
}
