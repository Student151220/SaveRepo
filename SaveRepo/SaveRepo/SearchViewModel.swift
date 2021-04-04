//
//  SearchViewModel.swift
//  SaveRepo
//
//  Created by Damian Prokop on 30/03/2021.
//

import Foundation

final class SearchViewModel{

    private let gitHubManager = GitHubManager()
    var delegate: SearchViewModelDelegate?
    
    
    func getGitHubData(title: String, language: String){
        gitHubManager.request(title: title, language: language){ result in
            switch result{
            case .success(let gitHubData):
                self.delegate?.getGitHubData(data: gitHubData)
            
            case .failure(let error):
                self.delegate?.errorGitHubData(error: error)
            }
        }
    }
}
