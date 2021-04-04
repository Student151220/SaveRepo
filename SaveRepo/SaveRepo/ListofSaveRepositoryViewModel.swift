//
//  ListofSaveRepositoryViewModel.swift
//  SaveRepo
//
//  Created by Damian Prokop on 03/04/2021.
//

import Foundation

protocol RepositoriesViewModel {
    var repositories: [ItemDataBase] { get }
    var sections: [RepositoriesListSections] { get }
    
    func getAllSaveRepository()
    func getRecords(text: String)
    func getNumberOfRows(for section: Int) -> Int
}

// ta sama historia co w SearchViewModel
final class ListOfSaveRepositoryViewModel: RepositoriesViewModel {
    
    private weak var delegate: ListOfSaveRepositoryViewModelDelegate?
    private let dataManager: DataBaseManager
    var repositories: [ItemDataBase] = []
    var sections: [RepositoriesListSections] = []
    
    init(dataManager: DataBaseManager, delegate: ListOfSaveRepositoryViewModelDelegate) {
        self.dataManager = dataManager
        self.delegate = delegate
    }
    
    func getAllSaveRepository() {
        dataManager.loadAllRecords() { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let items):
                strongSelf.repositories = items
                strongSelf.delegate?.receivedNewData()
            case .failure(let error):
                strongSelf.delegate?.getAllRecordError(error: error)
            }
        }
    }
    
    func getRecords(text:String){
        dataManager.loadRecords(text: text) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result{
            case .success(let items):
                strongSelf.delegate?.receivedNewData()
            case .failure(let error):
                strongSelf.delegate?.receivedNewData()
            }
        }
    }
    
    func getNumberOfRows(for section: Int) -> Int {
        switch sections[section] {
        case .repository:
            return repositories.count
        case .noResults:
            return 1
        }
    }
    
}
