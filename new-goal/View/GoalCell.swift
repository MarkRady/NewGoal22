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
    @IBOutlet weak var isCompleted: UIView!
    
    //func configureCell(description: String, type: GoalType, progress: Int) {
    func configureCell(goal: Goals) {
        self.goalDescriptionLabel.text = goal.goalDescription;
        self.goalTypeLabel.text = goal.goalType;
        self.goalProgressLabel.text = String(describing: goal.goalProgress);
        
        if goal.goalProgress == goal.goalTarget {
            self.isCompleted.isHidden = false;
        }
        else {
            self.isCompleted.isHidden = true;
        }
    }
}
