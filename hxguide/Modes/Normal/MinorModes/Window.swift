//
//  Window.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation
/**
 Window mode

 Accessed by typing Ctrl-w in normal mode.

 This layer is similar to Vim keybindings as Kakoune does not support windows.

 Key    Description    Command
 w, Ctrl-w    Switch to next window    rotate_view
 v, Ctrl-v    Vertical right split    vsplit
 s, Ctrl-s    Horizontal bottom split    hsplit
 f    Go to files in the selection in horizontal splits    goto_file
 F    Go to files in the selection in vertical splits    goto_file
 h, Ctrl-h, Left    Move to left split    jump_view_left
 j, Ctrl-j, Down    Move to split below    jump_view_down
 k, Ctrl-k, Up    Move to split above    jump_view_up
 l, Ctrl-l, Right    Move to right split    jump_view_right
 q, Ctrl-q    Close current window    wclose
 o, Ctrl-o    Only keep the current window, closing all the others    wonly
 H    Swap window to the left    swap_view_left
 J    Swap window downwards    swap_view_down
 K    Swap window upwards    swap_view_up
 L    Swap window to the right    swap_view_right

 */
