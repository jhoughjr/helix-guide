//
//  Unimpaired.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

/// Unimpaired — bracket-prefixed motions in the style of vim-unimpaired.
enum UnimpairedCommands: String, CaseIterable, KeyCommandEnum {
    typealias Info = Helix.KeyInfo

    case goto_next_diag
    case goto_prev_diag
    case goto_last_diag
    case goto_first_diag
    case goto_next_function
    case goto_prev_function
    case goto_next_class
    case goto_prev_class
    case goto_next_parameter
    case goto_prev_parameter
    case goto_next_comment
    case goto_prev_comment
    case goto_next_test
    case goto_prev_test
    case goto_next_paragraph
    case goto_prev_paragraph
    case goto_next_change
    case goto_prev_change
    case goto_last_change
    case goto_first_change
    case add_newline_below
    case add_newline_above

    var info: Info {
        switch self {

        case .goto_next_diag:
            return Info(key: "]d", description: "Go to next diagnostic (LSP)")
        case .goto_prev_diag:
            return Info(key: "[d", description: "Go to previous diagnostic (LSP)")
        case .goto_last_diag:
            return Info(key: "]D", description: "Go to last diagnostic in document (LSP)")
        case .goto_first_diag:
            return Info(key: "[D", description: "Go to first diagnostic in document (LSP)")
        case .goto_next_function:
            return Info(key: "]f", description: "Go to next function (TS)")
        case .goto_prev_function:
            return Info(key: "[f", description: "Go to previous function (TS)")
        case .goto_next_class:
            return Info(key: "]t", description: "Go to next type definition (TS)")
        case .goto_prev_class:
            return Info(key: "[t", description: "Go to previous type definition (TS)")
        case .goto_next_parameter:
            return Info(key: "]a", description: "Go to next argument/parameter (TS)")
        case .goto_prev_parameter:
            return Info(key: "[a", description: "Go to previous argument/parameter (TS)")
        case .goto_next_comment:
            return Info(key: "]c", description: "Go to next comment (TS)")
        case .goto_prev_comment:
            return Info(key: "[c", description: "Go to previous comment (TS)")
        case .goto_next_test:
            return Info(key: "]T", description: "Go to next test (TS)")
        case .goto_prev_test:
            return Info(key: "[T", description: "Go to previous test (TS)")
        case .goto_next_paragraph:
            return Info(key: "]p", description: "Go to next paragraph")
        case .goto_prev_paragraph:
            return Info(key: "[p", description: "Go to previous paragraph")
        case .goto_next_change:
            return Info(key: "]g", description: "Go to next change")
        case .goto_prev_change:
            return Info(key: "[g", description: "Go to previous change")
        case .goto_last_change:
            return Info(key: "]G", description: "Go to last change")
        case .goto_first_change:
            return Info(key: "[G", description: "Go to first change")
        case .add_newline_below:
            return Info(key: "]Space", description: "Add newline below")
        case .add_newline_above:
            return Info(key: "[Space", description: "Add newline above")
        }
    }
}
