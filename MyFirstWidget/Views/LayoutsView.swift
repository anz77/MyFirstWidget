//
//  LayoutsView.swift
//  MyFirstWidget
//
//  Created by ANDRII ZUIOK on 23.12.2020.
//

import SwiftUI

struct LayoutsView: View {
    
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
                    Button(action: {}, label: { Image(systemName: "square.and.arrow.down").resizable().foregroundColor(Color(.systemGray)) }).frame(width: geometry.size.width * 0.07, height: geometry.size.width * 0.07, alignment: .center)//.padding()
                    Spacer()

                }.frame(width: geometry.size.width, height: geometry.size.height * 0.1, alignment: .center)
                
                ZStack {
                    LayoutFrameView(images: $model.images, sizeType: $model.configuration.sizeType, layoutType: $model.configuration.layoutType, blancColor: .gray).frame(width: geometry.size.height * layoutFrameViewWidthScale, height: geometry.size.height * layoutFrameViewHeightScale, alignment: .center)
                }.frame(width: geometry.size.width, height: geometry.size.height * 0.6, alignment: .center)
                
                HStack(alignment: .center, spacing: 20, content: {
                    
                    if model.configuration.sizeType == .mediumSize {
                        
                        VStack(alignment: .center, spacing: nil, content: {
                            Button(action: {model.configuration.layoutType = .zeroLayout}, label: {LayoutFrameView(images: .constant([:]), sizeType: .constant(.mediumSize), layoutType: .constant(.zeroLayout), blancColor: .gray).padding()}).frame(width: 160, height: 70, alignment: .center)
                                .background(Color(backgroundColorForIndex(0))).cornerRadius(geometry.size.height * 0.03)
                                
                            Button(action: {model.configuration.layoutType = .firstLayout}, label: {LayoutFrameView(images: .constant([:]), sizeType: .constant(.mediumSize), layoutType: .constant(.firstLayout), blancColor: .gray).padding()}).frame(width: 160, height: 70, alignment: .center)
                                .background(Color(backgroundColorForIndex(2))).cornerRadius(geometry.size.height * 0.03)
                        })
                        
                        VStack(alignment: .center, spacing: nil, content: {
                            Button(action: {model.configuration.layoutType = .secondLayout}, label: {LayoutFrameView(images: .constant([:]), sizeType: .constant(.mediumSize), layoutType: .constant(.secondLayout), blancColor: .gray).padding()}).frame(width: 160, height: 70, alignment: .center)
                                .background(Color(backgroundColorForIndex(1))).cornerRadius(geometry.size.height * 0.03)
                                
                            Button(action: {model.configuration.layoutType = .thirdLayout}, label: {LayoutFrameView(images: .constant([:]), sizeType: .constant(.mediumSize), layoutType: .constant(.thirdLayout), blancColor: .gray).padding()}).frame(width: 160, height: 70, alignment: .center)
                                .background(Color(backgroundColorForIndex(3))).cornerRadius(geometry.size.height * 0.03)
                        })
                        
                    } else {
                        Button(action: {model.configuration.layoutType = .zeroLayout}, label: {LayoutFrameView(images: .constant([:]), sizeType: .constant(.smallSize), layoutType: .constant(.zeroLayout), blancColor: .gray).padding()}).frame(width: 70, height: 70, alignment: .center)
                            .background(Color(backgroundColorForIndex(0))).cornerRadius(geometry.size.height * 0.03)
                        
                        Button(action: {model.configuration.layoutType = .firstLayout}, label: {LayoutFrameView(images: .constant([:]), sizeType: .constant(.smallSize), layoutType: .constant(.firstLayout), blancColor: .gray).padding()}).frame(width: 70, height: 70, alignment: .center)
                            .background(Color(backgroundColorForIndex(1))).cornerRadius(geometry.size.height * 0.03)
                        
                        Button(action: {model.configuration.layoutType = .secondLayout}, label: {LayoutFrameView(images: .constant([:]), sizeType: .constant(.smallSize), layoutType: .constant(.secondLayout), blancColor: .gray).padding()}).frame(width: 70, height: 70, alignment: .center)
                            .background(Color(backgroundColorForIndex(2))).cornerRadius(geometry.size.height * 0.03)
                        
                        Button(action: {model.configuration.layoutType = .thirdLayout}, label: {LayoutFrameView(images: .constant([:]), sizeType: .constant(.smallSize), layoutType: .constant(.thirdLayout), blancColor: .gray).padding()}).frame(width: 70, height: 70, alignment: .center)
                            .background(Color(backgroundColorForIndex(3))).cornerRadius(geometry.size.height * 0.03)
                    }
                    
                }).frame(width: geometry.size.width, height: geometry.size.height * 0.3, alignment: .center).background(Color(.systemGray6))
                .cornerRadius(geometry.size.width * 0.07)
            })
                        
        }).edgesIgnoringSafeArea(.bottom)
    }
    
    
    func backgroundColorForIndex(_ index: Int) -> UIColor {
        index == model.configuration.layoutType.rawValue ? .systemGray : .systemGray4
    }
    
}

struct LayersView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutsView(model: Model())
    }
}
