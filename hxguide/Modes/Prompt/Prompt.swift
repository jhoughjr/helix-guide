//
//  Prompt.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

/// Keys used within the prompt. Remapping is not currently supported,
/// so none of these map to a rebindable Helix command name.
enum PromptCommands: String, CaseIterable, KeyCommandEnum {
    typealias Info = Helix.KeyInfo

    case na_close_prompt
    case na_backward_word
    case na_backward_char
    case na_forward_word
    case na_forward_char
    case na_move_prompt_end
    case na_move_prompt_start
    case na_delete_word_backward
    case na_delete_word_forward
    case na_kill_to_line_start
    case na_kill_to_line_end
    case na_delete_char_backward
    case na_delete_char_forward
    case na_insert_word_under_cursor
    case na_previous_history
    case na_next_history
    case na_insert_register
    case na_next_completion
    case na_previous_completion
    case na_open_selected

    var info: Info {
        switch self {

        case .na_close_prompt:
            return Info(key: "Escape, Ctrl-c", description: "Close prompt")
        case .na_backward_word:
            return Info(key: "Alt-b, Ctrl-Left", description: "Backward a word")
        case .na_backward_char:
            return Info(key: "Ctrl-b, Left", description: "Backward a char")
        case .na_forward_word:
            return Info(key: "Alt-f, Ctrl-Right", description: "Forward a word")
        case .na_forward_char:
            return Info(key: "Ctrl-f, Right", description: "Forward a char")
        case .na_move_prompt_end:
            return Info(key: "Ctrl-e, End", description: "Move to prompt end")
        case .na_move_prompt_start:
            return Info(key: "Ctrl-a, Home", description: "Move to prompt start")
        case .na_delete_word_backward:
            return Info(key: "Ctrl-w, Alt-Backspace, Ctrl-Backspace", description: "Delete previous word")
        case .na_delete_word_forward:
            return Info(key: "Alt-d, Alt-Delete, Ctrl-Delete", description: "Delete next word")
        case .na_kill_to_line_start:
            return Info(key: "Ctrl-u", description: "Delete to start of line")
        case .na_kill_to_line_end:
            return Info(key: "Ctrl-k", description: "Delete to end of line")
        case .na_delete_char_backward:
            return Info(key: "Backspace, Ctrl-h, Shift-Backspace", description: "Delete previous char")
        case .na_delete_char_forward:
            return Info(key: "Delete, Ctrl-d", description: "Delete next char")
        case .na_insert_word_under_cursor:
            return Info(key: "Ctrl-s", description: "Insert a word under doc cursor, may be changed to Ctrl-r Ctrl-w later")
        case .na_previous_history:
            return Info(key: "Ctrl-p, Up", description: "Select previous history")
        case .na_next_history:
            return Info(key: "Ctrl-n, Down", description: "Select next history")
        case .na_insert_register:
            return Info(key: "Ctrl-r", description: "Insert the content of the register selected by following input char")
        case .na_next_completion:
            return Info(key: "Tab", description: "Select next completion item")
        case .na_previous_completion:
            return Info(key: "BackTab", description: "Select previous completion item")
        case .na_open_selected:
            return Info(key: "Enter", description: "Open selected")
        }
    }
}
