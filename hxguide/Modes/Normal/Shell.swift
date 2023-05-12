//
//  Shell.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

enum ShellCommands:String, CaseIterable {
    typealias Info = Helix.KeyInfo
    
    case shell_pipe
    case shell_pipe_to
    case shell_insert_output
    case shell_append_output
    case shell_keep_pipe
    
    var info:Info {
        switch self {
            
        case .shell_pipe:
            return Info(key: "|", description: "Pipe each through shell command, replacing with output")
        case .shell_pipe_to:
            return Info(key: "Alt-|", description: "  Pipe each selection into shell command, ignoring output  ")
        case .shell_insert_output:
            return Info(key: "!", description: " Run shell command, inserting output before each selection")
        case .shell_append_output:
            return Info(key: "Alt-!", description: "Run shell command, appending output after each selection")
        case .shell_keep_pipe:
            return Info(key: "$", description: " Pipe each selection into shell command, keep selections where command returned 0  ")
        }
    }
    
}
/**
 Shell

 Key    Description    Command
 |    Pipe each selection through shell command, replacing with output    shell_pipe
 Alt-|    Pipe each selection into shell command, ignoring output    shell_pipe_to
 !    Run shell command, inserting output before each selection    shell_insert_output
 Alt-!    Run shell command, appending output after each selection    shell_append_output
 $    Pipe each selection into shell command, keep selections where command returned 0    shell_keep_pipe

 */
