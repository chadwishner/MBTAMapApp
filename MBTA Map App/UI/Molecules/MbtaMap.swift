//
//  MbtaMap.swift
//  MBTA Map App
//
//  Created by Chad Wishner on 1/9/24.
//

import SwiftUI

struct MbtaMap: View {
    var body: some View {
        Image("Map")
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct MbtaMap_Previews: PreviewProvider {
    static var previews: some View {
        MbtaMap()
            .frame(width: 500, height: 500)
            .previewLayout(.sizeThatFits)
    }
}
