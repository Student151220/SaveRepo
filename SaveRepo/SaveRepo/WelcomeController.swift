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
    // co to kur... za puste linie? jak to wygląda?
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad() // Super się wywołuje od razu
        searchRepoButton.layer.cornerRadius = 20
        saveRepoButton.layer.cornerRadius = 20
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction private func pressSearch(_ sender: Any) {
        // Ogólnie to trochę słabe jest żeby od razu tutaj pokazywać kolejny kontroler.
        // Na tym etapie ok, ale przydałyby sie tutaj koordynatory
        let vc = SearchViewController.controllerFromStoryboard(Storyboard.main)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction private func pressSaveRepository(_ sender: Any) {
        let vc = ListOfSaveRepositoryViewController.controllerFromStoryboard(Storyboard.main)
        navigationController?.pushViewController(vc, animated: true)
    }

}

