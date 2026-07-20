//
//  hxguideTests.swift
//  hxguideTests
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import XCTest
@testable import hxguide

/// Data-integrity tests over the guide content, plus the filter logic.
/// All pure logic — no UI, no app launch required.
final class hxguideTests: XCTestCase {

    // MARK: - Helpers

    /// Every key-binding table in the app, by display name.
    private var allTables: [(name: String, entries: [GuideEntry])] {
        [
            ("Movement", MovementCommands.entries),
            ("Changes", ChangeCommands.entries),
            ("Selection", SelectionManipulationCommands.entries),
            ("Search", SearchCommands.entries),
            ("Shell", ShellCommands.entries),
            ("MinorModes", MinorModes.entries),
            ("Insert", InsertCommands.entries),
            ("Picker", PickerCommands.entries),
            ("Prompt", PromptCommands.entries),
            ("View", ViewCommands.entries),
            ("Goto", GotoCommands.entries),
            ("Match", MatchCommands.entries),
            ("Window", WindowCommands.entries),
            ("Space", SpaceCommands.entries),
            ("Unimpaired", UnimpairedCommands.entries),
            ("Popup", PopupCommands.entries),
            ("CompletionMenu", CompletionMenuCommands.entries),
            ("SignatureHelp", SignatureHelpCommands.entries),
            ("Commands", Helix.Commands.entries)
        ]
    }

    /// Row counts as reconciled against the Helix release named by
    /// `Helix.verifiedAgainstVersion`. These are exact, not minimums: a table that
    /// gains or loses a row should force a deliberate re-diff against upstream docs
    /// rather than drifting silently.
    private var expectedCounts: [String: Int] {
        [
            "Movement": 25,
            "Changes": 31,
            "Selection": 35,
            "Search": 6,
            "Shell": 5,
            "MinorModes": 8,
            "Insert": 19,
            "Picker": 12,
            "Prompt": 20,
            "View": 10,
            "Goto": 22,
            "Match": 6,
            "Window": 15,
            "Space": 26,
            "Unimpaired": 22,
            "Popup": 2,
            "CompletionMenu": 4,
            "SignatureHelp": 2,
            "Commands": 89
        ]
    }

    // MARK: - Coverage

    func testEveryTableIsNonEmpty() {
        for table in allTables {
            XCTAssertFalse(table.entries.isEmpty, "\(table.name) has no entries")
        }
    }

    /// Exact counts, so a refactor that drops rows — or an upstream sync that adds
    /// them without updating this file — fails loudly.
    func testTablesHaveExpectedCounts() {
        for table in allTables {
            guard let expected = expectedCounts[table.name] else {
                XCTFail("\(table.name) has no expected count recorded")
                continue
            }
            XCTAssertEqual(table.entries.count, expected,
                           "\(table.name) has \(table.entries.count) entries, expected \(expected)")
        }
    }

    /// Every table in `allTables` must have an expectation, and vice versa, so a new
    /// table cannot be added without also being counted.
    func testEveryTableHasARecordedCount() {
        XCTAssertEqual(Set(allTables.map(\.name)), Set(expectedCounts.keys))
    }

    func testTotalRowCount() {
        let total = allTables.reduce(0) { $0 + $1.entries.count }
        XCTAssertEqual(total, 359, "guide should render 359 rows in total")
    }

    // MARK: - Data hygiene

    func testNoEmptyKeysOrDescriptions() {
        for table in allTables {
            for entry in table.entries {
                XCTAssertFalse(entry.key.isEmpty, "\(table.name).\(entry.id) has an empty key")
                XCTAssertFalse(entry.detail.isEmpty, "\(table.name).\(entry.id) has an empty description")
            }
        }
    }

    func testNoLeadingOrTrailingWhitespace() {
        for table in allTables {
            for entry in table.entries {
                XCTAssertEqual(entry.key, entry.key.trimmingCharacters(in: .whitespacesAndNewlines),
                               "\(table.name).\(entry.id) key has stray whitespace: '\(entry.key)'")
                XCTAssertEqual(entry.detail, entry.detail.trimmingCharacters(in: .whitespacesAndNewlines),
                               "\(table.name).\(entry.id) description has stray whitespace: '\(entry.detail)'")
            }
        }
    }

    /// Two rows in the same mode sharing a key would be a genuine binding conflict.
    func testNoDuplicateKeysWithinAMode() {
        for table in allTables {
            var seen: [String: String] = [:]
            for entry in table.entries {
                if let previous = seen[entry.key] {
                    XCTFail("\(table.name) binds '\(entry.key)' twice: \(previous) and \(entry.id)")
                }
                seen[entry.key] = entry.id
            }
        }
    }

    func testCommandIdentifiersAreUniqueWithinAMode() {
        for table in allTables {
            let ids = table.entries.map(\.id)
            XCTAssertEqual(Set(ids).count, ids.count, "\(table.name) has duplicate case identifiers")
        }
    }

    /// Regression guard for the bug where search reported "." instead of "/".
    func testSearchUsesForwardSlash() {
        XCTAssertEqual(SearchCommands.search.info.key, "/")
        XCTAssertEqual(SearchCommands.rsearch.info.key, "?")
    }

    func testWordMotionKeysAreCorrect() {
        XCTAssertEqual(MovementCommands.move_prev_long_word_start.info.key, "B")
        XCTAssertEqual(MovementCommands.move_next_long_word_end.info.key, "E")
    }

    // MARK: - Currency against the verified Helix release

    func testVerifiedVersionIsRecorded() {
        XCTAssertFalse(Helix.verifiedAgainstVersion.isEmpty)
        XCTAssertFalse(Helix.verifiedOn.isEmpty)
    }

    /// Bindings added to goto mode after the guide's original 2023 content.
    /// A regression that drops them should fail rather than quietly teach a stale keymap.
    func testGotoModeHasCurrentBindings() {
        let byKey = Dictionary(uniqueKeysWithValues: GotoCommands.entries.map { ($0.key, $0) })

        XCTAssertEqual(byKey["|"]?.id, "goto_column")
        XCTAssertEqual(byKey["j"]?.id, "move_line_down")
        XCTAssertEqual(byKey["k"]?.id, "move_line_up")
        XCTAssertEqual(byKey["w"]?.id, "goto_word")
    }

    /// `*` searches with word boundaries; the unwrapped variant moved to `Alt-*`.
    func testSearchSelectionBindings() {
        XCTAssertEqual(SearchCommands.search_selection_detect_word_boundaries.info.key, "*")
        XCTAssertEqual(SearchCommands.search_selection.info.key, "Alt-*")
    }

    /// Space `g` is the changed-file picker; the debug layer is on `G`.
    func testSpaceModeChangedFilePickerAndDebugKeys() {
        XCTAssertEqual(SpaceCommands.changed_file_picker.info.key, "g")
        XCTAssertEqual(SpaceCommands.na_debug.info.key, "G")
    }

    /// The comment-toggle trio added to space mode.
    func testSpaceModeCommentBindings() {
        XCTAssertEqual(SpaceCommands.toggle_comments.info.key, "c")
        XCTAssertEqual(SpaceCommands.toggle_block_comments.info.key, "C")
        XCTAssertEqual(SpaceCommands.toggle_line_comments.info.key, "Alt-c")
    }

    /// Half-page motions move the cursor as well as the view, and are named
    /// `page_cursor_half_*` upstream — not the old `half_page_*`.
    func testHalfPageCommandsUseCurrentNames() {
        XCTAssertEqual(MovementCommands.page_cursor_half_up.info.key, "Ctrl-u")
        XCTAssertEqual(MovementCommands.page_cursor_half_down.info.key, "Ctrl-d")
        XCTAssertEqual(ViewCommands.page_cursor_half_up.info.key, "Ctrl-u")
    }

    /// `:rsort` was removed upstream; sorting in reverse is a flag on `:sort`.
    func testRemovedTypableCommandsAreAbsent() {
        let invocations = Helix.Commands.entries.map(\.key).joined(separator: " ")
        XCTAssertFalse(invocations.contains(":rsort"), ":rsort no longer exists in Helix")
    }

    /// Typable commands added since the guide's original content.
    func testCurrentTypableCommandsArePresent() {
        let ids = Set(Helix.Commands.entries.map(\.id))
        for command in ["write_buffer_close", "force_write_all", "yank_join",
                        "tree_sitter_highlight_name", "clear_register", "redraw",
                        "move", "yank_diagnostic", "read", "echo", "noop"] {
            XCTAssertTrue(ids.contains(command), ":\(command) is missing from the command list")
        }
    }

    // MARK: - Filtering

    func testMatchesFindsKeys() {
        let entry = GuideEntry(id: "goto_file_start", key: "gg", detail: "Go to start of file")
        XCTAssertTrue(entry.matches("gg"), "should match on key")
    }

    func testMatchesFindsDescriptions() {
        let entry = GuideEntry(id: "goto_file_start", key: "gg", detail: "Go to start of file")
        XCTAssertTrue(entry.matches("start of file"), "should match on description")
    }

    func testMatchesIsCaseInsensitive() {
        let entry = GuideEntry(id: "na_window", key: "Ctrl-w", detail: "Enter window mode")
        XCTAssertTrue(entry.matches("ctrl-w"))
        XCTAssertTrue(entry.matches("CTRL-W"))
        XCTAssertTrue(entry.matches("WINDOW"))
    }

    func testMatchesHandlesPunctuationKeys() {
        let piped = ShellCommands.shell_pipe.entryForTesting
        XCTAssertTrue(piped.matches("|"), "searching '|' should find the pipe binding")
    }

    func testEmptyQueryMatchesEverything() {
        for table in allTables {
            for entry in table.entries {
                XCTAssertTrue(entry.matches(""), "\(table.name).\(entry.id) should match an empty query")
                XCTAssertTrue(entry.matches("   "), "\(table.name).\(entry.id) should match a whitespace query")
            }
        }
    }

    func testNonMatchingQueryFiltersEverythingOut() {
        let entry = GuideEntry(id: "yank", key: "y", detail: "Yank selection")
        XCTAssertFalse(entry.matches("zzzznotacommand"))
    }

    /// The old filter only checked descriptions; searching a key returned nothing.
    func testKeySearchFindsRowsAcrossTheGuide() {
        let gotoMatches = GotoCommands.entries.filter { $0.matches("g") }
        XCTAssertFalse(gotoMatches.isEmpty, "searching a key should return goto-mode rows")
    }

    // MARK: - Config

    func testConfigFileLocationsAreNonEmptyForAllPlatforms() {
        XCTAssertEqual(Helix.ConfigFileLocations.allCases.count, 3)
        for location in Helix.ConfigFileLocations.allCases {
            XCTAssertFalse(location.description().isEmpty, "\(location.rawValue) has no config path")
            XCTAssertFalse(location.displayName.isEmpty, "\(location.rawValue) has no display name")
        }
    }

    // MARK: - Navigation model

    func testEveryCommandDestinationRendersRows() {
        let proseOnly: Set<GuideDestination> = [.selectOrExtend, .configuration, .credits]
        for destination in GuideDestination.allCases where !proseOnly.contains(destination) {
            let rows = destination.sections.flatMap(\.entries)
            XCTAssertFalse(rows.isEmpty, "\(destination.title) renders no rows")
        }
    }

    func testSidebarCoversEveryDestination() {
        let listed = Set(GuideDestination.editorModes
            + GuideDestination.normalCategories
            + GuideDestination.minorModes
            + GuideDestination.reference)
        for destination in GuideDestination.allCases {
            XCTAssertTrue(listed.contains(destination), "\(destination.title) is unreachable from the sidebar")
        }
    }

    func testProseOnlyDestinationsStillShowText() {
        XCTAssertNotNil(GuideDestination.selectOrExtend.prose)
        XCTAssertFalse(Helix.SelectOrExtendText.isEmpty)
    }
}

private extension ShellCommands {
    var entryForTesting: GuideEntry {
        GuideEntry(id: rawValue, key: info.key, detail: info.description)
    }
}
