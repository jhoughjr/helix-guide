//
//  MinorModes.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

/// The keys that enter each minor mode from normal mode. Most minor modes switch
/// back to normal mode after a single command.
enum MinorModes: String, CaseIterable, KeyCommandEnum {
    typealias Info = Helix.KeyInfo

    case select_mode
    case na_goto_mode
    case na_match_mode
    case command_mode
    case na_view_mode
    case na_sticky_view_mode
    case na_window_mode
    case na_space_mode

    var info: Info {
        switch self {

        case .select_mode:
            return Info(key: "v", description: "Enter select (extend) mode")
        case .na_goto_mode:
            return Info(key: "g", description: "Enter goto mode")
        case .na_match_mode:
            return Info(key: "m", description: "Enter match mode")
        case .command_mode:
            return Info(key: ":", description: "Enter command mode")
        case .na_view_mode:
            return Info(key: "z", description: "Enter view mode")
        case .na_sticky_view_mode:
            return Info(key: "Z", description: "Enter sticky view mode")
        case .na_window_mode:
            return Info(key: "Ctrl-w", description: "Enter window mode")
        case .na_space_mode:
            return Info(key: "Space", description: "Enter space mode")
        }
    }
}
