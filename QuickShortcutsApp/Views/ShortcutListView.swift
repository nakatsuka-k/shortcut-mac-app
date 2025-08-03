//
//  ShortcutListView.swift
//  QuickShortcutsApp
//
//  Created by nakatsuka_kirito on 2025/08/03.
//

import SwiftUI

struct ShortcutListView: View {
    @EnvironmentObject private var store: ShortcutStore
    @State private var showingEditSheet = false
    @State private var editingShortcut: Shortcut?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            HStack {
                Text("QuickShortcuts")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: addNewShortcut) {
                    Image(systemName: "plus")
                        .font(.title2)
                }
                .buttonStyle(.borderless)
                .help("Add new shortcut")
            }
            .padding()
            
            Divider()
            
            // Shortcuts List
            if store.shortcuts.isEmpty {
                VStack {
                    Spacer()
                    Text("No shortcuts yet")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text("Click + to add your first shortcut")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                }
            } else {
                List {
                    ForEach(store.shortcuts) { shortcut in
                        ShortcutRowView(shortcut: shortcut, onEdit: {
                            editShortcut(shortcut)
                        }, onRun: {
                            store.executeShortcut(shortcut)
                        })
                        .onTapGesture(count: 2) {
                            store.executeShortcut(shortcut)
                        }
                    }
                    .onDelete(perform: deleteShortcuts)
                }
                .listStyle(PlainListStyle())
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            ShortcutEditView(shortcut: editingShortcut)
        }
    }
    
    private func addNewShortcut() {
        editingShortcut = nil
        showingEditSheet = true
    }
    
    private func editShortcut(_ shortcut: Shortcut) {
        editingShortcut = shortcut
        showingEditSheet = true
    }
    
    private func deleteShortcuts(offsets: IndexSet) {
        for index in offsets {
            store.deleteShortcut(store.shortcuts[index])
        }
    }
}

struct ShortcutRowView: View {
    let shortcut: Shortcut
    let onEdit: () -> Void
    let onRun: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            // Icon
            Image(systemName: shortcut.kind.iconName)
                .font(.title2)
                .foregroundColor(.accentColor)
                .frame(width: 24, height: 24)
            
            // Content
            VStack(alignment: .leading, spacing: 2) {
                Text(shortcut.name)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(shortcut.target)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            
            Spacer()
            
            // Action buttons
            HStack(spacing: 8) {
                Button(action: onEdit) {
                    Image(systemName: "pencil")
                        .font(.caption)
                }
                .buttonStyle(.borderless)
                .help("Edit shortcut")
                
                Button(action: onRun) {
                    Image(systemName: "play.fill")
                        .font(.caption)
                }
                .buttonStyle(.borderless)
                .help("Run shortcut")
            }
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
    }
}

#Preview {
    ShortcutListView()
        .environmentObject(ShortcutStore())
        .frame(width: 520, height: 380)
}
