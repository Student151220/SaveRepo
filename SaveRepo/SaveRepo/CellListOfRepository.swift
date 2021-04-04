//
//  CellListOfRepository.swift
//  SaveRepo
//
//  Created by Damian Prokop on 31/03/2021.
//

import UIKit

final class CellListOfRepository: UITableViewCell {

    
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var starsLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
