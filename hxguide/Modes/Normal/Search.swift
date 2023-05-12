//
//  Search.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

enum SearchCommands:String, CaseIterable {
    typealias Info = Helix.KeyInfo
    
    case search
    case rsearch
    case search_next
    case search_prev
    case search_selection
    
    var info:Info {
        switch self {
            
        case .search:
            return Info(key: ".", description: "Search for regex pattern")
        case .rsearch:
            return Info(key: "?", description: "Search for previous pattern")
        case .search_next:
            return Info(key: "n", description: "Select next search match")
        case .search_prev:
            return Info(key: "N", description: "Select previous search match")
        case .search_selection:
            return Info(key: "*", description: "Use current selection as search pattern")
        }
    }
}
/*
 Search

 Search commands all operate on the / register by default. To use a different register, use "<char>.

 Key    Description    Command
 /    Search for regex pattern    search
 ?    Search for previous pattern    rsearch
 n    Select next search match    search_next
 N    Select previous search match    search_prev
 *    Use current selection as the search pattern    search_selection
*/
