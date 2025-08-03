//
//  ShortcutEditView.swift
//  QuickShortcutsApp
//
//  Created by nakatsuka_kirito on 2025/08/03.
//

import SwiftUI

struct ShortcutEditView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var store: ShortcutStore
    
    @State private var name: String
    @State private var kind: ShortcutKind
    @State private var target: String
    
    private let shortcut: Shortcut?
    private let isEditing: Bool
    
    init(shortcut: Shortcut? = nil) {
        self.shortcut = shortcut
        self.isEditing = shortcut != nil
        
        if let shortcut = shortcut {
            self._name = State(initialValue: shortcut.name)
            self._kind = State(initialValue: shortcut.kind)
            self._target = State(initialValue: shortcut.target)
        } else {
            self._name = State(initialValue: "")
            self._kind = State(initialValue: .shell)
            self._target = State(initialValue: "")
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(isEditing ? "Edit Shortcut" : "New Shortcut")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Name")
                    .font(.headline)
                TextField("Shortcut name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Type")
                    .font(.headline)
                Picker("Type", selection: $kind) {
                    ForEach(ShortcutKind.allCases) { kind in
                        HStack {
                            Image(systemName: kind.iconName)
                            Text(kind.displayName)
                        }
                        .tag(kind)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(targetLabel)
                    .font(.headline)
                TextField(targetPlaceholder, text: $target)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text(targetHint)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                .keyboardShortcut(.escape)
                
                Spacer()
                
                Button(isEditing ? "Update" : "Create") {
                    saveShortcut()
                }
                .buttonStyle(.borderedProminent)
                .disabled(name.isEmpty || target.isEmpty)
                .keyboardShortcut(.return)
            }
        }
        .padding()
        .frame(width: 400, height: 300)
    }
    
    private var targetLabel: String {
        switch kind {
        case .shell:
            return "Command"
        case .app:
            return "Application"
        case .file:
            return "File Path or URL"
        }
    }
    
    private var targetPlaceholder: String {
        switch kind {
        case .shell:
            return "ls -la"
        case .app:
            return "Terminal or /Applications/Terminal.app"
        case .file:
            return "/path/to/file or https://example.com"
        }
    }
    
    private var targetHint: String {
        switch kind {
        case .shell:
            return "Enter a shell command to execute"
        case .app:
            return "Enter app name or full path to .app bundle"
        case .file:
            return "Enter file path or URL (http/https)"
        }
    }
    
    private func saveShortcut() {
        let newShortcut = Shortcut(name: name, kind: kind, target: target)
        
        if isEditing, let existingShortcut = shortcut {
            var updatedShortcut = newShortcut
            updatedShortcut.id = existingShortcut.id
            store.updateShortcut(updatedShortcut)
        } else {
            store.addShortcut(newShortcut)
        }
        
        dismiss()
    }
}

#Preview {
    ShortcutEditView()
        .environmentObject(ShortcutStore())
}
