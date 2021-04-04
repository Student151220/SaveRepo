//
//  ViewController.swift
//  SaveRepo
//
//  Created by Damian Prokop on 24/03/2021.
//

import UIKit

final class WelcomeController: UIViewController {

    
    @IBOutlet private(set) weak var searchRepoButton: UIButton!
    @IBOutlet private(set) weak var saveRepoButton: UIButton!
    
    
    
    
    
    
    override func viewDidLoad() {
        searchRepoButton.layer.cornerRadius = 20
        saveRepoButton.layer.cornerRadius = 20
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction private func pressSearch(_ sender: Any) {
        let vc = SearchViewController.controllerFromStoryboard(Storyboard.main)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction private func pressSaveRepository(_ sender: Any) {
        let vc = ListOfSaveRepositoryViewController.controllerFromStoryboard(Storyboard.main)
        navigationController?.pushViewController(vc, animated: true)
    }

}

