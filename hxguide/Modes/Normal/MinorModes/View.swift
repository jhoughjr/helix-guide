//
//  View.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

enum ViewCommands:String, CaseIterable {
    typealias Info = Helix.KeyInfo
    
    case align_view_center
    case align_view_top
    case align_view_bottom
    case align_view_middle
    case scroll_down
    case scroll_up
    case page_down
    case page_up
    case half_page_down
    case half_page_up
    
    var info:Info {
        switch self {
            
        case .align_view_center:
            return Info(key: "z,c", description: "Vertically center the line")
        case .align_view_top:
            return Info(key: "t", description: "Align the line to the top of the screen ")
        case .align_view_bottom:
            return Info(key: "b", description: "Align the line to the bottom of the screen")
        case .align_view_middle:
            return Info(key: "m", description: "Align the line to the middle of the screen (horizontally)")
        case .scroll_down:
            return Info(key: "j,down", description: "Scroll the view downwards")
        case .scroll_up:
            return Info(key: "k, up", description: "Scroll the view upwards")
        case .page_down:
            return Info(key: "Ctrl-f, PageDown", description: "Move page down")
        case .page_up:
            return Info(key: "Ctrl-b, PageUp", description: "Move page up")
        case .half_page_down:
            return Info(key: "Ctrl-d", description: "Move half-page down")
        case .half_page_up:
            return Info(key: "Ctrl-u", description: "Move half-page up")
        }
    }
}
/**View mode
 
 Accessed by typing z in normal mode.

 View mode is intended for scrolling and manipulating the view without changing the selection. The "sticky" variant of this mode (accessed by typing Z in normal mode) is persistent and can be exited using the escape key. This is useful when you're simply looking over text and not actively editing it.

 Key    Description    Command
 z, c    Vertically center the line    align_view_center
 t    Align the line to the top of the screen    align_view_top
 b    Align the line to the bottom of the screen    align_view_bottom
 m    Align the line to the middle of the screen (horizontally)    align_view_middle
 j, down    Scroll the view downwards    scroll_down
 k, up    Scroll the view upwards    scroll_up
 Ctrl-f, PageDown    Move page down    page_down
 Ctrl-b, PageUp    Move page up    page_up
 Ctrl-d    Move half page down    half_page_down
 Ctrl-u    Move half page up    half_page_up

 */
