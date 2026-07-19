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
