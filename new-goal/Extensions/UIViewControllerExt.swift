//
//  UIViewControllerExt.swift
//  goalpost-app
//
//  Created by Mark Rady on 2/12/18.
//  Copyright © 2018 Mark Rady. All rights reserved.
//

import UIKit;

extension UIViewController {
    
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transation = CATransition();
        transation.duration = 0.3;
        
        transation.type = kCATransitionPush;
        
        transation.subtype = kCATransitionFromRight;
        
        self.view.window?.layer.add(transation, forKey: kCATransition);
        
        present(viewControllerToPresent, animated: false, completion: nil);
        
    }
    
    func dismissDetail() {
        let transation = CATransition();
        transation.duration = 0.3;
        
        transation.type = kCATransitionPush;
        
        transation.subtype = kCATransitionFromLeft;
        
        self.view.window?.layer.add(transation, forKey: kCATransition);
        
        dismiss( animated: false, completion: nil);
    }
}
