//
//  Insert.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

enum InsertCommands:String, CaseIterable {
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
    
    var info:Helix.KeyInfo {
        switch self {
            
        case .normal_mode:
            return Info(key: "ESC", description: "Switch to normal mode")
        case .commit_undo_checkpoint:
            return Info(key: "ctl-s", description: "Commit undo checkpoint")
        case .completion:
            return Info(key: "ctl-x", description: "Autocomplete")
        case .insert_register:
            return Info(key: "ctl-r", description: "Insert a Register content")
        case .delete_word_backward:
            return Info(key: "Ctrl-w, Alt-Backspace  ", description: "delete previous word")
        case .delete_word_forward:
            return Info(key: "Alt-d, Alt-Delete", description: "Delete next word")
        
        case .kill_to_line_start:
            return Info(key: "Ctl-u", description: "Delete to start of line")
        case .kill_to_line_end:
            return Info(key: "Ctrl-k", description: "Delete to end of line")
        case .delete_char_backward:
            return Info(key: "Ctrl-h, Backspace, Shift-Backspace", description: "Delete previous char")
        case .delete_char_forward:
            return Info(key: "Ctrl-d, Delete ", description: "Delete char forawrd")
        case .insert_newline:
            return Info(key: "Ctrl-j, Enter ", description: "Insert new line")
        case .move_line_up:
            return Info(key: "UP", description: "Move up")
        case .move_line_down:
            return Info(key: "DOWN", description: "Move down")
        case .move_char_left:
            return Info(key: "LEFT", description: "Move left")
        case .move_char_right:
            return Info(key: "RIGHT", description: "Move right")
        case .page_up:
            return Info(key: "PAGEUP", description: "Page up")
        case .page_down:
            return Info(key: "PAGEDOWN", description: "Page down")
        case .goto_line_start:
            return Info(key: "HOME", description: "Goto line start")
        case .goto_line_end_newline:
            return Info(key: "END", description: "Goto line end")
        }
    }
}
/**
 Insert mode

 Insert mode bindings are minimal by default. Helix is designed to be a modal editor, and this is reflected in the user experience and internal mechanics. Changes to the text are only saved for undos when escaping from insert mode to normal mode.

 💡 New users are strongly encouraged to learn the modal editing paradigm to get the smoothest experience.
 Key    Description    Command
 Escape    Switch to normal mode    normal_mode
 Ctrl-s    Commit undo checkpoint    commit_undo_checkpoint
 Ctrl-x    Autocomplete    completion
 Ctrl-r    Insert a register content    insert_register
 Ctrl-w, Alt-Backspace    Delete previous word    delete_word_backward
 Alt-d, Alt-Delete    Delete next word    delete_word_forward
 Ctrl-u    Delete to start of line    kill_to_line_start
 Ctrl-k    Delete to end of line    kill_to_line_end
 Ctrl-h, Backspace, Shift-Backspace    Delete previous char    delete_char_backward
 Ctrl-d, Delete    Delete next char    delete_char_forward
 Ctrl-j, Enter    Insert new line    insert_newline
 
 
 These keys are not recommended, but are included for new users less familiar with modal editors.

 Key    Description    Command
 Up    Move to previous line    move_line_up
 Down    Move to next line    move_line_down
 Left    Backward a char    move_char_left
 Right    Forward a char    move_char_right
 PageUp    Move one page up    page_up
 PageDown    Move one page down    page_down
 Home    Move to line start    goto_line_start
 End    Move to line end    goto_line_end_newline
 
 As you become more comfortable with modal editing, you may want to disable some insert mode bindings. You can do this by editing your config.toml file.


 [keys.insert]
 up = "no_op"
 down = "no_op"
 left = "no_op"
 right = "no_op"
 pageup = "no_op"
 pagedown = "no_op"
 home = "no_op"
 end = "no_op"*/
