//
//  Movement.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

enum MovementCommands: String, CaseIterable, KeyCommandEnum {

    typealias Info = Helix.KeyInfo

    case move_char_left
    case move_line_down
    case move_line_up
    case move_char_right
    case move_next_word_start
    case move_prev_word_start
    case move_next_word_end
    case move_next_long_word_start
    case move_prev_long_word_start
    case move_next_long_word_end
    case find_till_char
    case find_next_char
    case till_prev_char
    case find_prev_char
    case goto_line
    case repeat_last_motion
    case goto_line_start
    case goto_line_end
    case page_up
    case page_down
    case half_page_up
    case half_page_down
    case jump_forward
    case jump_backward
    case save_selection

    var info: Info {
        switch self {

        case .move_char_left:
            return Info(key: "h, Left", description: "Move left")
        case .move_line_down:
            return Info(key: "j, Down", description: "Move down")
        case .move_line_up:
            return Info(key: "k, Up", description: "Move up")
        case .move_char_right:
            return Info(key: "l, Right", description: "Move right")
        case .move_next_word_start:
            return Info(key: "w", description: "Move next word start")
        case .move_prev_word_start:
            return Info(key: "b", description: "Move previous word start")
        case .move_next_word_end:
            return Info(key: "e", description: "Move next word end")
        case .move_next_long_word_start:
            return Info(key: "W", description: "Move next WORD start")
        case .move_prev_long_word_start:
            return Info(key: "B", description: "Move previous WORD start")
        case .move_next_long_word_end:
            return Info(key: "E", description: "Move next WORD end")
        case .find_till_char:
            return Info(key: "t", description: "Find 'till next char")
        case .find_next_char:
            return Info(key: "f", description: "Find next char")
        case .till_prev_char:
            return Info(key: "T", description: "Find 'till previous char")
        case .find_prev_char:
            return Info(key: "F", description: "Find previous char")
        case .goto_line:
            return Info(key: "G", description: "Go to line number <n>")
        case .repeat_last_motion:
            return Info(key: "Alt-.", description: "Repeat last motion (f, t or m)")
        case .goto_line_start:
            return Info(key: "Home", description: "Move to the start of the line")
        case .goto_line_end:
            return Info(key: "End", description: "Move to the end of the line")
        case .page_up:
            return Info(key: "Ctrl-b, PageUp", description: "Move page up")
        case .page_down:
            return Info(key: "Ctrl-f, PageDown", description: "Move page down")
        case .half_page_up:
            return Info(key: "Ctrl-u", description: "Move half page up")
        case .half_page_down:
            return Info(key: "Ctrl-d", description: "Move half page down")
        case .jump_forward:
            return Info(key: "Ctrl-i", description: "Jump forward on the jumplist")
        case .jump_backward:
            return Info(key: "Ctrl-o", description: "Jump backward on the jumplist")
        case .save_selection:
            return Info(key: "Ctrl-s", description: "Save the current selection to the jumplist")
        }
    }
}
