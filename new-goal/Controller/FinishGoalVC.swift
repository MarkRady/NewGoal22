//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by Mark Rady on 2/12/18.
//  Copyright © 2018 Mark Rady. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController {

    @IBOutlet weak var targetInput: UITextField!
    
    @IBOutlet weak var createGoalBtn: UIButton!
    
    // init data
    
    var goalDescription: String!
    var goalType: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createGoalBtn.bindToKeyboard();
    }
    
    func initData(description:String, goalType: GoalType){
        
    }

    
    @IBAction func createBtnPressed(_ sender: Any) {
    }
    
    
    @IBAction func dismissBtnPressed(_ sender: Any) {
    }
    
    
}
