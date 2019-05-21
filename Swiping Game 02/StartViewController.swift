
//  StartActivityViewController.swift
//  Swiping Game 02
//
//  Created by mozz on 5/2/19.
//  Copyright © 2019 Mir Moazam Abass. All rights reserved.
//this one
//

import UIKit

class StartActivityViewController: UIViewController {

    @IBOutlet var timeTextField: UITextField!
    @IBOutlet var swipeTextField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "forTime"
        {
          
                let destinationVC = segue.destination as! ViewController
                destinationVC.timerTime = Int(timeTextField.text!)!
            }
        
            
        else if segue.identifier == "forSwipes"
        {
                let destinationVC = segue.destination as! ViewController
                destinationVC.totalSwipes = Int(swipeTextField.text!)!
            }
        
    }
    
    @IBAction func timeButton(_ sender: Any) {
        //    let timeEntered = Int(timeTextField.text!)!
            if let timeEntered = Int(self.timeTextField.text!)
            {
                if (timeEntered  <= 0 )
                {
                    self.alert("Wrong Input", "The entered number must be a positive number")
                }
                else
                {
                    performSegue(withIdentifier: "forTime", sender: self)
                }
            }else {return}
        }
    
    @IBAction func swipesButton(_ sender: Any)
    {
        if  let swipesEnterd = Int(swipeTextField.text!){
        if swipesEnterd <= 0
        {
            self.alert("Wrong Input", "The entered number must be a positive number")
        }
        else
        {
            performSegue(withIdentifier: "forSwipes", sender: self)
        }
        }
        else {return}
    }
    

    func alert(_ givenTile : String, _ givenMessage : String)
    {
        let alert = UIAlertController(title: givenTile, message: givenMessage, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            
        }
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
        
    }
}
