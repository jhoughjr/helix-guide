//
//  Picker.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

enum PickerCommands:String, CaseIterable {
    case na_previous_entry
    case na_next_entry
    case na_pageup
    case na_pagedown
    case na_gotoFirst
    case na_gotoLast
    case na_openSelected
    case na_open_horizontal
    case na_open_vertical
    case na_toggle_preview
    case na_close_picker
    
    var info:Helix.KeyInfo {
        switch self {
            
        case .na_previous_entry:
            return Info(key: "Shift-Tab, Up, Ctrl-p", description: "Previous entry")
        case .na_next_entry:
            return Info(key: "Tab, Down, Ctrl-n  ", description: "Next entry")
        case .na_pageup:
            return Info(key: "PageUp, Ctrl-u ", description: "Page up")
        case .na_pagedown:
            return Info(key: "PageDown, Ctrl-d ", description: "Page down")
        case .na_gotoFirst:
            return Info(key: "HOME", description: "Goto first entry")
        case .na_gotoLast:
            return Info(key: "END", description: "Goto last entry")
        case .na_openSelected:
            return Info(key: "ENTER", description: "Open selected")
        case .na_open_horizontal:
            return Info(key: "ctl-s", description: "Open horizontally")
        case .na_open_vertical:
            return Info(key: "ctl-v", description: "Open vertically")
        case .na_toggle_preview:
            return Info(key: "ctl-t", description: "Toggle preview")
        case .na_close_picker:
            return Info(key: " Escape, Ctrl-c  ", description: "Close picker")
        }
    }
}
/** Picker
 
 Keys to use within picker. Remapping currently not supported.

 Key    Description
 Shift-Tab, Up, Ctrl-p    Previous entry
 Tab, Down, Ctrl-n    Next entry
 PageUp, Ctrl-u    Page up
 PageDown, Ctrl-d    Page down
 Home    Go to first entry
 End    Go to last entry
 Enter    Open selected
 Ctrl-s    Open horizontally
 Ctrl-v    Open vertically
 Ctrl-t    Toggle preview
 Escape, Ctrl-c    Close picker

 */
