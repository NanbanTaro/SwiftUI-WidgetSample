//
//  WidgetSampleBundle.swift
//  WidgetSampleApp
//
//  Created by NanbanTaro on 2025/05/18.
//  
//

import WidgetKit
import SwiftUI

@main
struct WidgetSampleBundle: WidgetBundle {
    var body: some Widget {
        WidgetSample()
        WidgetSampleControl()
        WidgetSampleLiveActivity()
    }
}
