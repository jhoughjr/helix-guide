//
//  ContentView.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("", text: $searchText)
        }
    }
}

struct CommandInfoView: View {
    /// Comes from info on enum variant
    let info:Helix.CommandInfo
    let command:String
    var body: some View {
        HStack {
            Text(info.invocation)
                .foregroundColor(.green)
            Text(info.description)
                .foregroundColor(.white)
        }
    }
}

struct KeyInfoView: View {
    /// Comes from info on enum variant
    let info:Helix.KeyInfo
    let command:String
    var body: some View {
        HStack {
            Text(info.key)
                .foregroundColor(.green)
            Text(info.description)
                .foregroundColor(.white)
        }
    }
}

struct NormalModeView:View {
    @State var filterText = ""
    
    var body: some View {
        TextField("", text: $filterText)
        
        List {
            ForEach(Helix.NormalMode.allCases, id:\.self) { m in
                
                VStack(alignment:.leading) {
                    Text(m.rawValue)
                        .font(.title2)
                        .fontWeight(.bold)
                    Divider()
                    if m == .minorModes {
                        ForEach(MinorModes.allCases
                            .filter({ com in
                                filterText.isEmpty ? true : com.info.description.contains(filterText)
                            }), id:\.self) { com in
                                KeyInfoView(info: com.info, command: com.rawValue)
                            }
                    }
                    if m == .movement {
                            ForEach(MovementCommands.allCases
                                .filter({ com in
                                    filterText.isEmpty ? true : com.info.description.contains(filterText)
                                }), id:\.self) { com in
                                    KeyInfoView(info: com.info, command: com.rawValue)
                                }

                    }
                    if m == .changes {
                        ForEach(ChangeCommands.allCases
                            .filter({ com in
                                filterText.isEmpty ? true : com.info.description.contains(filterText)
                            }), id:\.self) { com in
                            KeyInfoView(info: com.info, command: com.rawValue)
                        }
                    }
                    if m == .search {
                        ForEach(SearchCommands.allCases
                            .filter({ com in
                                filterText.isEmpty ? true : com.info.description.contains(filterText)
                            }), id:\.self) { com in
                            KeyInfoView(info: com.info, command: com.rawValue)
                        }
                    }
                    if m == .selectionManipulation {
                        ForEach(SelectionManipulationCommands.allCases
                            .filter({ com in
                                filterText.isEmpty ? true : com.info.description.contains(filterText)
                            }), id:\.self) { com in
                            KeyInfoView(info: com.info, command: com.rawValue)
                        }
                    }
                    if m == .shell {
                        ForEach(ShellCommands.allCases
                            .filter({ com in
                                filterText.isEmpty ? true : com.info.description.contains(filterText)
                            }), id:\.self) { com in
                            KeyInfoView(info: com.info, command: com.rawValue)
                        }
                    }
                }
            }
        }
    }
}

struct InsertModeView:View {
    @State var filterText = ""
    
    var body: some View {
        TextField("", text: $filterText)
        List {
            ForEach(InsertCommands.allCases
                .filter({ com in
                    filterText.isEmpty ? true : com.info.description.contains(filterText)
                }), id:\.self) { com in
                KeyInfoView(info: com.info, command: com.rawValue)
            }
        }
    }
}

struct PickerModeView:View {
    @State var filterText = ""
    
    var body: some View {
        TextField("", text: $filterText)
        List {
            ForEach(PickerCommands.allCases
                .filter({ com in
                    filterText.isEmpty ? true : com.info.description.contains(filterText)
                }), id:\.self) { com in
                KeyInfoView(info: com.info, command: com.rawValue)
            }
        }
    }
}

struct PromptModeView: View {
    @State var filterText = ""
    
    var body: some View {
        TextField("", text: $filterText)
        List {
            ForEach(PromptCommands.allCases
                .filter({ com in
                    filterText.isEmpty ? true : com.info.description.contains(filterText)
                }), id:\.self) { com in
                KeyInfoView(info: com.info, command: com.rawValue)
            }
        }
    }
}

struct SelectOrExtendModeView:View {
    var body: some View {
        List {
            Text(Helix.SelectOrExtendText)
        }
    }
}


struct ModeView:View {
    
    var mode:Helix.EditorModes
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(mode.rawValue)
                .font(.title)
                .contentShape(Rectangle())
            
                switch mode {
                case .normal:
                   NormalModeView()
                case .insert:
                   InsertModeView()
                case .picker:
                   PickerModeView()
                case .prompt:
                    PromptModeView()
                case .selectOrExtend:
                   SelectOrExtendModeView()
                }
        }
    }
}

struct ModesView:View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Editor Modes")
                .font(.largeTitle)
            HStack(alignment:.top) {
                ForEach(Helix.EditorModes.allCases, id:\.self) { mode in
                    ModeView(mode: mode)
                }
            }
        }
    }
}

struct CommandsView:View {
    @State var filterText = ""
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Editor Commands")
                .font(.largeTitle)
            Text("command").font(.title)
            TextField("", text: $filterText)
            List {
                ForEach(Helix.Commands.allCases
                    .filter({ com in
                        filterText.isEmpty ? true : com.info.description.contains(filterText)
                    }),
                        id:\.rawValue) { com in
                    CommandInfoView(info: com.info,
                                    command: com.rawValue)
                }
            }
        }
    }
}

struct ConfigFileView:View {
    @State var hovered:Bool = false
    
    var body: some View {
    
            Text("Configuration File")
            .foregroundColor(.accentColor)
            .onTapGesture {
                hovered.toggle()
            }
            .font(.largeTitle)
            .popover(isPresented: $hovered) {
                List {

                Text("File Locations")
                        .font(.largeTitle)
                Text("Windows")
                        .fontWeight(.bold)
                Text(Helix.ConfigFileLocations.windows.description())
                        .foregroundColor(.green)
                Text("Mac")
                        .fontWeight(.bold)
                Text(Helix.ConfigFileLocations.macOS.description())
                        .foregroundColor(.green)
                Text("Linux")
                        .fontWeight(.bold)
                Text(Helix.ConfigFileLocations.linux.description())
                        .foregroundColor(.green)
                
            }
        }
    }
}

struct ContentView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                ModesView()
                CommandsView()
            }
            HStack {
                ConfigFileView()
                Text("Made with ❤️ by Jimmy Hough Jr using: ")
                Link("🧬 Helix Website", destination: URL(string: "https://helix-editor.com")!)
                Link("🦀 Rust Website", destination: URL(string: "https://rust-lang.org")!)
                Link("🕊️ Swift Website", destination: URL(string: "https://swift.org")!)
            }
        }
        
    }
}

