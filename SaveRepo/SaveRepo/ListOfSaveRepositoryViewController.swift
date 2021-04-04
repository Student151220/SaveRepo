//
//  ListOfSaveRepositoryViewController.swift
//  SaveRepo
//
//  Created by Damian Prokop on 03/04/2021.
//

import UIKit

final class ListOfSaveRepositoryViewController: UIViewController, UITableViewDelegate{

    
    @IBOutlet private(set) weak var searchBar: UISearchBar!
    @IBOutlet private(set) weak var tableView: UITableView!
    @IBOutlet private(set) weak var prevButton: UIButton!
    
    private let viewModel = ListOfSaveRepositoryViewModel()
    var dataDownload : [ItemDataBase]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prevButton.layer.cornerRadius = 20
        
        if #available(iOS 13.0, *) {
                overrideUserInterfaceStyle = .light
        }
        
        searchBar.delegate = self
        viewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50.0
        tableView.register(UINib(nibName: K.Cell.CellRepozytoryNibName, bundle: nil), forCellReuseIdentifier: K.Cell.CellRepozytoryIdentifier)
       // viewModel.getAllSaveRepository()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getAllSaveRepository()
    }


    


    @IBAction private func pressPrevButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    private func runErrorAlert(){
        let alert = UIAlertController(title: "Bład obsługi danych", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default){(action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}







// MARK: - UISearchBarDelegate method

extension ListOfSaveRepositoryViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            viewModel.getRecords(text: text)
            searchBar.resignFirstResponder()
        }
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text{
            if text.count == 0 {
                viewModel.getAllSaveRepository()
            } else {
                viewModel.getRecords(text: text)
            }
        }
    }
}




// MARK: - ListOfSaveRepositoryViewModelDelegate method

extension ListOfSaveRepositoryViewController: ListOfSaveRepositoryViewModelDelegate{
    func getRecord(data: [ItemDataBase]) {
        dataDownload = data
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
        }
    }
    
    func getRecordError(error: Error) {
        runErrorAlert()
    }
    
    func getAllRecord(data: [ItemDataBase]) {
        dataDownload = data
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
        }
    }
    
    func getAllRecordError(error: Error) {
        runErrorAlert()
    }
  
}










// MARK: - UITableViewDataSource method

extension ListOfSaveRepositoryViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataDownload?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let item = dataDownload?[indexPath.row] {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Cell.CellRepozytoryIdentifier, for: indexPath) as! CellListOfRepository
            cell.titleLabel.text = item.name
            cell.starsLabel.text = String(item.stargazers_count)
            return cell
        } else{
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Cell.CellSimple, for: indexPath)
            cell.textLabel?.text = "Brak wyników"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailSaveRepositoryViewController.controllerFromStoryboard(Storyboard.main)
        vc.data = dataDownload?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}



