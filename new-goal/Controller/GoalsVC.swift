//
//  GoalsVC.swift
//  goalpost-app
//
//  Created by Mark Rady on 2/11/18.
//  Copyright © 2018 Mark Rady. All rights reserved.
//

import UIKit;
import CoreData;

class GoalsVC: UIViewController {

    var dataColection: [Goals] = [];

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.isHidden = false;
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.fetch { (complete) in
            if  complete {
                if dataColection.count > 0 {
                    tableView.isHidden = false;
                    
                } else {
                    tableView.isHidden = true;
                }
            }
            
        }
        tableView.reloadData(); 
    }
    

    
    @IBAction func createBtnPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else { return };
        
        presentDetail(createGoalVC);
//        performSegue(withIdentifier: "createGoal", sender: nil)
    }
}



extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataColection.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                                                    //"goalCell" is identifir pass to cell in view
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell
        else {
            return UITableViewCell();
                
        }
        let goal = dataColection[indexPath.row]
        cell.configureCell(goal: goal);
//        cell.configureCell(description: goal.goalDescription!, type: goal.goalType, progress: goal.goalProgress);
        return cell;
    }
    
}


extension GoalsVC {
    func fetch (completion: (_ complete: Bool) -> ()) {
        guard let manageContext = appDelegate?.persistentContainer.viewContext else {return};
        
        let fetchRequest = NSFetchRequest<Goals>(entityName: "Goals");
        
        do {
            dataColection = try manageContext.fetch(fetchRequest);
            print("Data detch successfully")
            completion(true);
        } catch {
            debugPrint("can fetch the data \(error.localizedDescription)");
            completion(false);
        }
        
    }
}



