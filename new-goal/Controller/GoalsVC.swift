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

    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.isHidden = false;
        
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
        return 4;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                                                    //"goalCell" is identifir pass to cell in view
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell
        else {
            return UITableViewCell();
                
        }
        
        cell.configureCell(description: "Eat salad", type: .longTerm, progress: 2);
        return cell;
    }
    
}
