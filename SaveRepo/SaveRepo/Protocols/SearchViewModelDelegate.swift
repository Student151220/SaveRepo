//
//  SearchViewModelDelegate.swift
//  SaveRepo
//
//  Created by Damian Prokop on 30/03/2021.
//

import Foundation


protocol SearchViewModelDelegate {
    func getGitHubData(data: GitHubData)
    func errorGitHubData(error: Error)
}
