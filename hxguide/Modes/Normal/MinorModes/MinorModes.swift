//
//  MinorModers.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

enum MinorModes:String, CaseIterable {
    typealias Info = Helix.KeyInfo
    
    case select_mode
    case goto_mode
    case match_mode
    case command_mode
    case view_mode
    case sticky_view_mode
    case window_mode
    case space_mode
    
    var info:Info {
        switch self {
            
        case .select_mode:
            return Info(key: "v",
                        description: "Enter select (extend) mode")
        case .goto_mode:
            return Info(key: "g",
                        description: "Enter goto mode")
        case .match_mode:
            return Info(key: "m", description: "Enter match mode")
        case .command_mode:
            return Info(key: ":", description: "Enter command mode")
        case .view_mode:
            return Info(key: "z", description: "Enter view mode")
        case .sticky_view_mode:
            return Info(key: "Z", description: "Enter sticky view mode")
        case .window_mode:
            return Info(key: "w", description: "Enter window mode")
        case .space_mode:
            return Info(key: "space", description: "Enter space mode")
        }
    }
}
/**
 Minor modes

 These sub-modes are accessible from normal mode and typically switch back to normal mode after a command.

 Key    Description    Command
 v    Enter select (extend) mode    select_mode
 g    Enter goto mode    N/A
 m    Enter match mode    N/A
 :    Enter command mode    command_mode
 z    Enter view mode    N/A
 Z    Enter sticky view mode    N/A
 Ctrl-w    Enter window mode    N/A
 Space    Enter space mode    N/A

 */
