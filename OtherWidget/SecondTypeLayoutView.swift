//
//  SecondTypeLayoutView.swift
//  OtherWidgetExtension
//
//  Created by ANDRII ZUIOK on 24.12.2020.
//

import SwiftUI

struct SecondTypeLayoutView: View {
    
    var images: [Int : UIImage]
    var blancColor: UIColor
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: geometry.size.height * 0.04, content: {
                viewForIndex(0).cornerRadius(geometry.size.height * 0.1)
                viewForIndex(1).cornerRadius(geometry.size.height * 0.1)
            }).padding(geometry.size.height * 0.04)
        }
    }
    
    func viewForIndex(_ index: Int) -> AnyView {
        guard let image = images[index] else { return AnyView(Rectangle().foregroundColor(Color(blancColor))) }
        return AnyView(Image(uiImage: image).resizable())
    }
}

struct SecondTypeLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        SecondTypeLayoutView(images: [:], blancColor: .gray).frame(width: 100, height: 100, alignment: .center)
    }
}
