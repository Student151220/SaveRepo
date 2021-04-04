//
//  ListOfRepositoryViewController.swift
//  SaveRepo
//
//  Created by Damian Prokop on 01/04/2021.
//

import UIKit

final class ListOfRepositoryViewController: UIViewController, UITableViewDelegate {
    
    
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet private(set) weak var tableView: UITableView!
    var downloadData: GitHubData?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prevButton.layer.cornerRadius = 20
        
        tableView.register(UINib(nibName: K.Cell.CellRepozytoryNibName, bundle: nil), forCellReuseIdentifier: K.Cell.CellRepozytoryIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50.0
        tableView.reloadData()
    }
    
  

    @IBAction func pressPrevButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
}





// MARK: - UITableViewDataSource mehod

extension ListOfRepositoryViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return downloadData?.items.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let item = downloadData?.items[indexPath.row] {
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
        let vc = DetailsRepositoryViewController.controllerFromStoryboard(Storyboard.main)
        vc.item = downloadData?.items[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


