//
//  WidgetSampleLiveActivity.swift
//  WidgetSampleApp
//
//  Created by NanbanTaro on 2025/05/18.
//  
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WidgetSampleAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct WidgetSampleLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WidgetSampleAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension WidgetSampleAttributes {
    fileprivate static var preview: WidgetSampleAttributes {
        WidgetSampleAttributes(name: "World")
    }
}

extension WidgetSampleAttributes.ContentState {
    fileprivate static var smiley: WidgetSampleAttributes.ContentState {
        WidgetSampleAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: WidgetSampleAttributes.ContentState {
         WidgetSampleAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: WidgetSampleAttributes.preview) {
   WidgetSampleLiveActivity()
} contentStates: {
    WidgetSampleAttributes.ContentState.smiley
    WidgetSampleAttributes.ContentState.starEyes
}
