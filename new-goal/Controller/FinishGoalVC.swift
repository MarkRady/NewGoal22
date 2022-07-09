//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by Mark Rady on 2/12/18.
//  Copyright © 2018 Mark Rady. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate;

class FinishGoalVC: UIViewController {

    @IBOutlet weak var targetInput: UITextField!
    
    @IBOutlet weak var createGoalBtn: UIButton!

    // init data
    
    var goalDescription: String!
    var goalType: GoalType!
    var delegate: GoalsVC?

//    var goalDataArray: [String: Any] = ["":""];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //createGoalBtn.bindToKeyboard();
        initializeHideKeyboard()
    }
    
  
    func initData(description:String, goalType: GoalType){
        self.goalDescription = description;
        self.goalType = goalType;

    }

    
    @IBAction func createBtnPressed(_ sender: Any) {
        if targetInput.text != "" {
            self.save { (complete) in
                if complete {
                    print("dismiss")
                    self.delegate?.updateProcessStatus(isCompleted: true)
                    dismiss(animated: true, completion: nil)
                }
                
            }
        }
        
    }
    
    
    @IBAction func dismissBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
    
    func save(completion: (_ finish: Bool) -> ()){
        guard let manageContext = appDelegate?.persistentContainer.viewContext else { return  }
        let goals = Goals(context: manageContext);
        
        goals.goalDescription = goalDescription;
        goals.goalType = goalType.rawValue;
        goals.goalTarget = Int32(targetInput.text!)!;
        goals.goalProgress = Int32(0);
        
        do {
            try manageContext.save();
            completion(true);
            print("msg", "successfully  ")
        }
        catch {
            debugPrint("Could note save: \(error.localizedDescription)")
            completion(false);
        }
    }
    
}







extension FinishGoalVC {
    func initializeHideKeyboard()
    {
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
        target: self,
        action: #selector(dismissMyKeyboard))
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard()
    {
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }
}

