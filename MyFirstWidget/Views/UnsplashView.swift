//
//  UnsplashView.swift
//  MyFirstWidget
//
//  Created by ANDRII ZUIOK on 23.12.2020.
//

import SwiftUI
import UnsplashPhotoPicker


protocol SaveImageProtocol: class {
    func saveImageUrl(_ url: URL)
}

struct UnsplashViewRepresentable: UIViewControllerRepresentable {
    
    weak var photoItemDelegate: SaveImageProtocol?
    
    class Coordinator: NSObject, UnsplashPhotoPickerDelegate {
        
        var parent: UnsplashViewRepresentable
        weak var delegate: SaveImageProtocol?
        
        init(_ unsplashPhotoPicker: UnsplashViewRepresentable) {
            parent = unsplashPhotoPicker
        }
        
        func unsplashPhotoPicker(_ photoPicker: UnsplashPhotoPicker, didSelectPhotos photos: [UnsplashPhoto]) {
            guard let unsplashPhoto = photos.first, let url = unsplashPhoto.urls[.small] else {return}
            self.delegate?.saveImageUrl(url)
        }
        
        func unsplashPhotoPickerDidCancel(_ photoPicker: UnsplashPhotoPicker) {}
        
    }
    
    func makeUIViewController(context: Context) -> UnsplashPhotoPicker {
        let configuration = UnsplashPhotoPickerConfiguration(accessKey: "x1Kj4cac8kvmS_q8RGeBgNIn8__P3P8MAQtOatw-DjA", secretKey: "dKnQ9KQmrj0An35TPXe-5M1QcBSip7lFZp0dd3Uh9PI", query: nil, allowsMultipleSelection: false)
        let unsplashPhotoPicker = UnsplashPhotoPicker(configuration: configuration)
        unsplashPhotoPicker.photoPickerDelegate = context.coordinator
        return unsplashPhotoPicker
    }
    
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator(self)
        coordinator.delegate = photoItemDelegate
        return coordinator
    }
    
    func updateUIViewController(_ uiViewController: UnsplashPhotoPicker, context: Context) {
        uiViewController.photoPickerDelegate = context.coordinator
    }
}

struct UnsplashViewRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        UnsplashViewRepresentable(photoItemDelegate: PhotoItemViewModel(index: 0, image:  UIImage(named: "1.jpg"), delegate: nil))
    }
}
