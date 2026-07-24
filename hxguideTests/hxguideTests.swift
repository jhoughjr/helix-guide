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
                           "\(table.name) has \(table.entries.count) entries, expected exactly \(expected) — re-diff against upstream and restate the count deliberately")
        }
    }

    /// Every table in `allTables` must have an expectation, and vice versa, so a new
    /// table cannot be added without also being counted.
    func testEveryTableHasARecordedCount() {
        XCTAssertEqual(Set(allTables.map(\.name)), Set(expectedCounts.keys))
    }

    func testTotalRowCount() {
        let total = allTables.reduce(0) { $0 + $1.entries.count }
        XCTAssertEqual(total, 359, "guide should render exactly 359 rows across the keymap tables")
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

    // MARK: - Global search

    /// A key bound in multiple modes ("gg" style overlap isn't guaranteed, so use
    /// the description word "selection", which appears across many destinations)
    /// should surface hits grouped under more than one destination.
    func testGlobalSearchFindsHitsAcrossMultipleDestinations() {
        let results = GuideDestination.globalSearch("selection")
        XCTAssertGreaterThan(results.count, 1,
                              "expected 'selection' to appear in more than one destination")
        for result in results {
            XCTAssertFalse(result.entries.isEmpty, "\(result.destination.title) result has no entries")
        }
    }

    func testGlobalSearchNonsenseQueryReturnsNothing() {
        let results = GuideDestination.globalSearch("zzzznotarealcommandorword")
        XCTAssertTrue(results.isEmpty)
    }

    /// Matches the per-entry contract: an empty (or whitespace-only) query matches
    /// everything, so global search should return every searchable destination.
    func testGlobalSearchEmptyQueryMatchesEverySearchableDestination() {
        let results = GuideDestination.globalSearch("")
        let searchable = GuideDestination.allCases.filter { !$0.sections.flatMap(\.entries).isEmpty }
        XCTAssertEqual(Set(results.map(\.destination)), Set(searchable))

        let whitespaceResults = GuideDestination.globalSearch("   ")
        XCTAssertEqual(Set(whitespaceResults.map(\.destination)), Set(searchable))
    }

    func testGlobalSearchIsCaseInsensitive() {
        let lower = GuideDestination.globalSearch("window")
        let upper = GuideDestination.globalSearch("WINDOW")
        let mixed = GuideDestination.globalSearch("WiNdOw")
        XCTAssertFalse(lower.isEmpty)
        XCTAssertEqual(Set(lower.map(\.destination)), Set(upper.map(\.destination)))
        XCTAssertEqual(Set(lower.map(\.destination)), Set(mixed.map(\.destination)))
    }

    /// A known command should be findable both by its key and by (a fragment of)
    /// its description, and both searches should agree on the destination it lives in.
    func testGlobalSearchFindsKnownCommandByKeyAndByDescription() {
        let byKey = GuideDestination.globalSearch(WindowCommands.vsplit.info.key)
        let byDescription = GuideDestination.globalSearch("Vertical right split")

        XCTAssertTrue(byKey.contains { $0.destination == .window },
                       "searching '\(WindowCommands.vsplit.info.key)' should surface .window")
        XCTAssertTrue(byDescription.contains { $0.destination == .window },
                       "searching the description should surface .window")
    }

    /// Excluded prose-only destinations should never appear in results, for any query.
    func testGlobalSearchExcludesProseOnlyDestinations() {
        let results = GuideDestination.globalSearch("")
        let destinations = Set(results.map(\.destination))
        XCTAssertFalse(destinations.contains(.configuration))
        XCTAssertFalse(destinations.contains(.credits))
        XCTAssertFalse(destinations.contains(.selectOrExtend))
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

    // MARK: - Static commands

    /// Reconciled against `static-cmd.md` for Helix 25.07.1 (305 data rows).
    /// Exact, not a minimum: this table is a full transcription of a single
    /// upstream file, so a change in count means a deliberate re-sync.
    func testStaticCommandsHasExpectedCount() {
        XCTAssertEqual(Helix.StaticCommands.all.count, 305)
    }

    func testStaticCommandsIsNonEmpty() {
        XCTAssertFalse(Helix.StaticCommands.all.isEmpty)
    }

    func testStaticCommandsHaveNoEmptyOrWhitespaceNamesOrDetails() {
        for command in Helix.StaticCommands.all {
            let trimmedName = command.name.trimmingCharacters(in: .whitespacesAndNewlines)
            let trimmedDetail = command.detail.trimmingCharacters(in: .whitespacesAndNewlines)
            XCTAssertFalse(command.name.isEmpty, "a static command has an empty name")
            XCTAssertFalse(command.detail.isEmpty, "\(command.name) has an empty detail")
            XCTAssertEqual(command.name, trimmedName, "\(command.name) has stray whitespace in its name")
            XCTAssertEqual(command.detail, trimmedDetail, "\(command.name) has stray whitespace in its detail")
        }
    }

    func testStaticCommandsHaveNoDuplicateNames() {
        let names = Helix.StaticCommands.all.map(\.name)
        XCTAssertEqual(Set(names).count, names.count, "static command names should be unique")
    }

    func testStaticCommandsDestinationIsReachableFromSidebar() {
        let listed = Set(GuideDestination.editorModes
            + GuideDestination.normalCategories
            + GuideDestination.minorModes
            + GuideDestination.reference)
        XCTAssertTrue(listed.contains(.staticCommands))
        XCTAssertTrue(GuideDestination.reference.contains(.staticCommands))
    }

    /// Spot checks against rows with tricky escaping in the source markdown:
    /// a backslash-and-backtick fragment in the description, a double-quote
    /// key, and a pipe-character key (written `\|` upstream).
    func testStaticCommandsSpotChecks() {
        let byName = Dictionary(uniqueKeysWithValues: Helix.StaticCommands.all.map { ($0.name, $0) })

        let wordBoundaries = byName["search_selection_detect_word_boundaries"]
        XCTAssertEqual(wordBoundaries?.detail,
                       "Use current selection as the search pattern, automatically wrapping with `\\b` on word boundaries")
        XCTAssertEqual(wordBoundaries?.bindings, "normal: * — select: *")

        let selectRegister = byName["select_register"]
        XCTAssertEqual(selectRegister?.detail, "Select register")
        XCTAssertEqual(selectRegister?.bindings, "normal: \" — select: \"")

        let shellPipe = byName["shell_pipe"]
        XCTAssertEqual(shellPipe?.detail, "Pipe selections through shell command")
        XCTAssertEqual(shellPipe?.bindings, "normal: | — select: |")

        let gotoColumn = byName["goto_column"]
        XCTAssertEqual(gotoColumn?.detail, "Goto column")
        XCTAssertEqual(gotoColumn?.bindings, "normal: g|")

        let noOp = byName["no_op"]
        XCTAssertEqual(noOp?.detail, "Do nothing")
        XCTAssertEqual(noOp?.bindings, "")
    }
}

private extension ShellCommands {
    var entryForTesting: GuideEntry {
        GuideEntry(id: rawValue, key: info.key, detail: info.description)
    }
}
