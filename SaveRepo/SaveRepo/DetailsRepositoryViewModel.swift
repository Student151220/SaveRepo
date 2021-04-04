//
//  DetailsRepositoryViewModel.swift
//  SaveRepo
//
//  Created by Damian Prokop on 03/04/2021.
//

import Foundation


final class DetailsRepositoryViewModel{
    
    private let dataManager = DataBaseManager()
    var delegate: DetailsRepositoryViewModelDelegate?
    
    
    func saveRepository(item:Items) {
        dataManager.saveRepository(item: item){result in
            switch result{
            case .success(_):
                self.delegate?.succesSaveData()
            case .failure(let error):
                self.delegate?.errorSaveItem(error: error)
            }
        }
    }

}
