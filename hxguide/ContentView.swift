//
//  ContentView.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import SwiftUI

// MARK: - Destinations

/// Every browsable screen in the guide. Drives both the sidebar and the detail pane,
/// so adding a topic is a single case plus its `sections`.
enum GuideDestination: String, CaseIterable, Identifiable, Hashable {

    // Editor modes
    case normal
    case insert
    case selectOrExtend
    case picker
    case prompt

    // Normal-mode categories
    case movement
    case changes
    case selectionManipulation
    case search
    case shell

    // Minor modes
    case minorModeEntry
    case view
    case goto
    case match
    case window
    case space
    case unimpaired
    case popup

    // Reference
    case commands
    case staticCommands
    case configuration
    case credits

    var id: String { rawValue }

    var title: String {
        switch self {
        case .normal: return "Normal"
        case .insert: return "Insert"
        case .selectOrExtend: return "Select / Extend"
        case .picker: return "Picker"
        case .prompt: return "Prompt"
        case .movement: return "Movement"
        case .changes: return "Changes"
        case .selectionManipulation: return "Selection"
        case .search: return "Search"
        case .shell: return "Shell"
        case .minorModeEntry: return "Entering Minor Modes"
        case .view: return "View"
        case .goto: return "Goto"
        case .match: return "Match"
        case .window: return "Window"
        case .space: return "Space"
        case .unimpaired: return "Unimpaired"
        case .popup: return "Popup"
        case .commands: return "Commands"
        case .staticCommands: return "Static Commands"
        case .configuration: return "Configuration"
        case .credits: return "About"
        }
    }

    var symbol: String {
        switch self {
        case .normal: return "n.square"
        case .insert: return "i.square"
        case .selectOrExtend: return "s.square"
        case .picker: return "list.bullet.rectangle"
        case .prompt: return "chevron.left.forwardslash.chevron.right"
        case .movement: return "arrow.up.and.down.and.arrow.left.and.right"
        case .changes: return "pencil"
        case .selectionManipulation: return "selection.pin.in.out"
        case .search: return "magnifyingglass"
        case .shell: return "terminal"
        case .minorModeEntry: return "arrow.turn.down.right"
        case .view: return "eye"
        case .goto: return "arrow.right.to.line"
        case .match: return "curlybraces"
        case .window: return "rectangle.split.2x1"
        case .space: return "space"
        case .unimpaired: return "arrow.up.arrow.down.square"
        case .popup: return "info.bubble"
        case .commands: return "command"
        case .staticCommands: return "keyboard"
        case .configuration: return "gearshape"
        case .credits: return "heart"
        }
    }

    /// Explanatory prose shown above the key list, where the mode needs it.
    var prose: String? {
        switch self {
        case .selectOrExtend:
            return Helix.SelectOrExtendText
        case .normal:
            return "Normal mode is the default. Keys move the cursor, manipulate selections and enter the other modes."
        case .goto:
            return "Accessed by typing g in normal mode. Jumps to various locations."
        case .match:
            return "Accessed by typing m in normal mode. Operates on brackets, surrounds and textobjects."
        case .window:
            return "Accessed by typing Ctrl-w in normal mode. Similar to Vim's window bindings."
        case .space:
            return "Accessed by typing Space in normal mode. Mostly pickers and clipboard commands."
        case .view:
            return "Accessed by typing z in normal mode (Z for the sticky variant). Scrolls the view without moving the selection."
        case .unimpaired:
            return "Bracket-prefixed motions in the style of vim-unimpaired."
        case .popup:
            return "Keys for the documentation popup, the completion menu and the signature-help popup. Remapping is not currently supported."
        case .picker:
            return "Keys used within the picker. Remapping is not currently supported."
        case .prompt:
            return "Keys used within the prompt. Remapping is not currently supported."
        case .commands:
            return "Command mode is activated by pressing :. These are the built-in commands."
        case .staticCommands:
            return "Static commands are the commands that can be bound to a key in config.toml, as opposed to the typable `:` commands above. Every default keybind in this guide ultimately maps to one of these."
        case .insert:
            return "Insert mode bindings are minimal by default. Changes are committed for undo when returning to normal mode."
        default:
            return nil
        }
    }

    /// The key/command rows for this screen, grouped into titled sections.
    var sections: [GuideSectionContent] {
        switch self {
        case .normal:
            return [
                GuideSectionContent(title: "Movement", entries: MovementCommands.entries),
                GuideSectionContent(title: "Changes", entries: ChangeCommands.entries),
                GuideSectionContent(title: "Selection", entries: SelectionManipulationCommands.entries),
                GuideSectionContent(title: "Search", entries: SearchCommands.entries),
                GuideSectionContent(title: "Shell", entries: ShellCommands.entries),
                GuideSectionContent(title: "Minor Modes", entries: MinorModes.entries)
            ]
        case .insert:
            return [GuideSectionContent(title: "Insert", entries: InsertCommands.entries)]
        case .selectOrExtend:
            return []
        case .picker:
            return [GuideSectionContent(title: "Picker", entries: PickerCommands.entries)]
        case .prompt:
            return [GuideSectionContent(title: "Prompt", entries: PromptCommands.entries)]
        case .movement:
            return [GuideSectionContent(title: "Movement", entries: MovementCommands.entries)]
        case .changes:
            return [GuideSectionContent(title: "Changes", entries: ChangeCommands.entries)]
        case .selectionManipulation:
            return [GuideSectionContent(title: "Selection", entries: SelectionManipulationCommands.entries)]
        case .search:
            return [GuideSectionContent(title: "Search", entries: SearchCommands.entries)]
        case .shell:
            return [GuideSectionContent(title: "Shell", entries: ShellCommands.entries)]
        case .minorModeEntry:
            return [GuideSectionContent(title: "Minor Modes", entries: MinorModes.entries)]
        case .view:
            return [GuideSectionContent(title: "View", entries: ViewCommands.entries)]
        case .goto:
            return [GuideSectionContent(title: "Goto", entries: GotoCommands.entries)]
        case .match:
            return [GuideSectionContent(title: "Match", entries: MatchCommands.entries)]
        case .window:
            return [GuideSectionContent(title: "Window", entries: WindowCommands.entries)]
        case .space:
            return [GuideSectionContent(title: "Space", entries: SpaceCommands.entries)]
        case .unimpaired:
            return [GuideSectionContent(title: "Unimpaired", entries: UnimpairedCommands.entries)]
        case .popup:
            return [
                GuideSectionContent(title: "Popup", entries: PopupCommands.entries),
                GuideSectionContent(title: "Completion Menu", entries: CompletionMenuCommands.entries),
                GuideSectionContent(title: "Signature-help Popup", entries: SignatureHelpCommands.entries)
            ]
        case .commands:
            return [GuideSectionContent(title: "Commands", entries: Helix.Commands.entries)]
        case .staticCommands:
            return [GuideSectionContent(title: "Static Commands", entries: Helix.StaticCommands.entries)]
        case .configuration, .credits:
            return []
        }
    }

    static let editorModes: [GuideDestination] = [.normal, .insert, .selectOrExtend, .picker, .prompt]
    static let normalCategories: [GuideDestination] = [.movement, .changes, .selectionManipulation, .search, .shell]
    static let minorModes: [GuideDestination] = [.minorModeEntry, .view, .goto, .match, .window, .space, .unimpaired, .popup]
    static let reference: [GuideDestination] = [.commands, .staticCommands, .configuration, .credits]
}

/// A titled group of rows within a screen.
struct GuideSectionContent: Identifiable {
    let title: String
    let entries: [GuideEntry]

    var id: String { title }

    /// Section with only the rows matching `query`; `nil` when nothing matches.
    func filtered(by query: String) -> GuideSectionContent? {
        let matched = entries.filter { $0.matches(query) }
        return matched.isEmpty ? nil : GuideSectionContent(title: title, entries: matched)
    }
}

// MARK: - Rows

/// One keystroke and what it does. The key is monospaced on a subtle rounded
/// background so the key column stays scannable — the whole point of a shortcut reference.
struct GuideRow: View {
    let entry: GuideEntry

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 12) {
            Text(entry.key)
                .font(.system(.body, design: .monospaced))
                .foregroundColor(.primary)
                .padding(.horizontal, 6)
                .padding(.vertical, 3)
                .background(
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .fill(Color.secondary.opacity(0.15))
                )
                .frame(minWidth: 90, alignment: .leading)
                .accessibilityLabel(Text("Key \(entry.key)"))

            VStack(alignment: .leading, spacing: 2) {
                Text(entry.detail)
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)

                if let command = entry.commandName {
                    Text(command)
                        .font(.system(.caption, design: .monospaced))
                        .foregroundColor(.secondary)
                }
            }

            Spacer(minLength: 0)
        }
        .padding(.vertical, 2)
    }
}

// MARK: - Detail

/// The single list view every destination renders through. Replaces the seven
/// near-identical mode views (and their seven separate text fields).
struct GuideDetailView: View {
    let destination: GuideDestination
    let searchText: String

    private var visibleSections: [GuideSectionContent] {
        destination.sections.compactMap { $0.filtered(by: searchText) }
    }

    private var hasRows: Bool {
        !destination.sections.flatMap(\.entries).isEmpty
    }

    var body: some View {
        List {
            if let prose = destination.prose {
                Section {
                    Text(prose)
                        .foregroundColor(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.vertical, 4)
                }
            }

            switch destination {
            case .configuration:
                configurationSection
            case .credits:
                creditsSection
            default:
                if hasRows && visibleSections.isEmpty {
                    Section {
                        Text("No matches for “\(searchText)”")
                            .foregroundColor(.secondary)
                    }
                }

                ForEach(visibleSections) { section in
                    Section(section.title) {
                        ForEach(section.entries) { entry in
                            GuideRow(entry: entry)
                        }
                    }
                }
            }
        }
        .navigationTitle(destination.title)
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }

    private var configurationSection: some View {
        Section("Configuration File Locations") {
            ForEach(Helix.ConfigFileLocations.allCases, id: \.self) { location in
                GuideRow(entry: GuideEntry(id: "na_config_\(location.rawValue)",
                                           key: location.description(),
                                           detail: location.displayName))
            }
        }
    }

    private var creditsSection: some View {
        Section("Made with ❤️ by Jimmy Hough Jr using") {
            Link("🧬 Helix Website", destination: URL(string: "https://helix-editor.com")!)
            Link("🦀 Rust Website", destination: URL(string: "https://rust-lang.org")!)
            Link("🕊️ Swift Website", destination: URL(string: "https://swift.org")!)
            Text("Keybinding content is drawn from the Helix documentation.")
                .font(.footnote)
                .foregroundColor(.secondary)
            Text("Content verified against Helix \(Helix.verifiedAgainstVersion) on \(Helix.verifiedOn).")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Root

struct ContentView: View {
    @State private var selection: GuideDestination? = .normal
    @State private var searchText = ""
    @State private var columnVisibility: NavigationSplitViewVisibility = .all

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List(selection: $selection) {
                sidebarSection("Editor Modes", GuideDestination.editorModes)
                sidebarSection("Normal Mode", GuideDestination.normalCategories)
                sidebarSection("Minor Modes", GuideDestination.minorModes)
                sidebarSection("Reference", GuideDestination.reference)
            }
            .listStyle(.sidebar)
            .navigationTitle("Helix Guide")
            #if os(macOS)
            .frame(minWidth: 200)
            #endif
        } detail: {
            if let selection {
                GuideDetailView(destination: selection, searchText: searchText)
                    .searchable(text: $searchText, prompt: "Search keys and descriptions")
                    #if os(macOS)
                    .frame(minWidth: 420)
                    #endif
            } else {
                Text("Select a topic")
                    .foregroundColor(.secondary)
            }
        }
        .navigationSplitViewStyle(.balanced)
    }

    private func sidebarSection(_ title: String, _ destinations: [GuideDestination]) -> some View {
        Section(title) {
            ForEach(destinations) { destination in
                Label(destination.title, systemImage: destination.symbol)
                    .tag(destination)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
