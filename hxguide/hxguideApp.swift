//
//  hxguideApp.swift
//  hxguide
//
//  Created by Jimmy Hough Jr on 5/10/23.
//

import SwiftUI

@main
struct hxguideApp: App {
    var body: some Scene {
        WindowGroup {
            #if os(macOS)
            ContentView()
                .frame(minWidth: 720, minHeight: 480)
            #else
            ContentView()
            #endif
        }
        #if os(macOS)
        .defaultSize(width: 1000, height: 700)
        #endif
    }
}
