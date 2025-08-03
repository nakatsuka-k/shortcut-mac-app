//
//  LanguageSelectorView.swift
//  QuickShortcutsApp
//
//  Created by nakatsuka_kirito on 2025/08/03.
//

import SwiftUI

struct LanguageSelectorView: View {
    @EnvironmentObject private var localization: LocalizationManager
    
    var body: some View {
        Menu {
            ForEach(AppLanguage.allCases) { language in
                Button(action: {
                    localization.currentLanguage = language
                }) {
                    HStack {
                        Text("\(language.flag) \(language.displayName)")
                        if localization.currentLanguage == language {
                            Spacer()
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            HStack(spacing: 4) {
                Text(localization.currentLanguage.flag)
                Image(systemName: "chevron.down")
                    .font(.caption)
            }
        }
        .menuStyle(.borderlessButton)
        .help(localization.localizedString("Language"))
    }
}
