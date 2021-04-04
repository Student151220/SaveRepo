//
//  DetailSaveRepositoryViewController.swift
//  SaveRepo
//
//  Created by Damian Prokop on 04/04/2021.
//

import UIKit

final class DetailSaveRepositoryViewController: UIViewController {

    @IBOutlet private(set) weak var nameLabel: UILabel!
    @IBOutlet private(set) weak var authorLabel: UILabel!
    @IBOutlet private(set) weak var languageLabel: UILabel!
    @IBOutlet private(set) weak var starsLabel: UILabel!
   
    
    @IBOutlet private(set) weak var prevButton: UIButton!
    @IBOutlet private(set) weak var openInSafariButton: UIButton!
    @IBOutlet private(set) weak var deleteButton: UIButton!
    var data : ItemDataBase?
    private let viewModel = DetailSaveRepositoryViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        openInSafariButton.layer.cornerRadius = 20
        deleteButton.layer.cornerRadius = 20
        prevButton.layer.cornerRadius = 20
        
        viewModel.delegate = self
        
        nameLabel.text = "Nazwa: \(data?.name ?? "brak")"
        languageLabel.text = "Język: \(data?.language ?? "brak")"
        authorLabel.text = "Autor: \(data?.login ?? "brak")"
        if let stars = data?.stargazers_count {
            starsLabel.text = String(stars)
        }
    }
    
    @IBAction private func pressOpenInSafari(_ sender: Any) {
        if let url = URL(string: (data?.html_url)!){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction private func pressDelete(_ sender: Any) {
        if let d = data{
            viewModel.deleteRecord(item: d)
        }
    }
    
    
    
    @IBAction func pressPrevButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
 
    
    private func runErrorAlert(){
        let alert = UIAlertController(title: "Nie można usunąć", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default){(action) in
            return
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func succesDeleteAlert(){
        let alert = UIAlertController(title: "Usunięto", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default){(action) in
            self.navigationController?.popViewController(animated: true)
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}


//MARK: - DetailSaveRepositoryViewModelDelegate method

extension DetailSaveRepositoryViewController : DetailSaveRepositoryViewModelDelegate{
    func succesDeleteRecord() {
        DispatchQueue.main.async {
            self.succesDeleteAlert()
        }
    }
    
    func errorDeleteRecord(error: Error) {
        DispatchQueue.main.async {
            self.runErrorAlert()
        }
    }
    
    
}
