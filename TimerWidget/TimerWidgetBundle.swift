//
//  TimerWidgetBundle.swift
//  TimerWidget
//
//  Created by Reed Gantz on 12/2/24.
//

import WidgetKit
import SwiftUI

@main
struct TimerWidgetBundle: WidgetBundle {
    var body: some Widget {
        TimerWidget()
        TimerWidgetLiveActivity()
    }
}
