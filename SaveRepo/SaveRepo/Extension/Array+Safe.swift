//
//  Array+Safe.swift
//  SaveRepo
//
//  Created by Rafał Dubiel on 04/04/2021.
//

import Foundation

extension Array {
    
    public subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
    
}
