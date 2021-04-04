//
//  DetailsRepositoryViewModelDelegate.swift
//  SaveRepo
//
//  Created by Damian Prokop on 03/04/2021.
//

import Foundation

protocol DetailsRepositoryViewModelDelegate {
    func succesSaveData()
    func errorSaveItem(error: Error)
}
