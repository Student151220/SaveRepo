//
//  GitHubManager.swift
//  SaveRepo
//
//  Created by Damian Prokop on 30/03/2021.
//

import Foundation

final class GitHubManager{
    
    private let beginUrlString = "https://api.github.com/search/repositories?q="
    private let endUrlString = "&sort=stars&order=desc"
    
    
    
    
    
    func request(title: String, language: String, completion: @escaping ((Result<GitHubData, Error>) -> Void)){
        
        let urlString = "\(beginUrlString)\(title)+language:\(language)\(endUrlString)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Niepoprawny URL", code: 100, userInfo: nil)))
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url){(data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                completion(.failure(NSError(domain: "Blad", code: 100, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Brak danych", code: 100, userInfo: nil)))
                return
            }
            
            guard let githubData = try? JSONDecoder().decode(GitHubData.self, from: data) else {
                completion(.failure(NSError(domain: "Blad parsowania danych", code: 100, userInfo: nil)))
                return
            }
            
            completion(.success(githubData))
            
        }
        task.resume()
    }
}
