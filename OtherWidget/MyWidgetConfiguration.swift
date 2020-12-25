//
//  Configuration.swift
//  OtherWidgetExtension
//
//  Created by ANDRII ZUIOK on 24.12.2020.
//
import UIKit
import WidgetKit

struct MyWidgetConfiguration: Codable {
    var sizeType: SizeType = SizeType.smallSize
    var layoutType: LayoutType = LayoutType.zeroLayout
    var imageUrls: [Int : URL] = [:]
}

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
