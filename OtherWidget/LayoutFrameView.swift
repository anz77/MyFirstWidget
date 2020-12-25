//
//  LayoutFrameView.swift
//  OtherWidgetExtension
//
//  Created by ANDRII ZUIOK on 24.12.2020.
//

import SwiftUI


struct LayoutFrameView: View {
    
    var entry: SimpleEntry
    var sizeType: SizeType
    var blancColor: UIColor
    
    var body: some View {
        ZStack(alignment: .center) {
            GeometryReader { geometry in
                if sizeType == .largeSize || sizeType == .smallSize {
                    switch entry.layoutType {
                    case .zeroLayout : FirstTypeLayoutView(images: entry.images, blancColor: blancColor)
                    case .firstLayout : SecondTypeLayoutView(images: entry.images, blancColor: blancColor)
                    case .secondLayout : ThirdTypeLayoutView(images: entry.images, blancColor: blancColor)
                    case .thirdLayout : FourthTypeLayoutView(images: entry.images, blancColor: blancColor)
                    }    
                } else {
                    switch entry.layoutType {
                    case .zeroLayout : FourthTypeLayoutView(images: entry.images, blancColor: blancColor)
                    case .firstLayout : FifthTypeLayoutView(images: entry.images, blancColor: blancColor)
                    case .secondLayout : SixthTypeLayoutView(images: entry.images, blancColor: blancColor)
                    case .thirdLayout : SecondTypeLayoutView(images: entry.images, blancColor: blancColor)
                    }
                }
            }
        }//.background(Color(.systemGray))
    }
}

struct LayoutFrameView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutFrameView(entry: SimpleEntry(date: Date(), images: [:], layoutType: .firstLayout), sizeType: .smallSize, blancColor: .gray).frame(width: 100, height: 100, alignment: .center)
    }
}
