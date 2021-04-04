//
//  DetailSaveRepositoryViewModel.swift
//  SaveRepo
//
//  Created by Damian Prokop on 04/04/2021.
//

import Foundation


final class DetailSaveRepositoryViewModel{
    
    private let dataManager = DataBaseManager()
    var delegate: DetailSaveRepositoryViewModelDelegate?
    
    
    func deleteRecord(item: ItemDataBase){
        
        dataManager.deleteRecord(item: item){result in
            switch result{
            case .success(_):
                self.delegate?.succesDeleteRecord()
            case .failure(let error):
                self.delegate?.errorDeleteRecord(error: error)
            }
        }
    }
}
