//
//  SizeView.swift
//  MyFirstWidget
//
//  Created by ANDRII ZUIOK on 23.12.2020.
//

import SwiftUI

struct SizeView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var model: Model
    
    var body: some View {
        
        GeometryReader(content: { geometry in
            VStack(alignment: .center, spacing: 20) {
                
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
                

                Button(action: {
                    model.configuration.sizeType = .smallSize
                }, label: {
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
                        LayoutFrameView(images: $model.images, sizeType: .constant(.smallSize), layoutType: $model.configuration.layoutType, blancColor: .gray).frame(width: 100, height: 100, alignment: .center)
                    }).frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.25, alignment: .center)
                    .background(Color(model.configuration.sizeType == .smallSize ?  .systemGray : .systemGray4)).cornerRadius(geometry.size.width * 0.1)
                }).frame(width: geometry.size.width, height: geometry.size.height * 0.25, alignment: .center)
                

                Button(action: {
                    model.configuration.sizeType = .mediumSize
                }, label: {
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
                        LayoutFrameView(images: $model.images, sizeType: .constant(.mediumSize), layoutType: $model.configuration.layoutType, blancColor: .gray).frame(width: 200, height: 100, alignment: .center)
                    }).frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.25, alignment: .center)
                    .background(Color(model.configuration.sizeType == .mediumSize ?  .systemGray : .systemGray4)).cornerRadius(geometry.size.width * 0.1)
                }).frame(width: geometry.size.width, height: geometry.size.height * 0.25, alignment: .center)
                
               
                Button(action: {
                    model.configuration.sizeType = .largeSize
                }, label: {
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
                        LayoutFrameView(images: $model.images, sizeType: .constant(.largeSize), layoutType: $model.configuration.layoutType, blancColor: .gray).frame(width: 200, height: 200, alignment: .center)
                    }).frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.25, alignment: .center)
                    .background(Color(model.configuration.sizeType == .largeSize ?  .systemGray : .systemGray4)).cornerRadius(geometry.size.width * 0.1)
                }).frame(width: geometry.size.width, height: geometry.size.height * 0.25, alignment: .center)
            
            }
        }).edgesIgnoringSafeArea(.bottom)
        
    }
}

struct SizeView_Previews: PreviewProvider {
    static var previews: some View {
        SizeView(model: Model())
    }
}
