//
//  DetailsRepositoryViewController.swift
//  SaveRepo
//
//  Created by Damian Prokop on 03/04/2021.
//

import UIKit

final class DetailsRepositoryViewController: UIViewController {
    
    @IBOutlet private(set) weak var nameLabel: UILabel!
    @IBOutlet private(set) weak var authorLabel: UILabel!
    @IBOutlet private(set) weak var languageLabel: UILabel!
    @IBOutlet private(set) weak var starsLabel: UILabel!
    @IBOutlet private(set) weak var openInSafariButton: UIButton!
    @IBOutlet private(set) weak var saveButton: UIButton!
    @IBOutlet private(set) weak var saveLabel: UILabel!
    @IBOutlet private(set) weak var prevButton: UIButton!
    
    
    var item: Items?
    private let detailRepositoryViewModel = DetailsRepositoryViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        openInSafariButton.layer.cornerRadius = 20
        saveButton.layer.cornerRadius = 20
        prevButton.layer.cornerRadius = 20
        saveLabel.isHidden = true
        detailRepositoryViewModel.delegate = self
        
        nameLabel.text = "Nazwa: \(item?.name ?? "brak")"
        languageLabel.text = "Język: \(item?.language ?? "brak")"
        authorLabel.text = "Autor: \(item?.owner.login ?? "brak")"
        if let stars = item?.stargazers_count {
            starsLabel.text = String(stars)
        }
    }
    
    
    
    @IBAction private func pressOpenInSafari(_ sender: Any) {
        if let url = URL(string: (item?.html_url)!){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
    @IBAction private func pressSaveRepository(_ sender: Any) {
        detailRepositoryViewModel.saveRepository(item: item!)
    }
    
    
    @IBAction private func pressPrevButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    private func runErrorAlert(){
        let alert = UIAlertController(title: "Nie udało się poprawnie zapisać", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default){(action) in
            return
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}


// MARK: - DetailsRepositoryViewModelDelegate Method

extension DetailsRepositoryViewController : DetailsRepositoryViewModelDelegate{
    func succesSaveData() {
        DispatchQueue.main.async {
            self.saveLabel.isHidden = false
        }
        
    }
    
    func errorSaveItem(error: Error) {
        DispatchQueue.main.async {
            self.runErrorAlert()
        }
    }
}
