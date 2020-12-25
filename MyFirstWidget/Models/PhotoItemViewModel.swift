//
//  PhotoViewModel.swift
//  MyFirstWidget
//
//  Created by ANDRII ZUIOK on 23.12.2020.
//

import Foundation
import UnsplashPhotoPicker

class PhotoItemViewModel: ObservableObject {
    
    weak var imageInteractionDelegate: ImageInteractionDelegateProtocol?
    
    let index: Int
    
    @Published var image: UIImage?
    
    init(index: Int, image: UIImage?, delegate: ImageInteractionDelegateProtocol?) {
        self.index = index
        self.image = image
        self.imageInteractionDelegate = delegate
    }
    
    func deleteImage() {
        guard let image = image else {return}
        imageInteractionDelegate?.deleteImage(image, for: index)
    }
}

extension PhotoItemViewModel: SaveImageProtocol {
    func saveImageUrl(_ url: URL) {
        imageInteractionDelegate?.saveImageUrl(url, for: index)
    }
    
}

protocol ImageInteractionDelegateProtocol: class {
    func saveImageUrl(_ url: URL, for index: Int)
    func deleteImage(_ image: UIImage, for index: Int)
}
