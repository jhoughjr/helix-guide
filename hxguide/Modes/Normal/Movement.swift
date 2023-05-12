//
//  Movement.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

enum MovementCommands:String, CaseIterable {
   
    typealias Info = Helix.KeyInfo
    case move_char_left
    case move_line_down
    case move_line_up
    case move_char_right
    case move_next_word_start
    case move_prev_word_start
    case move_next_word_end
    case move_next_long_word_start
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

    var info:Info {
        switch self {
            
        case .move_char_left:
            return Info(key: "h", description: "Move left")
        case .move_line_down:
            return Info(key:"j", description: "Move down")
        case .move_line_up:
            return Info(key:"k", description: "Move up")
        case .move_char_right:
            return Info(key:"l", description: "Move right")
        case .move_next_word_start:
            return Info(key:"w", description: "Move to next word start")
        case .move_prev_word_start:
            return Info(key:"b", description: "Move to prev word start")
        case .move_next_word_end:
            return Info(key:"e", description: "Move to next word end")
        case .move_next_long_word_start:
            return Info(key:"W", description: "Move to next WORD start")
        case .move_next_long_word_end:
            return Info(key:"B", description: "Move to previous WORD start")
        case .find_till_char:
            return Info(key:"t", description: "Find till char")
        case .find_next_char:
            return Info(key:"f", description: "Find next char")
        case .till_prev_char:
            return Info(key:"T", description: "Find till previous char")
        case .find_prev_char:
            return Info(key:"F", description: "Find previous char")
        case .goto_line:
            return Info(key:"G", description: "Move to line number")
        case .repeat_last_motion:
            return Info(key:"alt-.", description: "Repeat last motion (f,t,m)")
        case .goto_line_start:
            return Info(key:"HOME", description: "Move to line start")
        case .goto_line_end:
            return Info(key:"END", description: "Move to line end")
        case .page_up:
            return Info(key:"PAGEUP, ctl-b", description: "Move 1 page up")
        case .page_down:
            return Info(key:"PAGEDOWN, ctl-f", description: "Move 1 page down")
        case .half_page_up:
            return Info(key:"ctl-u", description: "Move 1/2 page up")
        case .half_page_down:
            return Info(key:"ctl-d", description: "Move 1/2 page down")
        case .jump_forward:
            return Info(key:"ctl-i", description: "Jump forward in jumplist")
        case .jump_backward:
            return Info(key:"ctl-o", description: "Jump backward in jumplist")
        case .save_selection:
            return Info(key:"ctl-s", description: "Save selection to jumplist")
        }
    }
    
    /*
    Key    Description    Command
    h, Left    Move left    move_char_left
    j, Down    Move down    move_line_down
    k, Up    Move up    move_line_up
    l, Right    Move right    move_char_right
    w    Move next word start    move_next_word_start
    b    Move previous word start    move_prev_word_start
    e    Move next word end    move_next_word_end
    W    Move next WORD start    move_next_long_word_start
    B    Move previous WORD start    move_prev_long_word_start
    E    Move next WORD end    move_next_long_word_end
    t    Find 'till next char    find_till_char
    f    Find next char    find_next_char
    T    Find 'till previous char    till_prev_char
    F    Find previous char    find_prev_char
    G    Go to line number <n>    goto_line
    Alt-.    Repeat last motion (f, t or m)    repeat_last_motion
    Home    Move to the start of the line    goto_line_start
    End    Move to the end of the line    goto_line_end
    Ctrl-b, PageUp    Move page up    page_up
    Ctrl-f, PageDown    Move page down    page_down
    Ctrl-u    Move half page up    half_page_up
    Ctrl-d    Move half page down    half_page_down
    Ctrl-i    Jump forward on the jumplist    jump_forward
    Ctrl-o    Jump backward on the jumplist    jump_backward
    Ctrl-s    Save the current selection to the jumplist    save_selection
    */
    
}
