//
//  ListOfSaveRepositoryViewModelDelegate.swift
//  SaveRepo
//
//  Created by Damian Prokop on 03/04/2021.
//

import Foundation

protocol ListOfSaveRepositoryViewModelDelegate: AnyObject {
    func receivedNewData()
    func getAllRecordError(error:Error)
    func getRecordError(error:Error)
}
