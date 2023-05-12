//
//  Goto.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation
/** Goto mode
 
 Accessed by typing g in normal mode.

 Jumps to various locations.

 Key    Description    Command
 g    Go to line number <n> else start of file    goto_file_start
 e    Go to the end of the file    goto_last_line
 f    Go to files in the selection    goto_file
 h    Go to the start of the line    goto_line_start
 l    Go to the end of the line    goto_line_end
 s    Go to first non-whitespace character of the line    goto_first_nonwhitespace
 t    Go to the top of the screen    goto_window_top
 c    Go to the middle of the screen    goto_window_center
 b    Go to the bottom of the screen    goto_window_bottom
 d    Go to definition (LSP)    goto_definition
 y    Go to type definition (LSP)    goto_type_definition
 r    Go to references (LSP)    goto_reference
 i    Go to implementation (LSP)    goto_implementation
 a    Go to the last accessed/alternate file    goto_last_accessed_file
 m    Go to the last modified/alternate file    goto_last_modified_file
 n    Go to next buffer    goto_next_buffer
 p    Go to previous buffer    goto_previous_buffer
 .    Go to last modification in current file    goto_last_modification

 */
