//
//  Space.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

/// Space mode — accessed by typing `Space` in normal mode.
/// This layer is a kludge of mappings, mostly pickers.
enum SpaceCommands: String, CaseIterable, KeyCommandEnum {
    typealias Info = Helix.KeyInfo

    case file_picker
    case file_picker_in_current_directory
    case buffer_picker
    case jumplist_picker
    case changed_file_picker
    case na_debug
    case hover
    case symbol_picker
    case workspace_symbol_picker
    case diagnostics_picker
    case workspace_diagnostics_picker
    case rename_symbol
    case code_action
    case select_references_to_symbol_under_cursor
    case last_picker
    case na_window_mode
    case toggle_comments
    case toggle_block_comments
    case toggle_line_comments
    case paste_clipboard_after
    case paste_clipboard_before
    case yank_to_clipboard
    case yank_main_selection_to_clipboard
    case replace_selections_with_clipboard
    case global_search
    case command_palette

    var info: Info {
        switch self {

        case .file_picker:
            return Info(key: "f", description: "Open file picker at LSP workspace root")
        case .file_picker_in_current_directory:
            return Info(key: "F", description: "Open file picker at current working directory")
        case .buffer_picker:
            return Info(key: "b", description: "Open buffer picker")
        case .jumplist_picker:
            return Info(key: "j", description: "Open jumplist picker")
        case .changed_file_picker:
            return Info(key: "g", description: "Open changed file picker")
        case .na_debug:
            return Info(key: "G", description: "Debug (experimental)")
        case .hover:
            return Info(key: "k", description: "Show documentation for item under cursor in a popup (LSP)")
        case .symbol_picker:
            return Info(key: "s", description: "Open document symbol picker (LSP)")
        case .workspace_symbol_picker:
            return Info(key: "S", description: "Open workspace symbol picker (LSP)")
        case .diagnostics_picker:
            return Info(key: "d", description: "Open document diagnostics picker (LSP)")
        case .workspace_diagnostics_picker:
            return Info(key: "D", description: "Open workspace diagnostics picker (LSP)")
        case .rename_symbol:
            return Info(key: "r", description: "Rename symbol (LSP)")
        case .code_action:
            return Info(key: "a", description: "Apply code action (LSP)")
        case .select_references_to_symbol_under_cursor:
            return Info(key: "h", description: "Select symbol references (LSP)")
        case .last_picker:
            return Info(key: "'", description: "Open last fuzzy picker")
        case .na_window_mode:
            return Info(key: "w", description: "Enter window mode")
        case .toggle_comments:
            return Info(key: "c", description: "Comment/uncomment selections")
        case .toggle_block_comments:
            return Info(key: "C", description: "Block comment/uncomment selections")
        case .toggle_line_comments:
            return Info(key: "Alt-c", description: "Line comment/uncomment selections")
        case .paste_clipboard_after:
            return Info(key: "p", description: "Paste system clipboard after selections")
        case .paste_clipboard_before:
            return Info(key: "P", description: "Paste system clipboard before selections")
        case .yank_to_clipboard:
            return Info(key: "y", description: "Yank selections to clipboard")
        case .yank_main_selection_to_clipboard:
            return Info(key: "Y", description: "Yank main selection to clipboard")
        case .replace_selections_with_clipboard:
            return Info(key: "R", description: "Replace selections by clipboard contents")
        case .global_search:
            return Info(key: "/", description: "Global search in workspace folder")
        case .command_palette:
            return Info(key: "?", description: "Open command palette")
        }
    }
}
