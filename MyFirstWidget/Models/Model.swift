//
//  Model.swift
//  MyFirstWidget
//
//  Created by ANDRII ZUIOK on 23.12.2020.
//

//import UIKit
import UIKit

enum LayoutType: Int, Codable {
    case zeroLayout
    case firstLayout
    case secondLayout
    case thirdLayout
}

enum SizeType: Int, Codable {
    case smallSize
    case mediumSize
    case largeSize
}

struct MyWidgetConfiguration: Codable {
    var sizeType: SizeType = SizeType.smallSize
    var layoutType: LayoutType = LayoutType.zeroLayout
    var imageUrls: [Int : URL] = [:]
}

class Model: ObservableObject {
    
    @Published var configuration: MyWidgetConfiguration = MyWidgetConfiguration() {
        didSet {
            storeConfiguration()
        }
    }
    @Published var images: [Int : UIImage] = [:]
    
    
    init() {
        self.fetchConfiguration()
        for key in self.configuration.imageUrls.keys {
            downloadImageForIndex(index: key)
        }
    }
    
    func downloadImageForIndex(index: Int) {
        guard let url = configuration.imageUrls[index] else {return}
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, let image = UIImage(data: data) else {return}
            DispatchQueue.main.async { self.images[index] = image }
        }.resume()
    }
    
    func storeConfiguration() {
        
        guard let userDefaults = UserDefaults(suiteName: "group.zuiokandrii.myapp") else {return}
        //let userDefaults = UserDefaults.standard
        let encoded = try? PropertyListEncoder().encode(configuration)
        userDefaults.setValue(encoded, forKey: "widgetConfiguration")
    }
    
    func fetchConfiguration() {
        guard let userDefaults = UserDefaults(suiteName: "group.zuiokandrii.myapp") else {return}

        //let userDefaults = UserDefaults.standard
        guard let fetchedEncodedConfiguration = userDefaults.object(forKey: "widgetConfiguration") as? Data else {return}
        let fetchedConfiguration = try? PropertyListDecoder().decode(MyWidgetConfiguration.self, from: fetchedEncodedConfiguration)
        if let configuration =  fetchedConfiguration {
            self.configuration = configuration
        }
        
    }
}

extension Model: ImageInteractionDelegateProtocol {
    
    func saveImageUrl(_ url: URL, for index: Int) {
        configuration.imageUrls[index] = url
        downloadImageForIndex(index: index)
    }
    
    func deleteImage(_ image: UIImage, for index: Int) {
        images[index] = nil
        configuration.imageUrls[index] = nil
    }
    
}
