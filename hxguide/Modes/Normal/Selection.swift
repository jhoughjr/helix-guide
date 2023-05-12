//
//  Selection.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

enum SelectionManipulationCommands:String, CaseIterable {
    typealias Info = Helix.KeyInfo
    
    case select_regex
    
    var info:Info {
        switch self {
            
        case .select_regex:
            return Info(key: "s", description: "Select all regex matches inside selections")
        }
    }
}
/**
 Selection manipulation

 Key    Description    Command
 s    Select all regex matches inside selections    select_regex
 S    Split selection into sub selections on regex matches    split_selection
 Alt-s    Split selection on newlines    split_selection_on_newline
 Alt-_    Merge consecutive selections    merge_consecutive_selections
 &    Align selection in columns    align_selections
 _    Trim whitespace from the selection    trim_selections
 ;    Collapse selection onto a single cursor    collapse_selection
 Alt-;    Flip selection cursor and anchor    flip_selections
 Alt-:    Ensures the selection is in forward direction    ensure_selections_forward
 ,    Keep only the primary selection    keep_primary_selection
 Alt-,    Remove the primary selection    remove_primary_selection
 C    Copy selection onto the next line (Add cursor below)    copy_selection_on_next_line
 Alt-C    Copy selection onto the previous line (Add cursor above)    copy_selection_on_prev_line
 (    Rotate main selection backward    rotate_selections_backward
 )    Rotate main selection forward    rotate_selections_forward
 Alt-(    Rotate selection contents backward    rotate_selection_contents_backward
 Alt-)    Rotate selection contents forward    rotate_selection_contents_forward
 %    Select entire file    select_all
 x    Select current line, if already selected, extend to next line    extend_line_below
 X    Extend selection to line bounds (line-wise selection)    extend_to_line_bounds
 Alt-x    Shrink selection to line bounds (line-wise selection)    shrink_to_line_bounds
 J    Join lines inside selection    join_selections
 Alt-J    Join lines inside selection and select the inserted space    join_selections_space
 K    Keep selections matching the regex    keep_selections
 Alt-K    Remove selections matching the regex    remove_selections
 Ctrl-c    Comment/uncomment the selections    toggle_comments
 Alt-o, Alt-up    Expand selection to parent syntax node (TS)    expand_selection
 Alt-i, Alt-down    Shrink syntax tree object selection (TS)    shrink_selection
 Alt-p, Alt-left    Select previous sibling node in syntax tree (TS)    select_prev_sibling
 Alt-n, Alt-right    Select next sibling node in syntax tree (TS)    select_next_sibling
 */
