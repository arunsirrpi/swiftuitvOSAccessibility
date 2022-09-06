//
//  ContentView.swift
//  tvOSSwiftUIAccessibilityDebugging
//
//  Created by Arun Sinthanaisirrpi on 5/9/2022.
//

import SwiftUI

// MARK: - Live stream Lazy Grid
struct UseLazyVGridView: View {
    let liveStreams: [LiveAir]
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(liveStreams) { liveStream in
                    ABCLiveStreamViewCellButton(
                        isOnAir: liveStream.isOnAir,
                        primaryText: liveStream.name) {
                            print("hello \(liveStream) tapped")
                        }
                }
            }
        }
    }
}

struct UseLazyVGridView_Previews: PreviewProvider {
    static var previews: some View {
        UseLazyVGridView(liveStreams: Mock.liveAirContent)
    }
}

// MARK: - Button
struct ABCLiveStreamViewCellButton: View {
    let isOnAir: Bool
    let primaryText: String
    let onTap: () -> Void
    
    @Environment(\.isFocused)
    private var focused
    
    var body: some View {
        Button(action: onTap) {
            ABCLiveStreamView(isOnAir: isOnAir, primaryText: primaryText)
        }
        .buttonStyle(.homeFeedButtonStyle)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text(primaryText))
        .accessibilityAddTraits([.isButton])
    }
}

// MARK: - Button Style
struct HomeFeedButtonStyle: ButtonStyle {
    @Environment(\.isFocused)
    private var focused: Bool
    
    @Environment(\.accessibilityVoiceOverEnabled)
    private var isVoiceOverOn: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .border(Color.white, width: (isVoiceOverOn && focused) ? 1.0 : 0.0)
            .scaleEffect(focused ? 1.0 : 0.8)
            .focusable(true)
            .animation(.spring(), value: 0.5)
    }
}

extension ButtonStyle where Self == HomeFeedButtonStyle {
    static var homeFeedButtonStyle: Self { Self() }
}

// MARK: - Live Stream view
struct ABCLiveStreamView: View {
    let isOnAir: Bool
    let primaryText: String
    
    @Environment(\.isFocused)
    private var isFocused
    
    var body: some View {
        HStack(alignment: .center, spacing: 50) {
            MediaInfoStack()
                .accessibilityHidden(true)
                .frame(width: 160, height: 90)
            VStack(alignment: .leading, spacing: 10) {
                if (isOnAir) {
                    Text("is ON Air")
                        .font(.caption)
                        .bold()
                }
                Text(primaryText)
                    .font(.title)
                    .foregroundColor(isFocused ? Color.red : Color.blue)
            }
            
            Spacer()
        }
    }
}

struct ABCLiveStreamView_Previews: PreviewProvider {
    static var previews: some View {
        ABCLiveStreamView(isOnAir: true, primaryText: "NSW")
    }
}

// MARK: - Media Info
struct MediaInfoStack: View {
    var body: some View {
        Circle()
            .fill(Color.blue)
            //.accessibilityHidden(true)
            .padding(20)
    }
}

struct MediaInfoStack_Previews: PreviewProvider {
    static var previews: some View {
        MediaInfoStack()
    }
}



// MARK: - Mocks
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
