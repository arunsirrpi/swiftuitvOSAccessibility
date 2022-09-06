//
//  tvOSSwiftUIAccessibilityDebuggingApp.swift
//  tvOSSwiftUIAccessibilityDebugging
//
//  Created by Arun Sinthanaisirrpi on 5/9/2022.
//

import SwiftUI

@main
struct tvOSSwiftUIAccessibilityDebuggingApp: App {
    var body: some Scene {
        WindowGroup {
            // UseListView(liveStreams: Mock.liveAirContent)
            UseLazyVGridView(liveStreams: Mock.liveAirContent)
        }
    }
}
