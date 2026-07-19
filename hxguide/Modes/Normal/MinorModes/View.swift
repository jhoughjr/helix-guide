//
//  View.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

/// View mode — accessed by typing `z` in normal mode.
///
/// View mode is intended for scrolling and manipulating the view without changing the
/// selection. The "sticky" variant (accessed by typing `Z`) is persistent and exits with
/// Escape — useful when looking over text rather than actively editing it.
enum ViewCommands: String, CaseIterable, KeyCommandEnum {
    typealias Info = Helix.KeyInfo

    case align_view_center
    case align_view_top
    case align_view_bottom
    case align_view_middle
    case scroll_down
    case scroll_up
    case page_down
    case page_up
    case page_cursor_half_down
    case page_cursor_half_up

    var info: Info {
        switch self {

        case .align_view_center:
            return Info(key: "z, c", description: "Vertically center the line")
        case .align_view_top:
            return Info(key: "t", description: "Align the line to the top of the screen")
        case .align_view_bottom:
            return Info(key: "b", description: "Align the line to the bottom of the screen")
        case .align_view_middle:
            return Info(key: "m", description: "Align the line to the middle of the screen (horizontally)")
        case .scroll_down:
            return Info(key: "j, Down", description: "Scroll the view downwards")
        case .scroll_up:
            return Info(key: "k, Up", description: "Scroll the view upwards")
        case .page_down:
            return Info(key: "Ctrl-f, PageDown", description: "Move page down")
        case .page_up:
            return Info(key: "Ctrl-b, PageUp", description: "Move page up")
        case .page_cursor_half_down:
            return Info(key: "Ctrl-d", description: "Move cursor and page half page down")
        case .page_cursor_half_up:
            return Info(key: "Ctrl-u", description: "Move cursor and page half page up")
        }
    }
}
