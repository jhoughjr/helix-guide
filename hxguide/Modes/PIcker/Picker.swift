//
//  Picker.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

/// Keys used within the picker. Remapping is not currently supported,
/// so none of these map to a rebindable Helix command name.
enum PickerCommands: String, CaseIterable, KeyCommandEnum {
    typealias Info = Helix.KeyInfo

    case na_previous_entry
    case na_next_entry
    case na_pageup
    case na_pagedown
    case na_gotoFirst
    case na_gotoLast
    case na_openSelected
    case na_open_horizontal
    case na_open_vertical
    case na_toggle_preview
    case na_close_picker

    var info: Info {
        switch self {

        case .na_previous_entry:
            return Info(key: "Shift-Tab, Up, Ctrl-p", description: "Previous entry")
        case .na_next_entry:
            return Info(key: "Tab, Down, Ctrl-n", description: "Next entry")
        case .na_pageup:
            return Info(key: "PageUp, Ctrl-u", description: "Page up")
        case .na_pagedown:
            return Info(key: "PageDown, Ctrl-d", description: "Page down")
        case .na_gotoFirst:
            return Info(key: "Home", description: "Go to first entry")
        case .na_gotoLast:
            return Info(key: "End", description: "Go to last entry")
        case .na_openSelected:
            return Info(key: "Enter", description: "Open selected")
        case .na_open_horizontal:
            return Info(key: "Ctrl-s", description: "Open horizontally")
        case .na_open_vertical:
            return Info(key: "Ctrl-v", description: "Open vertically")
        case .na_toggle_preview:
            return Info(key: "Ctrl-t", description: "Toggle preview")
        case .na_close_picker:
            return Info(key: "Escape, Ctrl-c", description: "Close picker")
        }
    }
}
