//
//  Selection.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

enum SelectionManipulationCommands: String, CaseIterable, KeyCommandEnum {
    typealias Info = Helix.KeyInfo

    case select_regex
    case split_selection
    case split_selection_on_newline
    case merge_consecutive_selections
    case align_selections
    case trim_selections
    case collapse_selection
    case flip_selections
    case ensure_selections_forward
    case keep_primary_selection
    case remove_primary_selection
    case copy_selection_on_next_line
    case copy_selection_on_prev_line
    case rotate_selections_backward
    case rotate_selections_forward
    case rotate_selection_contents_backward
    case rotate_selection_contents_forward
    case select_all
    case extend_line_below
    case extend_to_line_bounds
    case shrink_to_line_bounds
    case join_selections
    case join_selections_space
    case keep_selections
    case remove_selections
    case toggle_comments
    case expand_selection
    case shrink_selection
    case select_prev_sibling
    case select_next_sibling

    var info: Info {
        switch self {

        case .select_regex:
            return Info(key: "s", description: "Select all regex matches inside selections")
        case .split_selection:
            return Info(key: "S", description: "Split selection into sub selections on regex matches")
        case .split_selection_on_newline:
            return Info(key: "Alt-s", description: "Split selection on newlines")
        case .merge_consecutive_selections:
            return Info(key: "Alt-_", description: "Merge consecutive selections")
        case .align_selections:
            return Info(key: "&", description: "Align selection in columns")
        case .trim_selections:
            return Info(key: "_", description: "Trim whitespace from the selection")
        case .collapse_selection:
            return Info(key: ";", description: "Collapse selection onto a single cursor")
        case .flip_selections:
            return Info(key: "Alt-;", description: "Flip selection cursor and anchor")
        case .ensure_selections_forward:
            return Info(key: "Alt-:", description: "Ensure the selection is in forward direction")
        case .keep_primary_selection:
            return Info(key: ",", description: "Keep only the primary selection")
        case .remove_primary_selection:
            return Info(key: "Alt-,", description: "Remove the primary selection")
        case .copy_selection_on_next_line:
            return Info(key: "C", description: "Copy selection onto the next line (add cursor below)")
        case .copy_selection_on_prev_line:
            return Info(key: "Alt-C", description: "Copy selection onto the previous line (add cursor above)")
        case .rotate_selections_backward:
            return Info(key: "(", description: "Rotate main selection backward")
        case .rotate_selections_forward:
            return Info(key: ")", description: "Rotate main selection forward")
        case .rotate_selection_contents_backward:
            return Info(key: "Alt-(", description: "Rotate selection contents backward")
        case .rotate_selection_contents_forward:
            return Info(key: "Alt-)", description: "Rotate selection contents forward")
        case .select_all:
            return Info(key: "%", description: "Select entire file")
        case .extend_line_below:
            return Info(key: "x", description: "Select current line; if already selected, extend to next line")
        case .extend_to_line_bounds:
            return Info(key: "X", description: "Extend selection to line bounds (line-wise selection)")
        case .shrink_to_line_bounds:
            return Info(key: "Alt-x", description: "Shrink selection to line bounds (line-wise selection)")
        case .join_selections:
            return Info(key: "J", description: "Join lines inside selection")
        case .join_selections_space:
            return Info(key: "Alt-J", description: "Join lines inside selection and select the inserted space")
        case .keep_selections:
            return Info(key: "K", description: "Keep selections matching the regex")
        case .remove_selections:
            return Info(key: "Alt-K", description: "Remove selections matching the regex")
        case .toggle_comments:
            return Info(key: "Ctrl-c", description: "Comment/uncomment the selections")
        case .expand_selection:
            return Info(key: "Alt-o, Alt-Up", description: "Expand selection to parent syntax node (TS)")
        case .shrink_selection:
            return Info(key: "Alt-i, Alt-Down", description: "Shrink syntax tree object selection (TS)")
        case .select_prev_sibling:
            return Info(key: "Alt-p, Alt-Left", description: "Select previous sibling node in syntax tree (TS)")
        case .select_next_sibling:
            return Info(key: "Alt-n, Alt-Right", description: "Select next sibling node in syntax tree (TS)")
        }
    }
}
