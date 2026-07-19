//
//  Changes.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

enum ChangeCommands: String, CaseIterable, KeyCommandEnum {

    typealias Info = Helix.KeyInfo

    case replace
    case replace_with_yanked
    case switch_case
    case switch_to_lowercase
    case switch_to_uppercase
    case insert_mode
    case append_mode
    case insert_at_line_start
    case insert_at_line_end
    case open_below
    case open_above
    case na_repeat_last_insert
    case undo
    case redo
    case earlier
    case later
    case yank
    case paste_after
    case paste_before
    case select_register
    case indent
    case unindent
    case format_selections
    case delete_selection
    case delete_selection_noyank
    case change_selection
    case change_selection_noyank
    case increment
    case decrement
    case record_macro
    case replay_macro

    var info: Info {
        switch self {

        case .replace:
            return Info(key: "r", description: "Replace with a character")
        case .replace_with_yanked:
            return Info(key: "R", description: "Replace with yanked text")
        case .switch_case:
            return Info(key: "~", description: "Switch case of the selected text")
        case .switch_to_lowercase:
            return Info(key: "`", description: "Set the selected text to lower case")
        case .switch_to_uppercase:
            return Info(key: "Alt-`", description: "Set the selected text to upper case")
        case .insert_mode:
            return Info(key: "i", description: "Insert before selection")
        case .append_mode:
            return Info(key: "a", description: "Insert after selection (append)")
        case .insert_at_line_start:
            return Info(key: "I", description: "Insert at the start of the line")
        case .insert_at_line_end:
            return Info(key: "A", description: "Insert at the end of the line")
        case .open_below:
            return Info(key: "o", description: "Open new line below selection")
        case .open_above:
            return Info(key: "O", description: "Open new line above selection")
        case .na_repeat_last_insert:
            return Info(key: ".", description: "Repeat last insert")
        case .undo:
            return Info(key: "u", description: "Undo change")
        case .redo:
            return Info(key: "U", description: "Redo change")
        case .earlier:
            return Info(key: "Alt-u", description: "Move backward in history")
        case .later:
            return Info(key: "Alt-U", description: "Move forward in history")
        case .yank:
            return Info(key: "y", description: "Yank selection")
        case .paste_after:
            return Info(key: "p", description: "Paste after selection")
        case .paste_before:
            return Info(key: "P", description: "Paste before selection")
        case .select_register:
            return Info(key: "\" <reg>", description: "Select a register to yank to or paste from")
        case .indent:
            return Info(key: ">", description: "Indent selection")
        case .unindent:
            return Info(key: "<", description: "Unindent selection")
        case .format_selections:
            return Info(key: "=", description: "Format selection (LSP)")
        case .delete_selection:
            return Info(key: "d", description: "Delete selection")
        case .delete_selection_noyank:
            return Info(key: "Alt-d", description: "Delete selection, without yanking")
        case .change_selection:
            return Info(key: "c", description: "Change selection (delete and enter insert mode)")
        case .change_selection_noyank:
            return Info(key: "Alt-c", description: "Change selection (delete and enter insert mode, without yanking)")
        case .increment:
            return Info(key: "Ctrl-a", description: "Increment object (number) under cursor")
        case .decrement:
            return Info(key: "Ctrl-x", description: "Decrement object (number) under cursor")
        case .record_macro:
            return Info(key: "Q", description: "Start/stop macro recording to the selected register (experimental)")
        case .replay_macro:
            return Info(key: "q", description: "Play back a recorded macro from the selected register (experimental)")
        }
    }
}
