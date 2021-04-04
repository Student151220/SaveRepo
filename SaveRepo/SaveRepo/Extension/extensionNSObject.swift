//
//  extensionNSObject.swift
//  SaveRepo
//
//  Created by Damian Prokop on 29/03/2021.
//

import Foundation


enum Storyboard: String {
    case launchScreen = "LaunchScreen"
    case main = "Main"
}
extension NSObject {
    class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
