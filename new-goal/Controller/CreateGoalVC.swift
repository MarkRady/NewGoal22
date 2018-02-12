//
//  CreateGoalVC.swift
//  goalpost-app
//
//  Created by Mark Rady on 2/12/18.
//  Copyright © 2018 Mark Rady. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {

    
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    // selected option
    var goalType: GoalType = .shortTerm;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.bindToKeyboard();
        
        shortTermBtn.setSelectedColor();
        longTermBtn.setDeselectedColor();
    }
    
    
    @IBAction func longTermBtnPressed(_ sender: Any) {
        goalType = .longTerm;
        longTermBtn.setSelectedColor();
        shortTermBtn.setDeselectedColor();
        
    }
    
    @IBAction func shortTermBtnPressed(_ sender: Any) {
        goalType = .shortTerm;
        shortTermBtn.setSelectedColor();
        longTermBtn.setDeselectedColor();
    }
    
    
    @IBAction func nextBtnPressed(_ sender: Any) {
    }
    
    
    @IBAction func dismisBtnPressed(_ sender: Any) {
        dismissDetail();
    }
    


}
