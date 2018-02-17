//
//  CreateGoalVC.swift
//  goalpost-app
//
//  Created by Mark Rady on 2/12/18.
//  Copyright © 2018 Mark Rady. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController, UITextViewDelegate {

    
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
        
        goalTextView.delegate = self;
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
        if goalTextView.text != "" && goalTextView.text != "What is your goal ?" {
            
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC") as? FinishGoalVC else {return}
            
            finishGoalVC.initData(description:self.goalTextView.text,
                                  goalType: self.goalType);
            presentingViewController?.presentSecondaryDetail(finishGoalVC); 
//            presentDetail(finishGoalVC)
        }
        else {
            let alert = UIAlertController(title: "Whoops", message: "Please write your goal", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func dismisBtnPressed(_ sender: Any) {
        dismissDetail();
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = "";
        goalTextView.textColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1);
    } 
    


}
