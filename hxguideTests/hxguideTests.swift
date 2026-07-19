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
            ("Commands", Helix.Commands.entries)
        ]
    }

    // MARK: - Coverage

    func testEveryTableIsNonEmpty() {
        for table in allTables {
            XCTAssertFalse(table.entries.isEmpty, "\(table.name) has no entries")
        }
    }

    /// Minimum counts, so a future refactor that silently drops rows fails loudly.
    func testTablesMeetMinimumCounts() {
        let minimums: [String: Int] = [
            "Movement": 25,
            "Changes": 31,
            "Selection": 30,
            "Search": 5,
            "Shell": 5,
            "MinorModes": 8,
            "Insert": 19,
            "Picker": 11,
            "Prompt": 20,
            "View": 10,
            "Goto": 18,
            "Match": 6,
            "Window": 15,
            "Space": 22,
            "Unimpaired": 22,
            "Popup": 2,
            "Commands": 77
        ]

        for table in allTables {
            let expected = minimums[table.name] ?? 1
            XCTAssertGreaterThanOrEqual(table.entries.count, expected,
                                        "\(table.name) has \(table.entries.count) entries, expected at least \(expected)")
        }
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
