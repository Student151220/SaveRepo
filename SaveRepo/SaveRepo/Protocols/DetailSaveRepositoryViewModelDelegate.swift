//
//  DetailSaveRepositoryViewModelDelegate.swift
//  SaveRepo
//
//  Created by Damian Prokop on 04/04/2021.
//

import Foundation


protocol DetailSaveRepositoryViewModelDelegate {
    func succesDeleteRecord()
    func errorDeleteRecord(error: Error)
}
