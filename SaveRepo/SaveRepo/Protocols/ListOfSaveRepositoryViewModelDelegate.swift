//
//  ListOfSaveRepositoryViewModelDelegate.swift
//  SaveRepo
//
//  Created by Damian Prokop on 03/04/2021.
//

import Foundation


protocol ListOfSaveRepositoryViewModelDelegate {
    func getAllRecord(data:[ItemDataBase])
    func getAllRecordError(error:Error)
    func getRecord(data:[ItemDataBase])
    func getRecordError(error:Error)
}
