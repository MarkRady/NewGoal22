//
//  GoalCell.swift
//  goalpost-app
//
//  Created by Mark Rady on 2/12/18.
//  Copyright © 2018 Mark Rady. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalDescriptionLabel: UILabel!
    @IBOutlet weak var goalTypeLabel: UILabel!
    @IBOutlet weak var goalProgressLabel: UILabel!
    
    
    func configureCell(description: String, type: GoalType, progress: Int) {
        self.goalDescriptionLabel.text = description;
        self.goalTypeLabel.text = type.rawValue;
        self.goalProgressLabel.text = String(describing: progress);
    }
}
