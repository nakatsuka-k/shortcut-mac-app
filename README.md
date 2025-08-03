# QuickShortcuts

A production-ready macOS app that lets users register and launch arbitrary shortcuts with one click.

![macOS](https://img.shields.io/badge/macOS-11.0+-blue)
![Swift](https://img.shields.io/badge/Swift-5.9-orange)
![Xcode](https://img.shields.io/badge/Xcode-15.0+-blue)

## Features

- **Shortcut Management**: Register shell commands, applications, files, or URLs as shortcuts
- **One-click Execution**: Launch any shortcut with a single click or double-click
- **Local Storage**: All shortcuts are stored locally using UserDefaults (no external dependencies)
- **Modern UI**: Built with SwiftUI for a native macOS experience
- **Three Shortcut Types**:
  - 🖥️ **Shell Commands**: Execute terminal commands directly
  - 📱 **Applications**: Launch macOS applications
  - 📄 **Files/URLs**: Open local files or web URLs

## Screenshots

The app displays a clean list of shortcuts with:
- SF Symbol icons indicating shortcut type
- Shortcut name and target
- Edit and run buttons for each shortcut
- Double-click to execute functionality

## Getting Started

### Requirements

- macOS 11.0 or later
- Xcode 15.0 or later
- Swift 5.9

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/shortcut-mac-app.git
   cd shortcut-mac-app
   ```

2. Open the project in Xcode:
   ```bash
   open QuickShortcutsApp.xcodeproj
   ```

3. Build and run the project (⌘+R)

### Usage

1. **Adding Shortcuts**: Click the "+" button to create a new shortcut
2. **Editing Shortcuts**: Click the pencil icon next to any shortcut
3. **Running Shortcuts**: Click the play button or double-click the shortcut row
4. **Deleting Shortcuts**: Swipe left on a shortcut or use the delete key

### Shortcut Types

#### Shell Commands
Execute terminal commands directly from the app.
- Example: `ls -la`, `git status`, `npm start`

#### Applications
Launch macOS applications by name or path.
- Example: `Terminal`, `Safari`, `/Applications/Xcode.app`

#### Files/URLs
Open local files or web URLs.
- Example: `/Users/username/Documents/file.txt`, `https://github.com`

## Project Structure

```
QuickShortcutsApp/
├── QuickShortcutsAppApp.swift      # App entry point
├── ContentView.swift               # Main view
├── Models/
│   └── Shortcut.swift             # Data model
├── Views/
│   ├── ShortcutListView.swift     # Main list view
│   └── ShortcutEditView.swift     # Edit/create view
├── Services/
│   └── ShortcutStore.swift        # Data management
└── Assets.xcassets/               # App icons and colors
```

## Data Storage

All shortcuts are stored locally using `UserDefaults` as JSON data. This ensures:
- No external dependencies
- Fast app startup
- Privacy (no data leaves your machine)
- Git-friendly (no sensitive data in repository)

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Built with SwiftUI for modern macOS development
- Uses SF Symbols for consistent iconography
- Follows Apple's Human Interface Guidelines