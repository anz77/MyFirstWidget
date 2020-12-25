//
//  ContentView.swift
//  MyFirstWidget
//
//  Created by ANDRII ZUIOK on 22.12.2020.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var model: Model
    
    @State var photosModeEnabled: Bool = false
    @State var layersModeEnabled: Bool = false
    @State var sizeModeEnabled: Bool = false
    
    var layoutFrameViewHeightScale: CGFloat {
        switch model.configuration.sizeType {
        case .smallSize: return 0.2
        case .mediumSize: return 0.2
        case .largeSize: return 0.4
        }
    }
    
    var layoutFrameViewWidthScale: CGFloat {
        switch model.configuration.sizeType {
        case .smallSize: return 0.2
        case .mediumSize: return 0.4
        case .largeSize: return 0.4
        }
    }
    
    var body: some View {
        GeometryReader(content: { geometry in
            VStack(content: {
                
                HStack(alignment: .center, spacing: nil) {
                    Spacer().frame(width: geometry.size.width * 0.32, height: geometry.size.height * 0.05, alignment: .center)
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
                    
                    Button(action: {
                        sizeModeEnabled.toggle()
                    }, label: {
                        LayoutFrameView(images: $model.images, sizeType: $model.configuration.sizeType, layoutType: $model.configuration.layoutType, blancColor: .gray).frame(width: geometry.size.height * layoutFrameViewWidthScale, height: geometry.size.height * layoutFrameViewHeightScale, alignment: .center)
                    }).fullScreenCover(isPresented: $sizeModeEnabled, content: {
                        SizeView(model: model).onDisappear(perform: {
                            sizeModeEnabled = false
                        })
                    })
                    
                }.frame(width: geometry.size.width, height: geometry.size.height * 0.6, alignment: .center)
                                
                HStack(alignment: .center, spacing: 50, content: {
                    
                    Button(action: {
                        layersModeEnabled.toggle()
                    }, label: {
                        Image(systemName: "rectangle.3.offgrid.fill").resizable().padding().foregroundColor(.white)
                    }).background(Color(.systemGray2)).frame(width: 100, height: 100, alignment: .center).cornerRadius(20)
                    .fullScreenCover(isPresented: $layersModeEnabled, content: {
                        LayoutsView(model: model).onDisappear(perform: {
                            photosModeEnabled = false
                        })
                    })
                    
                    Button(action: {
                        photosModeEnabled.toggle()
                        print("photosModeEnabled")
                    }, label: {
                        Image(systemName: "photo").resizable().padding().foregroundColor(.white)
                    }).background(Color(.systemGray2)).frame(width: 100, height: 100, alignment: .center).cornerRadius(20)
                    .fullScreenCover(isPresented: $photosModeEnabled, content: {
                        PhotosView(model: model).onDisappear(perform: {
                            photosModeEnabled = false
                        })
                    })
                    
                }).frame(width: geometry.size.width, height: geometry.size.height * 0.3, alignment: .center).background(Color(.systemGray6))
                .cornerRadius(geometry.size.width * 0.07)
                
            })
        }).edgesIgnoringSafeArea(.bottom)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(model: Model())
    }
}
