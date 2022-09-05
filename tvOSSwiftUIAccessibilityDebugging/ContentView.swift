//
//  ContentView.swift
//  tvOSSwiftUIAccessibilityDebugging
//
//  Created by Arun Sinthanaisirrpi on 5/9/2022.
//

import SwiftUI

struct LiveAir: Identifiable {
    let id: UUID = UUID()
    let isOnAir: Bool
    let name: String
}

enum Mock {
    static var liveAirContent: [LiveAir] {
        [
            LiveAir(isOnAir: Bool.random(), name: "NSW"),
            LiveAir(isOnAir: Bool.random(), name: "VIC"),
            LiveAir(isOnAir: Bool.random(), name: "QLD"),
            LiveAir(isOnAir: Bool.random(), name: "WA"),
            LiveAir(isOnAir: Bool.random(), name: "ADL"),
            LiveAir(isOnAir: Bool.random(), name: "SYD"),
            LiveAir(isOnAir: Bool.random(), name: "NS"),
            LiveAir(isOnAir: Bool.random(), name: "VI"),
            LiveAir(isOnAir: Bool.random(), name: "QL"),
            LiveAir(isOnAir: Bool.random(), name: "W"),
            LiveAir(isOnAir: Bool.random(), name: "AD"),
            LiveAir(isOnAir: Bool.random(), name: "SY")
        ]
    }
}

struct ContentView: View {
    let liveStreams: [LiveAir]
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(liveStreams) { liveStream in
                    ABCLiveStreamView(
                        isOnAir: liveStream.isOnAir,
                        primaryText: liveStream.name
                    )
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(liveStreams: Mock.liveAirContent)
    }
}

struct ABCLiveStreamView: View {
    let isOnAir: Bool
    let primaryText: String
    
    @State
    private var isFocused = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            MediaInfoStack()
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 10) {
                Spacer()
                if (isOnAir) {
                    Text("is ON Air")
                        .font(.caption)
                        .bold()
                        .accessibilityHidden(true)
                }
                Text(primaryText)
                    .font(.title)
                    .accessibilityHidden(true)
                Spacer()
            }
        }
        .accessibilityLabel(primaryText)
        .accessibilityAddTraits([.isButton])
        .accessibilityElement(children: .combine)
        .focusable(true) { newstate in isFocused = newstate}
        .scaleEffect(isFocused ? 1.0 : 0.5)
        .animation(.spring(), value: 0.5)
    }
}

struct ABCLiveStreamView_Previews: PreviewProvider {
    static var previews: some View {
        ABCLiveStreamView(isOnAir: true, primaryText: "NSW")
    }
}


struct MediaInfoStack: View {
    var body: some View {
        Circle()
            .size(width: 200, height: 200)
            .fill(Color.yellow)
    }
}

struct MediaInfoStack_Previews: PreviewProvider {
    static var previews: some View {
        MediaInfoStack()
    }
}
