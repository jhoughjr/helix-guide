//
//  Window.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

/// Window mode — accessed by typing `Ctrl-w` (or `Space w`) in normal mode.
/// This layer is similar to Vim keybindings, as Kakoune does not support windows.
enum WindowCommands: String, CaseIterable, KeyCommandEnum {
    typealias Info = Helix.KeyInfo

    case rotate_view
    case vsplit
    case hsplit
    case goto_file_hsplit
    case goto_file_vsplit
    case jump_view_left
    case jump_view_down
    case jump_view_up
    case jump_view_right
    case wclose
    case wonly
    case swap_view_left
    case swap_view_down
    case swap_view_up
    case swap_view_right

    var info: Info {
        switch self {

        case .rotate_view:
            return Info(key: "w, Ctrl-w", description: "Switch to next window")
        case .vsplit:
            return Info(key: "v, Ctrl-v", description: "Vertical right split")
        case .hsplit:
            return Info(key: "s, Ctrl-s", description: "Horizontal bottom split")
        case .goto_file_hsplit:
            return Info(key: "f", description: "Go to files in the selection in horizontal splits (goto_file)")
        case .goto_file_vsplit:
            return Info(key: "F", description: "Go to files in the selection in vertical splits (goto_file)")
        case .jump_view_left:
            return Info(key: "h, Ctrl-h, Left", description: "Move to left split")
        case .jump_view_down:
            return Info(key: "j, Ctrl-j, Down", description: "Move to split below")
        case .jump_view_up:
            return Info(key: "k, Ctrl-k, Up", description: "Move to split above")
        case .jump_view_right:
            return Info(key: "l, Ctrl-l, Right", description: "Move to right split")
        case .wclose:
            return Info(key: "q, Ctrl-q", description: "Close current window")
        case .wonly:
            return Info(key: "o, Ctrl-o", description: "Only keep the current window, closing all the others")
        case .swap_view_left:
            return Info(key: "H", description: "Swap window to the left")
        case .swap_view_down:
            return Info(key: "J", description: "Swap window downwards")
        case .swap_view_up:
            return Info(key: "K", description: "Swap window upwards")
        case .swap_view_right:
            return Info(key: "L", description: "Swap window to the right")
        }
    }
}
