//
//  Match.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

/// Match mode — accessed by typing `m` in normal mode.
/// See the Usage chapter of the Helix book for surround and textobject semantics.
enum MatchCommands: String, CaseIterable, KeyCommandEnum {
    typealias Info = Helix.KeyInfo

    case match_brackets
    case surround_add
    case surround_replace
    case surround_delete
    case select_textobject_around
    case select_textobject_inner

    var info: Info {
        switch self {

        case .match_brackets:
            return Info(key: "m", description: "Goto matching bracket (TS)")
        case .surround_add:
            return Info(key: "s <char>", description: "Surround current selection with <char>")
        case .surround_replace:
            return Info(key: "r <from><to>", description: "Replace surround character <from> with <to>")
        case .surround_delete:
            return Info(key: "d <char>", description: "Delete surround character <char>")
        case .select_textobject_around:
            return Info(key: "a <object>", description: "Select around textobject")
        case .select_textobject_inner:
            return Info(key: "i <object>", description: "Select inside textobject")
        }
    }
}
