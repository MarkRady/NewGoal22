//
//  GoalsVC.swift
//  goalpost-app
//
//  Created by Mark Rady on 2/11/18.
//  Copyright © 2018 Mark Rady. All rights reserved.
//

import UIKit;
import CoreData;

protocol ProcessStatusDelegate:NSObjectProtocol{
    func updateProcessStatus(isCompleted : Bool)
}

class GoalsVC: UIViewController, ProcessStatusDelegate {
    
    
    func updateProcessStatus(isCompleted: Bool) {
        print("updateProcessStatus ")
        coreDataFetcher();
        tableView.reloadData();
    
    }
    

    var dataColection: [Goals] = [];
    var delegate:ProcessStatusDelegate?

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.isHidden = false;
//        view.insetsLayoutMarginsFromSafeArea = true

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        print("viewWillAppear")
        coreDataFetcher();
        tableView.reloadData(); 
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear");
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
    
    

    
    @IBAction func createBtnPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") as? CreateGoalVC else { return };
        createGoalVC.delegate = self
        self.navigationController?.pushViewController(createGoalVC, animated: true)

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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none;
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction =  UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath);
            self.coreDataFetcher();
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1);

        let progressAction =  UITableViewRowAction(style: .normal, title: "+") { (rowAction, indexPath) in
            self.increaseProgress(atIndexPath: indexPath);
            tableView.reloadRows(at: [indexPath], with: .automatic);

        }
        progressAction.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1);

        
        
        return [deleteAction,progressAction];

    }
}


extension GoalsVC {
    
    func increaseProgress(atIndexPath indexPath: IndexPath) {
        guard let manageContext = appDelegate?.persistentContainer.viewContext else {return};
        
        let selectGoal = dataColection[indexPath.row];
        
        if selectGoal.goalProgress < selectGoal.goalTarget {
            selectGoal.goalProgress = selectGoal.goalProgress + 1;
        }else {
            return;
        }
        
        do {
            try manageContext.save();
            print("progress updated");
        } catch {
            debugPrint("Could not update goal progress \(error.localizedDescription)");
        }
    }
    
    func removeGoal(atIndexPath indexPath: IndexPath) {
        guard let manageContext = appDelegate?.persistentContainer.viewContext else {return};
        
        manageContext.delete(dataColection[indexPath.row]);
        
        do {
            try manageContext.save();
            print("item remove successfully");
        } catch {
            debugPrint("Could delete item \(error.localizedDescription)");
        }
        
    }
    
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
    
    func coreDataFetcher() {
        self.fetch { (complete) in
            if  complete {
                if dataColection.count > 0 {
                    tableView.isHidden = false;
                    
                } else {
                    tableView.isHidden = true;
                }
            }
            
        }
    }
}



