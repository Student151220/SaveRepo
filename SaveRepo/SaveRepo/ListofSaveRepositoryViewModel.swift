//
//  ListofSaveRepositoryViewModel.swift
//  SaveRepo
//
//  Created by Damian Prokop on 03/04/2021.
//

import Foundation


final class ListOfSaveRepositoryViewModel{
    
    var delegate: ListOfSaveRepositoryViewModelDelegate?
    let dataManager = DataBaseManager()
    
    func getAllSaveRepository(){
        dataManager.loadAllRecords(){result in
            switch result{
            case .success(let items):
                self.delegate?.getAllRecord(data: items)
            case .failure(let error):
                self.delegate?.getAllRecordError(error: error)
            }
        }
    }
    
    func getRecords(text:String){
        dataManager.loadRecords(text: text){result in
            switch result{
            case .success(let items):
                self.delegate?.getRecord(data: items)
            case .failure(let error):
                self.delegate?.getRecordError(error: error)
            }
        }
    }
    
    
    
}
