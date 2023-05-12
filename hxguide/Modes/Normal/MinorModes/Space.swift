//
//  File.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation
/** Space mode
 
 Accessed by typing Space in normal mode.

 This layer is a kludge of mappings, mostly pickers.

 Key    Description    Command
 f    Open file picker    file_picker
 F    Open file picker at current working directory    file_picker_in_current_directory
 b    Open buffer picker    buffer_picker
 j    Open jumplist picker    jumplist_picker
 g    Debug (experimental)    N/A
 k    Show documentation for item under cursor in a popup (LSP)    hover
 s    Open document symbol picker (LSP)    symbol_picker
 S    Open workspace symbol picker (LSP)    workspace_symbol_picker
 d    Open document diagnostics picker (LSP)    diagnostics_picker
 D    Open workspace diagnostics picker (LSP)    workspace_diagnostics_picker
 r    Rename symbol (LSP)    rename_symbol
 a    Apply code action (LSP)    code_action
 h    Select symbol references (LSP)    select_references_to_symbol_under_cursor
 '    Open last fuzzy picker    last_picker
 w    Enter window mode    N/A
 p    Paste system clipboard after selections    paste_clipboard_after
 P    Paste system clipboard before selections    paste_clipboard_before
 y    Join and yank selections to clipboard    yank_joined_to_clipboard
 Y    Yank main selection to clipboard    yank_main_selection_to_clipboard
 R    Replace selections by clipboard contents    replace_selections_with_clipboard
 /    Global search in workspace folder    global_search
 ?    Open command palette    command_palette

 */
