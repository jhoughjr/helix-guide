//
//  helix.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

struct Helix {
    /// The Helix release this guide's keymap and command content was reconciled against.
    /// Bump this — and re-diff every table — whenever the content is refreshed.
    static let verifiedAgainstVersion = "25.07.1"
    /// When that reconciliation was last performed.
    static let verifiedOn = "2026-07-19"

    static let SelectOrExtendText = """
Select mode echoes Normal mode, but changes any movements to extend selections rather than replace them. Goto motions are also changed to extend, so that vgl for example extends the selection to the end of the line.

Search is also affected. By default, n and N will remove the current selection and select the next instance of the search term. Toggling this mode before pressing n or N makes it possible to keep the current selection. Toggling it on and off during your iterative searching allows you to selectively add search terms to your selections.
"""

    struct KeyInfo: Codable {
        let key: String
        let description: String

        /// Case- and diacritic-insensitive match against both the key and the description,
        /// so searching "gg", "Ctrl-w" or "|" finds the binding, not just its prose.
        func matches(_ query: String) -> Bool {
            let trimmed = query.trimmingCharacters(in: .whitespaces)
            guard !trimmed.isEmpty else { return true }
            return key.localizedCaseInsensitiveContains(trimmed)
                || description.localizedCaseInsensitiveContains(trimmed)
        }
    }

    struct CommandInfo: Codable {
        let invocation: String
        let description: String

        func matches(_ query: String) -> Bool {
            let trimmed = query.trimmingCharacters(in: .whitespaces)
            guard !trimmed.isEmpty else { return true }
            return invocation.localizedCaseInsensitiveContains(trimmed)
                || description.localizedCaseInsensitiveContains(trimmed)
        }
    }

    enum ConfigFileLocations: String, CaseIterable {
        case windows
        case linux
        case macOS

        var displayName: String {
            switch self {
            case .windows: return "Windows"
            case .linux: return "Linux"
            case .macOS: return "macOS"
            }
        }

        func description() -> String {
            switch self {

            case .windows:
                return "%AppData%\\helix\\config.toml"
            case .linux:
                return "~/.config/helix/config.toml"
            case .macOS:
                return "~/.config/helix/config.toml"
            }
        }
    }

    enum EditorModes: String, CaseIterable {
        case normal
        case insert
        case selectOrExtend
        case picker
        case prompt
    }

    enum NormalMode: String, CaseIterable {
        case movement
        case changes
        case selectionManipulation
        case search
        case shell
        case minorModes
    }
}

// MARK: - Unified entry model

/// One row in the guide: a keystroke (or command invocation) plus what it does.
/// Every command enum in the app projects into this, so a single list view renders
/// all of them and a single filter searches all of them.
struct GuideEntry: Identifiable, Hashable {
    /// The underlying Helix command name (`move_char_left`), also the row identity.
    let id: String
    /// The keystroke(s) or command invocation, rendered monospaced.
    let key: String
    /// Human-readable explanation.
    let detail: String

    /// `na_` marks entries with no bound Helix command name.
    var commandName: String? {
        id.hasPrefix("na_") ? nil : id
    }

    func matches(_ query: String) -> Bool {
        Helix.KeyInfo(key: key, description: detail).matches(query)
    }
}

/// Adopted by every `String`-backed key-binding enum so they share one projection
/// into `GuideEntry` instead of seven copy-pasted list views.
protocol KeyCommandEnum: CaseIterable, RawRepresentable where RawValue == String {
    var info: Helix.KeyInfo { get }
}

extension KeyCommandEnum {
    static var entries: [GuideEntry] {
        allCases.map {
            GuideEntry(id: $0.rawValue, key: $0.info.key, detail: $0.info.description)
        }
    }
}
