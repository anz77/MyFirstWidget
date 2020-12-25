//
//  PhotoItemView.swift
//  MyFirstWidget
//
//  Created by ANDRII ZUIOK on 23.12.2020.
//

import SwiftUI

struct PhotoItemView: View {
    
    @ObservedObject var model: PhotoItemViewModel
    @State var editModeEnabled: Bool = false
    @State var pickerModeEnabled: Bool = false
    
    var body: some View {
        
        GeometryReader(content: { geometry in
            
            ZStack {
                if let image = model.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .onTapGesture(perform: { editModeEnabled.toggle() })
                } else {
                    Button {
                        pickerModeEnabled = true
                        editModeEnabled = false
                    } label: { Image(systemName: "plus").resizable().padding() }.fullScreenCover(isPresented: $pickerModeEnabled, onDismiss: {}, content: { UnsplashViewRepresentable(photoItemDelegate: self.model) })
                }
            }.background(Color(.gray))
            .frame(width: geometry.size.height, height: geometry.size.height, alignment: .center)
            .cornerRadius(geometry.size.height * 0.2)
            
            if editModeEnabled {
                Button(action: {
                    model.deleteImage()
                    editModeEnabled = false
                }, label: {
                    Image(systemName: "multiply.circle.fill").resizable()
                    .foregroundColor(Color(.red))
                        .background(Color(.white))
                })
                .frame(width: geometry.size.height * 0.4, height: geometry.size.height * 0.4, alignment: .topTrailing)
                .cornerRadius(geometry.size.height * 0.2)
                .offset(x: geometry.size.height * 0.7, y: geometry.size.height * -0.1)
                
            }
            
        })
    }
}

struct PhotoItemView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoItemView(model: PhotoItemViewModel(index: 1, image: UIImage(named: "1.jpg"), delegate: nil )).frame(width: 100, height: 100, alignment: .center)
    }
}
