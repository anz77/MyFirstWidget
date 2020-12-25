//
//  FourthTypeLayoutView.swift
//  MyFirstWidget
//
//  Created by ANDRII ZUIOK on 23.12.2020.
//

import SwiftUI

struct FourthTypeLayoutView: View {
    
    @Binding var images: [Int : UIImage]
    var blancColor: UIColor
    
    var body: some View {
        GeometryReader { geometry in
            //Rectangle().cornerRadius(geometry.size.height * 0.1).foregroundColor(Color(.systemGray6))
            VStack(spacing: geometry.size.height * 0.04) {
                HStack(spacing: geometry.size.height * 0.04, content: {
                    viewForIndex(0).cornerRadius(geometry.size.height * 0.1)
                    viewForIndex(1).cornerRadius(geometry.size.height * 0.1)
                })
                HStack(spacing: geometry.size.height * 0.04, content: {
                    viewForIndex(3).cornerRadius(geometry.size.height * 0.1)
                    viewForIndex(2).cornerRadius(geometry.size.height * 0.1)
                })
            }.padding(geometry.size.height * 0.04)
        }
    }
    
    func viewForIndex(_ index: Int) -> AnyView {
        guard let image = images[index] else { return AnyView(Rectangle().foregroundColor(Color(blancColor))) }
        return AnyView(Image(uiImage: image).resizable())
    }
}

struct FourthTypeLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        FourthTypeLayoutView(images: .constant([:]), blancColor: .gray).frame(width: 100, height: 100, alignment: .center)
    }
}
