//
//  SearchViewController.swift
//  SaveRepo
//
//  Created by Damian Prokop on 29/03/2021.
//

import UIKit

final class SearchViewController: UIViewController {

    
    @IBOutlet private(set) weak var textTextField: UITextField!
    @IBOutlet private(set) weak var langueTextField: UITextField!
    @IBOutlet private(set) weak var prevButton: UIButton!
    @IBOutlet private(set) weak var searchButton: UIButton!
    @IBOutlet private(set) weak var loadingAcivityInd: UIActivityIndicatorView!
    
    private let searchViewModel = SearchViewModel(gitHubManager: GitHubManager())
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prevButton.layer.cornerRadius = 20
        searchButton.layer.cornerRadius = 20
        loadingAcivityInd.isHidden = true
        
        
        textTextField.delegate = self
        langueTextField.delegate = self
        searchViewModel.delegate = self
    }
    

    
    @IBAction private func pressSearchButton(_ sender: Any) {
        textTextField.endEditing(true)
        
        if textTextField.text != "", langueTextField.text != "" {
            loadingAcivityInd.isHidden = false
            loadingAcivityInd.startAnimating()
            searchViewModel.getGitHubData(title: textTextField.text!, language: langueTextField.text!)
            
        }else{
            runAlert()
        }
    }
    
    
    @IBAction private func pressPrevButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    private func runAlert(){
        let alert = UIAlertController(title: "Uzupełnij wszystkie pola", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default){(action) in
            return
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func errorAlert(){
        let alert = UIAlertController(title: "Błąd pobierania danych", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default){(action) in
            return
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}




// MARK: - textfielddelegate Method

extension SearchViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}



// MARK: - SearchViewModelDelegate Method



extension SearchViewController : SearchViewModelDelegate{
    func getGitHubData(data: GitHubData) {
        DispatchQueue.main.async {
            self.loadingAcivityInd.stopAnimating()
            self.loadingAcivityInd.isHidden = true
            let vc = ListOfRepositoryViewController.controllerFromStoryboard(Storyboard.main)
            vc.downloadData = data
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    func errorGitHubData(error: Error) {
        DispatchQueue.main.async {
            self.errorAlert()
        }
    }
}


