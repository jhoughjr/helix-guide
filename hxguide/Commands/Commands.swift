//
//  Commands.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/11/23.
//

import Foundation

extension Helix {
    /// Built-in commands, entered from command mode (activated with `:`).
    enum Commands: String, CaseIterable {
        typealias Info = Helix.CommandInfo

        case quit
        case force_quit
        case open
        case buffer_close
        case force_buffer_close
        case buffer_close_others
        case force_buffer_close_others
        case buffer_close_all
        case force_buffer_close_all
        case buffer_next
        case buffer_previous
        case write
        case force_write
        case new
        case format
        case indent_style
        case line_ending
        case earlier
        case later
        case write_quit
        case force_write_quit
        case write_all
        case write_quit_all
        case force_write_quit_all
        case quit_all
        case force_quit_all
        case cquit
        case force_cquit
        case theme
        case clipboard_yank
        case clipboard_yank_join
        case primary_clipboard_yank
        case primary_clipboard_yank_join
        case clipboard_paste_after
        case clipboard_paste_before
        case clipboard_paste_replace
        case primary_clipboard_paste_after
        case primary_clipboard_paste_before
        case primary_clipboard_paste_replace
        case show_clipboard_provider
        case change_current_directory
        case show_directory
        case encoding
        case character_info
        case reload
        case reload_all
        case update
        case lsp_workspace_command
        case lsp_restart
        case lsp_stop
        case tree_sitter_scopes
        case debug_start
        case debug_remote
        case debug_eval
        case vsplit
        case vsplit_new
        case hsplit
        case hsplit_new
        case tutor
        case goto_line
        case set_language
        case set_option
        case toggle_option
        case get_option
        case sort
        case rsort
        case reflow
        case tree_sitter_subtree
        case config_reload
        case config_open
        case config_open_workspace
        case log_open
        case insert_output
        case append_output
        case pipe
        case pipe_to
        case run_shell_command
        case reset_diff_change

        var info: Info {
            switch self {

            case .quit:
                return Info(invocation: ":quit, :q",
                            description: "Close the current view.")
            case .force_quit:
                return Info(invocation: ":quit!, :q!",
                            description: "Force close the current view, ignoring unsaved changes.")
            case .open:
                return Info(invocation: ":open, :o",
                            description: "Open a file from disk into the current view.")
            case .buffer_close:
                return Info(invocation: ":buffer-close, :bc, :bclose",
                            description: "Close the current buffer.")
            case .force_buffer_close:
                return Info(invocation: ":buffer-close!, :bc!, :bclose!",
                            description: "Close the current buffer forcefully, ignoring unsaved changes.")
            case .buffer_close_others:
                return Info(invocation: ":buffer-close-others, :bco, :bcloseother",
                            description: "Close all buffers but the currently focused one.")
            case .force_buffer_close_others:
                return Info(invocation: ":buffer-close-others!, :bco!, :bcloseother!",
                            description: "Force close all buffers but the currently focused one.")
            case .buffer_close_all:
                return Info(invocation: ":buffer-close-all, :bca, :bcloseall",
                            description: "Close all buffers without quitting.")
            case .force_buffer_close_all:
                return Info(invocation: ":buffer-close-all!, :bca!, :bcloseall!",
                            description: "Force close all buffers ignoring unsaved changes without quitting.")
            case .buffer_next:
                return Info(invocation: ":buffer-next, :bn, :bnext",
                            description: "Goto next buffer.")
            case .buffer_previous:
                return Info(invocation: ":buffer-previous, :bp, :bprev",
                            description: "Goto previous buffer.")
            case .write:
                return Info(invocation: ":write, :w",
                            description: "Write changes to disk. Accepts an optional path (:write some/path.txt)")
            case .force_write:
                return Info(invocation: ":write!, :w!",
                            description: "Force write changes to disk creating necessary subdirectories. Accepts an optional path (:write! some/path.txt)")
            case .new:
                return Info(invocation: ":new, :n",
                            description: "Create a new scratch buffer.")
            case .format:
                return Info(invocation: ":format, :fmt",
                            description: "Format the file using the LSP formatter.")
            case .indent_style:
                return Info(invocation: ":indent-style",
                            description: "Set the indentation style for editing. ('t' for tabs or 1-8 for number of spaces.)")
            case .line_ending:
                return Info(invocation: ":line-ending",
                            description: "Set the document's default line ending. Options: crlf, lf.")
            case .earlier:
                return Info(invocation: ":earlier, :ear",
                            description: "Jump back to an earlier point in edit history. Accepts a number of steps or a time span.")
            case .later:
                return Info(invocation: ":later, :lat",
                            description: "Jump to a later point in edit history. Accepts a number of steps or a time span.")
            case .write_quit:
                return Info(invocation: ":write-quit, :wq, :x",
                            description: "Write changes to disk and close the current view. Accepts an optional path (:wq some/path.txt)")
            case .force_write_quit:
                return Info(invocation: ":write-quit!, :wq!, :x!",
                            description: "Write changes to disk and close the current view forcefully. Accepts an optional path (:wq! some/path.txt)")
            case .write_all:
                return Info(invocation: ":write-all, :wa",
                            description: "Write changes from all buffers to disk.")
            case .write_quit_all:
                return Info(invocation: ":write-quit-all, :wqa, :xa",
                            description: "Write changes from all buffers to disk and close all views.")
            case .force_write_quit_all:
                return Info(invocation: ":write-quit-all!, :wqa!, :xa!",
                            description: "Write changes from all buffers to disk and close all views forcefully (ignoring unsaved changes).")
            case .quit_all:
                return Info(invocation: ":quit-all, :qa",
                            description: "Close all views.")
            case .force_quit_all:
                return Info(invocation: ":quit-all!, :qa!",
                            description: "Force close all views ignoring unsaved changes.")
            case .cquit:
                return Info(invocation: ":cquit, :cq",
                            description: "Quit with exit code (default 1). Accepts an optional integer exit code (:cq 2).")
            case .force_cquit:
                return Info(invocation: ":cquit!, :cq!",
                            description: "Force quit with exit code (default 1) ignoring unsaved changes. Accepts an optional integer exit code (:cq! 2).")
            case .theme:
                return Info(invocation: ":theme",
                            description: "Change the editor theme (show current theme if no name specified).")
            case .clipboard_yank:
                return Info(invocation: ":clipboard-yank",
                            description: "Yank main selection into system clipboard.")
            case .clipboard_yank_join:
                return Info(invocation: ":clipboard-yank-join",
                            description: "Yank joined selections into system clipboard. A separator can be provided as first argument. Default value is newline.")
            case .primary_clipboard_yank:
                return Info(invocation: ":primary-clipboard-yank",
                            description: "Yank main selection into system primary clipboard.")
            case .primary_clipboard_yank_join:
                return Info(invocation: ":primary-clipboard-yank-join",
                            description: "Yank joined selections into system primary clipboard. A separator can be provided as first argument. Default value is newline.")
            case .clipboard_paste_after:
                return Info(invocation: ":clipboard-paste-after",
                            description: "Paste system clipboard after selections.")
            case .clipboard_paste_before:
                return Info(invocation: ":clipboard-paste-before",
                            description: "Paste system clipboard before selections.")
            case .clipboard_paste_replace:
                return Info(invocation: ":clipboard-paste-replace",
                            description: "Replace selections with content of system clipboard.")
            case .primary_clipboard_paste_after:
                return Info(invocation: ":primary-clipboard-paste-after",
                            description: "Paste primary clipboard after selections.")
            case .primary_clipboard_paste_before:
                return Info(invocation: ":primary-clipboard-paste-before",
                            description: "Paste primary clipboard before selections.")
            case .primary_clipboard_paste_replace:
                return Info(invocation: ":primary-clipboard-paste-replace",
                            description: "Replace selections with content of system primary clipboard.")
            case .show_clipboard_provider:
                return Info(invocation: ":show-clipboard-provider",
                            description: "Show clipboard provider name in status bar.")
            case .change_current_directory:
                return Info(invocation: ":change-current-directory, :cd",
                            description: "Change the current working directory.")
            case .show_directory:
                return Info(invocation: ":show-directory, :pwd",
                            description: "Show the current working directory.")
            case .encoding:
                return Info(invocation: ":encoding",
                            description: "Set encoding. Based on https://encoding.spec.whatwg.org.")
            case .character_info:
                return Info(invocation: ":character-info, :char",
                            description: "Get info about the character under the primary cursor.")
            case .reload:
                return Info(invocation: ":reload",
                            description: "Discard changes and reload from the source file.")
            case .reload_all:
                return Info(invocation: ":reload-all",
                            description: "Discard changes and reload all documents from the source files.")
            case .update:
                return Info(invocation: ":update",
                            description: "Write changes only if the file has been modified.")
            case .lsp_workspace_command:
                return Info(invocation: ":lsp-workspace-command",
                            description: "Open workspace command picker.")
            case .lsp_restart:
                return Info(invocation: ":lsp-restart",
                            description: "Restart the Language Server that is in use by the current doc.")
            case .lsp_stop:
                return Info(invocation: ":lsp-stop",
                            description: "Stop the Language Server that is in use by the current doc.")
            case .tree_sitter_scopes:
                return Info(invocation: ":tree-sitter-scopes",
                            description: "Display tree sitter scopes, primarily for theming and development.")
            case .debug_start:
                return Info(invocation: ":debug-start, :dbg",
                            description: "Start a debug session from a given template with given parameters.")
            case .debug_remote:
                return Info(invocation: ":debug-remote, :dbg-tcp",
                            description: "Connect to a debug adapter by TCP address and start a debugging session from a given template with given parameters.")
            case .debug_eval:
                return Info(invocation: ":debug-eval",
                            description: "Evaluate expression in current debug context.")
            case .vsplit:
                return Info(invocation: ":vsplit, :vs",
                            description: "Open the file in a vertical split.")
            case .vsplit_new:
                return Info(invocation: ":vsplit-new, :vnew",
                            description: "Open a scratch buffer in a vertical split.")
            case .hsplit:
                return Info(invocation: ":hsplit, :hs, :sp",
                            description: "Open the file in a horizontal split.")
            case .hsplit_new:
                return Info(invocation: ":hsplit-new, :hnew",
                            description: "Open a scratch buffer in a horizontal split.")
            case .tutor:
                return Info(invocation: ":tutor",
                            description: "Open the tutorial.")
            case .goto_line:
                return Info(invocation: ":goto, :g",
                            description: "Goto line number.")
            case .set_language:
                return Info(invocation: ":set-language, :lang",
                            description: "Set the language of current buffer (show current language if no value specified).")
            case .set_option:
                return Info(invocation: ":set-option, :set",
                            description: "Set a config option at runtime. For example, to disable smart case search, use :set search.smart-case false.")
            case .toggle_option:
                return Info(invocation: ":toggle-option, :toggle",
                            description: "Toggle a boolean config option at runtime. For example, to toggle smart case search, use :toggle search.smart-case.")
            case .get_option:
                return Info(invocation: ":get-option, :get",
                            description: "Get the current value of a config option.")
            case .sort:
                return Info(invocation: ":sort",
                            description: "Sort ranges in selection.")
            case .rsort:
                return Info(invocation: ":rsort",
                            description: "Sort ranges in selection in reverse order.")
            case .reflow:
                return Info(invocation: ":reflow",
                            description: "Hard-wrap the current selection of lines to a given width.")
            case .tree_sitter_subtree:
                return Info(invocation: ":tree-sitter-subtree, :ts-subtree",
                            description: "Display tree sitter subtree under cursor, primarily for debugging queries.")
            case .config_reload:
                return Info(invocation: ":config-reload",
                            description: "Refresh user config.")
            case .config_open:
                return Info(invocation: ":config-open",
                            description: "Open the user config.toml file.")
            case .config_open_workspace:
                return Info(invocation: ":config-open-workspace",
                            description: "Open the workspace config.toml file.")
            case .log_open:
                return Info(invocation: ":log-open",
                            description: "Open the helix log file.")
            case .insert_output:
                return Info(invocation: ":insert-output",
                            description: "Run shell command, inserting output before each selection.")
            case .append_output:
                return Info(invocation: ":append-output",
                            description: "Run shell command, appending output after each selection.")
            case .pipe:
                return Info(invocation: ":pipe",
                            description: "Pipe each selection to the shell command.")
            case .pipe_to:
                return Info(invocation: ":pipe-to",
                            description: "Pipe each selection to the shell command, ignoring output.")
            case .run_shell_command:
                return Info(invocation: ":run-shell-command, :sh",
                            description: "Run a shell command.")
            case .reset_diff_change:
                return Info(invocation: ":reset-diff-change, :diffget, :diffg",
                            description: "Reset the diff change at the cursor position.")
            }
        }
    }
}

extension Helix.Commands {
    /// Projection into the shared row model used by the guide's list views.
    static var entries: [GuideEntry] {
        allCases.map {
            GuideEntry(id: $0.rawValue, key: $0.info.invocation, detail: $0.info.description)
        }
    }
}
