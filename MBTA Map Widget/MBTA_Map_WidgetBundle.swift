//
//  MBTA_Map_WidgetBundle.swift
//  MBTA Map Widget
//
//  Created by Chad Wishner on 1/9/24.
//

import WidgetKit
import SwiftUI

@main
struct MBTA_Map_WidgetBundle: WidgetBundle {
    var body: some Widget {
        MBTA_Map_Widget()
        MBTA_Map_WidgetLiveActivity()
    }
}
