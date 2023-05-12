//
//  helix.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import Foundation

struct Helix {
    static let SelectOrExtendText = """
 Select mode echoes Normal mode, but changes any movements to extend selections rather than replace them. Goto motions are also changed to extend, so that vgl for example extends the selection to the end of the line.

 Search is also affected. By default, n and N will remove the current selection and select the next instance of the search term. Toggling this mode before pressing n or N makes it possible to keep the current selection. Toggling it on and off during your iterative searching allows you to selectively add search terms to your selections.
"""
    
    struct KeyInfo:Codable {
        let key:String
        let description:String
    }
    
    struct CommandInfo:Codable {
        let invocation:String
        let description:String
    }
    
    enum ConfigFileLocations:String, CaseIterable {
        case windows
        case linux
        case macOS
        
        func description() -> String {
            switch self {
                
            case .windows:
                return "%AppData%\\helix\\config.toml"
            case .linux:
                return "~/.config/helix/config.toml"
            case .macOS:
                return "~/.config/helix/config.toml"
            }
        }
    }

    enum EditorModes:String, CaseIterable {
        case normal
        case insert
        case selectOrExtend
        case picker
        case prompt
        
    }
    
    enum NormalMode:String, CaseIterable {
        case movement
        case changes
        case selectionManipulation
        case search
        case shell
        case minorModes
        
        func moveCommands() -> [MovementCommands] {
            MovementCommands.allCases
        }
        
        func changeCommands() -> [ChangeCommands] {
            ChangeCommands.allCases
        }
        
        func selectionCommands() -> [SelectionManipulationCommands] {
            SelectionManipulationCommands.allCases
        }
        
        func searchCommands() -> [SearchCommands] {
            SearchCommands.allCases
        }
        
        func shellCommands() -> [ShellCommands] {
            ShellCommands.allCases
        }
    }
    
    enum MinorModes:CaseIterable {
        case view
        case goto
        case match
        case window
        case space
        case unimpaired
        
        func viewCommands() {
            
        }
        func gotoCommands() {
            
        }
        func matchCommands() {
            
        }
        func windowCommands() {
            
        }
        func spaceCommands() {
            
        }
        func unimpairedCommands() {
            
        }
    }
    
}


