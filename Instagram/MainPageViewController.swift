//
//  MainPageViewController.swift
//  Instagram
//
//  Created by Abraham De Alba on 10/2/18.
//  Copyright © 2018 Abraham De Alba. All rights reserved.
//

import UIKit
import Parse

class MainPageViewController: UIViewController {

    @IBAction func onSignout(_ sender: Any)
    {
        PFUser.logOut()
        _ = PFUser.current()
        self.performSegue(withIdentifier: "LogoutSeg", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
