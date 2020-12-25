//
//  LayoutFrameView.swift
//  MyFirstWidget
//
//  Created by ANDRII ZUIOK on 23.12.2020.
//

import SwiftUI

struct LayoutFrameView: View {
    
    @Binding var images: [Int : UIImage]
    @Binding var sizeType: SizeType
    @Binding var layoutType: LayoutType
    var blancColor: UIColor
    
    var body: some View {
        ZStack(alignment: .center) {
            GeometryReader { geometry in
                if sizeType == .largeSize || sizeType == .smallSize {
                    switch layoutType {
                    case .zeroLayout : FirstTypeLayoutView(images: $images, blancColor: blancColor)
                    case .firstLayout : SecondTypeLayoutView(images: $images, blancColor: blancColor)
                    case .secondLayout : ThirdTypeLayoutView(images: $images, blancColor: blancColor)
                    case .thirdLayout : FourthTypeLayoutView(images: $images, blancColor: blancColor)
                    }
                } else {
                    switch layoutType {
                    case .zeroLayout : FourthTypeLayoutView(images: $images, blancColor: blancColor)
                    case .firstLayout : FifthTypeLayoutView(images: $images, blancColor: blancColor)
                    case .secondLayout : SixthTypeLayoutView(images: $images, blancColor: blancColor)
                    case .thirdLayout : SecondTypeLayoutView(images: $images, blancColor: blancColor)
                    }
                }
            }
        }
    }
}

struct LayoutFrameView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutFrameView(images: .constant([:]), sizeType: .constant(.smallSize), layoutType: .constant(.zeroLayout), blancColor: .gray).frame(width: 100, height: 100, alignment: .center)
    }
}
