//
//  Search.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

/// Search commands all operate on the `/` register by default.
/// To use a different register, prefix with `"<char>`.
enum SearchCommands: String, CaseIterable, KeyCommandEnum {
    typealias Info = Helix.KeyInfo

    case search
    case rsearch
    case search_next
    case search_prev
    case search_selection_detect_word_boundaries
    case search_selection

    var info: Info {
        switch self {

        case .search:
            return Info(key: "/", description: "Search for regex pattern")
        case .rsearch:
            return Info(key: "?", description: "Search for previous pattern")
        case .search_next:
            return Info(key: "n", description: "Select next search match")
        case .search_prev:
            return Info(key: "N", description: "Select previous search match")
        case .search_selection_detect_word_boundaries:
            return Info(key: "*", description: "Use current selection as the search pattern, automatically wrapping with \\b on word boundaries")
        case .search_selection:
            return Info(key: "Alt-*", description: "Use current selection as the search pattern")
        }
    }
}
