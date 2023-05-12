//
//  Prompt.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

enum PromptCommands:String, CaseIterable {
    typealias Info = Helix.KeyInfo
    
    case na_close_prompt
    var info:Info {
        switch self {
            
        case .na_close_prompt:
            return Info(key: "ESC, CTRL-C", description: "Close prompt")
        }
    }
}
/** Prompt
 
 Keys to use within prompt, Remapping currently not supported.

 Key    Description
 Escape, Ctrl-c    Close prompt
 Alt-b, Ctrl-Left    Backward a word
 Ctrl-b, Left    Backward a char
 Alt-f, Ctrl-Right    Forward a word
 Ctrl-f, Right    Forward a char
 Ctrl-e, End    Move prompt end
 Ctrl-a, Home    Move prompt start
 Ctrl-w, Alt-Backspace, Ctrl-Backspace    Delete previous word
 Alt-d, Alt-Delete, Ctrl-Delete    Delete next word
 Ctrl-u    Delete to start of line
 Ctrl-k    Delete to end of line
 Backspace, Ctrl-h, Shift-Backspace    Delete previous char
 Delete, Ctrl-d    Delete next char
 Ctrl-s    Insert a word under doc cursor, may be changed to Ctrl-r Ctrl-w later
 Ctrl-p, Up    Select previous history
 Ctrl-n, Down    Select next history
 Ctrl-r    Insert the content of the register selected by following input char
 Tab    Select next completion item
 BackTab    Select previous completion item
 Enter    Open selected

 */
