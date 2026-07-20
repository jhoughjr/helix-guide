//
//  Insert.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

/// Insert mode bindings are minimal by default. Helix is a modal editor, and changes
/// to the text are only committed for undo when escaping back to normal mode.
///
/// The arrow/page/home/end bindings are included for users less familiar with modal
/// editors and can be disabled in `config.toml`:
///
///     [keys.insert]
///     up = "no_op"
///     down = "no_op"
///     left = "no_op"
///     right = "no_op"
///     pageup = "no_op"
///     pagedown = "no_op"
///     home = "no_op"
///     end = "no_op"
enum InsertCommands: String, CaseIterable, KeyCommandEnum {

    typealias Info = Helix.KeyInfo

    case normal_mode
    case commit_undo_checkpoint
    case completion
    case insert_register
    case delete_word_backward
    case delete_word_forward
    case kill_to_line_start
    case kill_to_line_end
    case delete_char_backward
    case delete_char_forward
    case insert_newline
    case move_line_up
    case move_line_down
    case move_char_left
    case move_char_right
    case page_up
    case page_down
    case goto_line_start
    case goto_line_end_newline

    var info: Info {
        switch self {

        case .normal_mode:
            return Info(key: "Escape", description: "Switch to normal mode")
        case .commit_undo_checkpoint:
            return Info(key: "Ctrl-s", description: "Commit undo checkpoint")
        case .completion:
            return Info(key: "Ctrl-x", description: "Autocomplete")
        case .insert_register:
            return Info(key: "Ctrl-r", description: "Insert a register content")
        case .delete_word_backward:
            return Info(key: "Ctrl-w, Alt-Backspace", description: "Delete previous word")
        case .delete_word_forward:
            return Info(key: "Alt-d, Alt-Delete", description: "Delete next word")
        case .kill_to_line_start:
            return Info(key: "Ctrl-u", description: "Delete to start of line")
        case .kill_to_line_end:
            return Info(key: "Ctrl-k", description: "Delete to end of line")
        case .delete_char_backward:
            return Info(key: "Ctrl-h, Backspace, Shift-Backspace", description: "Delete previous char")
        case .delete_char_forward:
            return Info(key: "Ctrl-d, Delete", description: "Delete next char")
        case .insert_newline:
            return Info(key: "Ctrl-j, Enter", description: "Insert new line")
        case .move_line_up:
            return Info(key: "Up", description: "Move to previous line")
        case .move_line_down:
            return Info(key: "Down", description: "Move to next line")
        case .move_char_left:
            return Info(key: "Left", description: "Backward a char")
        case .move_char_right:
            return Info(key: "Right", description: "Forward a char")
        case .page_up:
            return Info(key: "PageUp", description: "Move one page up")
        case .page_down:
            return Info(key: "PageDown", description: "Move one page down")
        case .goto_line_start:
            return Info(key: "Home", description: "Move to line start")
        case .goto_line_end_newline:
            return Info(key: "End", description: "Move to line end")
        }
    }
}
