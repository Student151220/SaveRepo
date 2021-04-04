//
//  extensionUIViewController.swift
//  SaveRepo
//
//  Created by Damian Prokop on 29/03/2021.
//

import Foundation
import UIKit


extension UIViewController {
    
    private static func controllerInStoryboard<T: UIViewController>(_ storyboard: UIStoryboard, identifier: String) -> T {
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
    
    static func controllerFromStoryboard(_ storyboard: Storyboard) -> Self {
        return controllerInStoryboard(UIStoryboard(name: storyboard.rawValue, bundle: nil), identifier: nameOfClass)
    }
    
}
