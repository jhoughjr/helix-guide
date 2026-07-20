//
//  Popup.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

/// Popup — the documentation popup shown for the item under the cursor.
enum PopupCommands: String, CaseIterable, KeyCommandEnum {
    typealias Info = Helix.KeyInfo

    case na_scroll_up
    case na_scroll_down

    var info: Info {
        switch self {

        case .na_scroll_up:
            return Info(key: "Ctrl-u", description: "Scroll up")
        case .na_scroll_down:
            return Info(key: "Ctrl-d", description: "Scroll down")
        }
    }
}

/// Completion menu — displays documentation for the selected completion item.
/// Remapping is not currently supported. Any keypress other than these accepts
/// the completion.
enum CompletionMenuCommands: String, CaseIterable, KeyCommandEnum {
    typealias Info = Helix.KeyInfo

    case na_previous_entry
    case na_next_entry
    case na_accept_completion
    case na_reject_completion

    var info: Info {
        switch self {

        case .na_previous_entry:
            return Info(key: "Shift-Tab, Ctrl-p, Up", description: "Previous entry")
        case .na_next_entry:
            return Info(key: "Tab, Ctrl-n, Down", description: "Next entry")
        case .na_accept_completion:
            return Info(key: "Enter", description: "Close menu and accept completion")
        case .na_reject_completion:
            return Info(key: "Ctrl-c", description: "Close menu and reject completion")
        }
    }
}

/// Signature-help popup — displays the signature of the selected completion item.
/// Remapping is not currently supported.
enum SignatureHelpCommands: String, CaseIterable, KeyCommandEnum {
    typealias Info = Helix.KeyInfo

    case na_previous_signature
    case na_next_signature

    var info: Info {
        switch self {

        case .na_previous_signature:
            return Info(key: "Alt-p", description: "Previous signature")
        case .na_next_signature:
            return Info(key: "Alt-n", description: "Next signature")
        }
    }
}
