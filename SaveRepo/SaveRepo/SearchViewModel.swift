//
//  SearchViewModel.swift
//  SaveRepo
//
//  Created by Damian Prokop on 30/03/2021.
//

import Foundation

final class SearchViewModel {

    // jak nie ma inita i tak jawnie przypisujesz tutaj instancje to ten kod jest nietestowalny
    // jakbyś teraz napisal test, to ten GitHubManager robiłby zapytania internetowe, a testy powinny być od tego niezależne
    // dlatego trzeba zrobić tutaj inita, a każdy menadżer powinien mieć protokół
    // wtedy w inicie jako typ podajesz protokół
    private let gitHubManager: GitHubManagerRequest
    
    init(gitHubManager: GitHubManagerRequest) {
        self.gitHubManager = gitHubManager
    }
    
    
    // delegate musi być weak !!!
    // protokół powinien być w tym pliku, bo tak to nie widać od razu jakie on ma metody
    var delegate: SearchViewModelDelegate?
    
    // słabe formatowanie, powinien być odstęp między String) a {
    func getGitHubData(title: String, language: String){
        gitHubManager.request(title: title, language: language){ result in
            // tutaj jest retain cycle, bo self w closure powinien być weak, trzeba to zapisać jako [weak self] result in
            // potem można zastosować tzw. strongSelf/weakSelf dance żeby nie używać optionala, tylko ten strongSelf-a
            // guard let strongSelf = self else { return }
            switch result{
            case .success(let gitHubData):
                self.delegate?.getGitHubData(data: gitHubData)
            
            case .failure(let error):
                self.delegate?.errorGitHubData(error: error)
            }
        }
    }
}

// Teraz jakbyś pisal test tego view modelu, to robisz sobie mock, w którym możesz podać jaką chcesz dostać odpowiedź:
//
//final class GithubManagerMock: GitHubManagerRequest {
//
//    var githubData: GitHubData?
//    var error: Error?
//
//    func setResponse(githubData: GitHubData? = nil, error: Error? = nil) {
//        self.githubData = githubData
//        self.error = error
//    }
//
//    func request(title: String, language: String, completion: @escaping ((Result<GitHubData, Error>) -> Void)) {
//        if let error = error {
//            completion(.failure(error))
//            return
//        }
//        if let githubData = githubData {
//            completion(.success(githubData))
//            return
//        }
//    }
//
//}
//
//let githubManager = GithubManagerMock()
//let searchViewModel = SearchViewModel(gitHubManager: githubManager)
//
//
//githubManager.setResponse(error: NSError(domain: "Jakis blad", code: 1, userInfo: nil))
//searchViewModel.getGitHubData(title: "Dupa", language: "Pl")
// i tutaj byś sobie coś sprawdzał
