//
//  PhotosView.swift
//  MyFirstWidget
//
//  Created by ANDRII ZUIOK on 23.12.2020.
//

import SwiftUI

struct PhotosView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var model: Model
    
    var layoutFrameViewHeightScale: CGFloat {
        switch model.configuration.sizeType {
        case .smallSize:
            return 0.2
        case .mediumSize:
            return 0.2
        case .largeSize:
            return 0.4
        }
    }
    
    var layoutFrameViewWidthScale: CGFloat {
        switch model.configuration.sizeType {
        case .smallSize:
            return 0.2
        case .mediumSize:
            return 0.4
        case .largeSize:
            return 0.4
        }
    }
    
    var body: some View {
        GeometryReader(content: { geometry in
            VStack(content: {
                
                
                HStack(alignment: .center, spacing: nil) {
                    Spacer().frame(width: geometry.size.width * 0.07, height: geometry.size.width * 0.07, alignment: .center)
                    Button(action: {presentationMode.wrappedValue.dismiss()}, label: { Image(systemName: "multiply").resizable().foregroundColor(Color(.systemGray)) }).frame(width: geometry.size.width * 0.07, height: geometry.size.width * 0.07, alignment: .center)//.padding()
                    Spacer().frame(width: geometry.size.width * 0.18, height: geometry.size.width * 0.07, alignment: .center)
                    Text("Widget").font(.title).foregroundColor(Color(.systemGray)).frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.05, alignment: .center)
                    Button(action: {}, label: {
                        VStack{
                            Spacer()
                            Image(systemName: "ellipsis").resizable().scaledToFit().foregroundColor(Color(.systemGray))
                        }
                    }).frame(width: geometry.size.width * 0.07, height: geometry.size.width * 0.07, alignment: .center)
                    Spacer()
                    Button(action: {}, label: { Image(systemName: "square.and.arrow.down").resizable().foregroundColor(Color(.systemGray)) }).frame(width: geometry.size.width * 0.07, height: geometry.size.width * 0.07, alignment: .center)
                    Spacer()

                }.frame(width: geometry.size.width, height: geometry.size.height * 0.1, alignment: .center)
                
                ZStack {
                    LayoutFrameView(images: $model.images, sizeType: $model.configuration.sizeType, layoutType: $model.configuration.layoutType, blancColor: .gray).frame(width: geometry.size.height * layoutFrameViewWidthScale, height: geometry.size.height * layoutFrameViewHeightScale, alignment: .center)
                }.frame(width: geometry.size.width, height: geometry.size.height * 0.6, alignment: .center)
                
                
                HStack(alignment: .center, spacing: 20, content: {
                    
                    if (((model.configuration.sizeType == .largeSize) || (model.configuration.sizeType == .smallSize)) &&  (model.configuration.layoutType == .zeroLayout)) || ((model.configuration.sizeType == .mediumSize) && ((model.configuration.layoutType == .firstLayout) || (model.configuration.layoutType == .secondLayout)))  {
                        PhotoItemView(model: PhotoItemViewModel(index: 0, image: model.images[0], delegate: model)).frame(width: 70, height: 70, alignment: .center)
                        
                        PhotoItemView(model: PhotoItemViewModel(index: 1, image: model.images[1], delegate: model)).frame(width: 70, height: 70, alignment: .center)
                        
                        PhotoItemView(model: PhotoItemViewModel(index: 2, image: model.images[2], delegate: model)).frame(width: 70, height: 70, alignment: .center)
                    } else if (((model.configuration.sizeType == .largeSize) || (model.configuration.sizeType == .smallSize)) && ((model.configuration.layoutType == .firstLayout) || (model.configuration.layoutType == .secondLayout))) || ((model.configuration.sizeType == .mediumSize) && (model.configuration.layoutType == .thirdLayout)) {
                        
                        PhotoItemView(model: PhotoItemViewModel(index: 0, image: model.images[0], delegate: model)).frame(width: 70, height: 70, alignment: .center)
                        
                        PhotoItemView(model: PhotoItemViewModel(index: 1, image: model.images[1], delegate: model)).frame(width: 70, height: 70, alignment: .center)
                        
                    } else {
                        
                        PhotoItemView(model: PhotoItemViewModel(index: 0, image: model.images[0], delegate: model)).frame(width: 70, height: 70, alignment: .center)
                        
                        PhotoItemView(model: PhotoItemViewModel(index: 1, image: model.images[1], delegate: model)).frame(width: 70, height: 70, alignment: .center)
                        
                        PhotoItemView(model: PhotoItemViewModel(index: 2, image: model.images[2], delegate: model)).frame(width: 70, height: 70, alignment: .center)
                        
                        PhotoItemView(model: PhotoItemViewModel(index: 3, image: model.images[3], delegate: model)).frame(width: 70, height: 70, alignment: .center)
                    }
                    
                        
                }).frame(width: geometry.size.width, height: geometry.size.height * 0.3, alignment: .center).background(Color(.systemGray6))
                .cornerRadius(geometry.size.width * 0.07)
                
            })
            
            
        }).edgesIgnoringSafeArea(.bottom)
    }
}

struct PhotosView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosView(model: Model())
    }
}
