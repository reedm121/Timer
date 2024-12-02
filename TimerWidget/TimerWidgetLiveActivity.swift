//
//  TimerWidgetLiveActivity.swift
//  TimerWidget
//
//  Created by Reed Gantz on 12/2/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TimerWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var count: Int
    }

    // Fixed non-changing properties about your activity go here!
    var timerName: String
}

struct TimerWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimerWidgetAttributes.self) { context in
            Text("lock screen banner")
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading expanded")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing expanded")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom expanded")
                }
            } compactLeading: {
                Text("Compact L")
            } compactTrailing: {
                Text("Compact T")
            } minimal: {
                Text("min")
            }
        }
    }
}

extension TimerWidgetAttributes {
    static var preview: TimerWidgetAttributes {
        TimerWidgetAttributes(timerName: "Focus TimerWidget")
    }
}

extension TimerWidgetAttributes.ContentState {
    static var initial: TimerWidgetAttributes.ContentState {
        TimerWidgetAttributes.ContentState(count: 60) // Timer starting at 60 seconds
    }
    
    static var halfway: TimerWidgetAttributes.ContentState {
        TimerWidgetAttributes.ContentState(count: 30) // Timer halfway done
    }
    
    static var complete: TimerWidgetAttributes.ContentState {
        TimerWidgetAttributes.ContentState(count: 0) // Timer completed
    }
}

#Preview(as: .dynamicIsland(.compact), using: TimerWidgetAttributes.preview) {
    TimerWidgetLiveActivity()
} contentStates: {
    TimerWidgetAttributes.ContentState.initial
    TimerWidgetAttributes.ContentState.halfway
    TimerWidgetAttributes.ContentState.complete
}

#Preview(as: .dynamicIsland(.minimal), using: TimerWidgetAttributes.preview) {
    TimerWidgetLiveActivity()
} contentStates: {
    TimerWidgetAttributes.ContentState.initial
    TimerWidgetAttributes.ContentState.halfway
    TimerWidgetAttributes.ContentState.complete
}

#Preview(as: .dynamicIsland(.expanded), using: TimerWidgetAttributes.preview) {
    TimerWidgetLiveActivity()
} contentStates: {
    TimerWidgetAttributes.ContentState.initial
    TimerWidgetAttributes.ContentState.halfway
    TimerWidgetAttributes.ContentState.complete
}

//Lock screen preview
#Preview(as: .content, using: TimerWidgetAttributes.preview) {
    TimerWidgetLiveActivity()
} contentStates: {
    TimerWidgetAttributes.ContentState.initial
    TimerWidgetAttributes.ContentState.halfway
    TimerWidgetAttributes.ContentState.complete
}
