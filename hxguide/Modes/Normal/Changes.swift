//
//  Changes.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation
typealias Info = Helix.KeyInfo

enum ChangeCommands:String, CaseIterable {
    
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
    case undo_change
    case redo_change
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
    
    var info:Info {
        switch self {
            
        case .replace:
            return Info(key: "r", description: "Replace a character")
        case .replace_with_yanked:
            return Info(key: "R", description: "Replace with yanked text")
        case .switch_case:
            return Info(key: "~", description: "Switch case of selected text")
        case .switch_to_lowercase:
            return Info(key: "`", description: "Switch to lowercase")
        case .switch_to_uppercase:
            return Info(key: "alt-`", description: "Switch to uppercase")
        case .insert_mode:
            return Info(key: "i", description: "Insert before selection")
        case .append_mode:
            return Info(key: "a", description: "Insert after selection")
        case .insert_at_line_start:
            return Info(key: "I", description: "Insert at line start")
        case .insert_at_line_end:
            return Info(key: "A", description: "Insert at line end")
        case .open_below:
            return Info(key: "o", description: "Open new line below selection")
        case .open_above:
            return Info(key: "O", description: "Open new line above selection")
        case .na_repeat_last_insert:
            return Info(key: ".", description: "Repeat last insert")
        case .undo_change:
            return Info(key: "u", description: "Undo last change")
        case .redo_change:
            return Info(key: "U", description: "Redo last change")
        case .earlier:
            return Info(key: "alt-u", description: "Move earlier in history")
        case .later:
            return Info(key: "alt-U", description: "Move forward in history")
        case .yank:
            return Info(key: "y", description: "Yank selection")
        case .paste_after:
            return Info(key: "p", description: "Paste after selection")
        case .paste_before:
            return Info(key: "P", description: "Paste before selection")
        case .select_register:
            return Info(key: "\" <reg>", description: "Select register")
        case .indent:
            return Info(key: ">", description: "Indent selection")
        case .unindent:
            return Info(key: "<", description: "Unindent selection")
        case .format_selections:
            return Info(key: "=", description: "Format selection")
        case .delete_selection:
            return Info(key: "d", description: "Delete selection")
        case .delete_selection_noyank:
            return Info(key: "D", description: "Delete selection noyank")
        case .change_selection:
            return Info(key: "c", description: "Delete selection and enter insert mode")
        case .change_selection_noyank:
            return Info(key: "alt-c", description: "Delete selection and enter insert mode without yannking")
        case .increment:
            return Info(key: "ctl-a", description: "Increment number under cursor")
        case .decrement:
            return Info(key: "ctl-x", description: "Decrement number under cursor")
        case .record_macro:
            return Info(key: "Q", description: "Start/stop macro recording")
        case .replay_macro:
            return Info(key: "q", description: "Play recorded macro")
        }
    }
}

/*
 Changes

 Key    Description    Command
 r    Replace with a character    replace
 R    Replace with yanked text    replace_with_yanked
 ~    Switch case of the selected text    switch_case
 `    Set the selected text to lower case    switch_to_lowercase
 Alt-`    Set the selected text to upper case    switch_to_uppercase
 i    Insert before selection    insert_mode
 a    Insert after selection (append)    append_mode
 I    Insert at the start of the line    insert_at_line_start
 A    Insert at the end of the line    insert_at_line_end
 o    Open new line below selection    open_below
 O    Open new line above selection    open_above
 .    Repeat last insert    N/A
 u    Undo change    undo
 U    Redo change    redo
 Alt-u    Move backward in history    earlier
 Alt-U    Move forward in history    later
 y    Yank selection    yank
 p    Paste after selection    paste_after
 P    Paste before selection    paste_before
 " <reg>    Select a register to yank to or paste from    select_register
 >    Indent selection    indent
 <    Unindent selection    unindent
 =    Format selection (currently nonfunctional/disabled) (LSP)    format_selections
 d    Delete selection    delete_selection
 Alt-d    Delete selection, without yanking    delete_selection_noyank
 c    Change selection (delete and enter insert mode)    change_selection
 Alt-c    Change selection (delete and enter insert mode, without yanking)    change_selection_noyank
 Ctrl-a    Increment object (number) under cursor    increment
 Ctrl-x    Decrement object (number) under cursor    decrement
 Q    Start/stop macro recording to the selected register (experimental)    record_macro
 q    Play back a recorded macro from the selected register (experimental)    replay_macro
 */
