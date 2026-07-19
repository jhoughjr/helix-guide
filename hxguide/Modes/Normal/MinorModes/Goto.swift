//
//  Goto.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

/// Goto mode — accessed by typing `g` in normal mode. Jumps to various locations.
enum GotoCommands: String, CaseIterable, KeyCommandEnum {
    typealias Info = Helix.KeyInfo

    case goto_file_start
    case goto_last_line
    case goto_file
    case goto_line_start
    case goto_line_end
    case goto_first_nonwhitespace
    case goto_window_top
    case goto_window_center
    case goto_window_bottom
    case goto_definition
    case goto_type_definition
    case goto_reference
    case goto_implementation
    case goto_last_accessed_file
    case goto_last_modified_file
    case goto_next_buffer
    case goto_previous_buffer
    case goto_last_modification

    var info: Info {
        switch self {

        case .goto_file_start:
            return Info(key: "g", description: "Go to line number <n>, else start of file")
        case .goto_last_line:
            return Info(key: "e", description: "Go to the end of the file")
        case .goto_file:
            return Info(key: "f", description: "Go to files in the selection")
        case .goto_line_start:
            return Info(key: "h", description: "Go to the start of the line")
        case .goto_line_end:
            return Info(key: "l", description: "Go to the end of the line")
        case .goto_first_nonwhitespace:
            return Info(key: "s", description: "Go to first non-whitespace character of the line")
        case .goto_window_top:
            return Info(key: "t", description: "Go to the top of the screen")
        case .goto_window_center:
            return Info(key: "c", description: "Go to the middle of the screen")
        case .goto_window_bottom:
            return Info(key: "b", description: "Go to the bottom of the screen")
        case .goto_definition:
            return Info(key: "d", description: "Go to definition (LSP)")
        case .goto_type_definition:
            return Info(key: "y", description: "Go to type definition (LSP)")
        case .goto_reference:
            return Info(key: "r", description: "Go to references (LSP)")
        case .goto_implementation:
            return Info(key: "i", description: "Go to implementation (LSP)")
        case .goto_last_accessed_file:
            return Info(key: "a", description: "Go to the last accessed/alternate file")
        case .goto_last_modified_file:
            return Info(key: "m", description: "Go to the last modified/alternate file")
        case .goto_next_buffer:
            return Info(key: "n", description: "Go to next buffer")
        case .goto_previous_buffer:
            return Info(key: "p", description: "Go to previous buffer")
        case .goto_last_modification:
            return Info(key: ".", description: "Go to last modification in current file")
        }
    }
}
