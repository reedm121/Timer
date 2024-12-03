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
    var totalTime: Int
    var timerName: String
}

struct TimerWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimerWidgetAttributes.self) { context in
            //lock screen
            VStack{
                Text("\(context.attributes.timerName)")
                Text("\(context.state.count)s")
                ProgressView(value: Double(context.state.count) / Double(context.attributes.totalTime))
                    .padding(.horizontal)
            }
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text("\(context.state.count)s")
                        .padding(.horizontal)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("\(context.attributes.totalTime)")
                        .padding(.horizontal)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack {
                        ProgressView(value: Double(context.state.count) / Double(context.attributes.totalTime))
                            .padding(.horizontal)
                        
                        
                    }
                }
            } compactLeading: {
                Text("\(context.attributes.timerName)")
            } compactTrailing: {
                Text("\(context.state.count)s")
            } minimal: {
                Text("\(context.state.count)s")
            }
        }
    }
}

//MARK: previews

//for the previews, set your non-changing properties
extension TimerWidgetAttributes {
    static var preview: TimerWidgetAttributes {
        TimerWidgetAttributes(totalTime: 60, timerName: "Stretch timer")
    }
}


//for the previews add some ContentStates for the timer
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

//compact dynamic island preview
#Preview(as: .dynamicIsland(.compact), using: TimerWidgetAttributes.preview) {
    TimerWidgetLiveActivity()
} contentStates: {
    TimerWidgetAttributes.ContentState.initial
    TimerWidgetAttributes.ContentState.halfway
    TimerWidgetAttributes.ContentState.complete
}

//minimal dynamic island preview
#Preview(as: .dynamicIsland(.minimal), using: TimerWidgetAttributes.preview) {
    TimerWidgetLiveActivity()
} contentStates: {
    TimerWidgetAttributes.ContentState.initial
    TimerWidgetAttributes.ContentState.halfway
    TimerWidgetAttributes.ContentState.complete
}

//expanded dynamic island preview
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
