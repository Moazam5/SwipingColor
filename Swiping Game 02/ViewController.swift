//
//  ViewController.swift
//  Swiping Game 02
//
//  Created by Mir Moazam Abass on 2/8/19.
//  Copyright © 2019 Mir Moazam Abass. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
  
    
    //MARK:- Connections
    @IBOutlet weak var topBoundry: UIView!
    @IBOutlet weak var bottomBoundry: UIView!
    @IBOutlet weak var stringObjectView: UIView!
    @IBOutlet var leftBoundry: UIView!
    @IBOutlet var rightBoundry: UIView!
    
    @IBOutlet weak var stringObjectLabel: UILabel!
    
    //MARK:- Variables
    
    var initialCenter = CGPoint()  // The initial center point of the view.
    let colorString = ["Green", "Blue", "Red","Yellow"]   //Colors we will be using
    var rightColor = false
    var timerTime : Int = 0
    var totalSwipes = 1000
    var swipeCount = 0
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        labelRandomString(stringObjectLabel, colorString)
        
        if (timerTime != 0 && totalSwipes == 0)
        {
            time()
        }
        else if (timerTime == 0 && totalSwipes != 0)
        {
            completeSwipes()
        }
        else
        {
            alert("Alert", "Cant have value in both fields")
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }

    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer)
    {
        guard sender.view != nil else {return}
        let objectView = sender.view!
        
        // Translation  -> Gets the changes in the X and Y directions relative to
        // the superview's coordinate space.

        let translation = sender.translation(in: objectView.superview)

        if sender.state == .began
        {
            // Save the view's original position.
            self.initialCenter = objectView.center
        }
        // Update the position for the .began, .changed, and .ended states
        
        if sender.state != .cancelled
        {
            let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
            objectView.center = newCenter
            
            if objectView.frame.minY  <= topBoundry.frame.maxY - 13
                || objectView.frame.maxY >= bottomBoundry.frame.minY + 10 || objectView.frame.minX <= leftBoundry.frame.maxX - 10 || objectView.frame.maxX >= rightBoundry.frame.minX + 10
            {
                checkColor(imageView: sender.view!)
                if rightColor
                {
                    randomPosition(objectView)
                    labelRandomString(stringObjectLabel, colorString)
                    objectView.removeFromSuperview()

                }
                
            }
            
            if !objectView.isDescendant(of: view)
            {
                view.addSubview(objectView)
            }
        }
        else
        {
            // On cancellation, return the piece to its original location.
            randomPosition(objectView)
        }
        
    }
    

    func randomPosition(_ imageView : UIView)
    {
        imageView.center = CGPoint(x: Double.random(in: 150...230), y: Double.random(in: 200...650))
    }
    
    func  labelRandomString(_ givenLabel : UILabel,_ givenArray: [String])
   {
    givenLabel.text = givenArray.randomElement()!
   // givenLabel.textColor = UIColor.blue
    
    if givenLabel.text == "Red"
    {
        stringObjectLabel.tag = 3
    }
    else if givenLabel.text == "Blue"
    {
        stringObjectLabel.tag = 1

    }
    else if  givenLabel.text == "Green"
    {
        stringObjectLabel.tag = 2

    }
        else if givenLabel.text == "Yellow"
    {
        stringObjectLabel.tag = 4

    }
  
    }
  
    func checkColor(imageView : UIView)
    {
        rightColor = false
        if (imageView.frame.minY  <= topBoundry.frame.maxY - 13)
        {
            if stringObjectLabel.tag == 1
            {
                rightColor = true
                completeSwipes()
            }
        }
        else if (imageView.frame.maxY >= bottomBoundry.frame.minY + 10)
        {
            if stringObjectLabel.tag == 2
            {
                rightColor = true
                completeSwipes()
            }        }
        else if (imageView.frame.minX <= leftBoundry.frame.maxX )
        {
            if stringObjectLabel.tag == 3
            {
                rightColor = true
                completeSwipes()
            }
    }
        else if (imageView.frame.maxX >= rightBoundry.frame.minX + 15)
        {
            if stringObjectLabel.tag == 4
            {
                rightColor = true
                completeSwipes()
            }
        }
    }
    
    
    func time()
    {
        
        let timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(timerTime), repeats: true, block: { timer in
            
            
            
            //            let alert = UIAlertController(title: "Awesome", message: "You've finished the session. Please hand back the device to the proctor", preferredStyle: .alert)
            //
            //            let endAction = UIAlertAction(title: "End", style: .default, handler: { UIAlertAction in
            //
            //            })
            //            alert.addAction(endAction)
            //            self.present(alert, animated: true, completion: nil)
            
            self.alert("End of Activity", "You may pass the phone to the proctor")
            
        //    self.dismiss(animated: true, completion: nil)
            
            
        })
    }
    
    func completeSwipes()
    {
        if swipeCount == totalSwipes
        {
            swipeCount = 0
            self.alert("End of Activity", "You may pass the phone to the proctor")
          //  self.dismiss(animated: true, completion: nil)
        }
        else
        {
            swipeCount += 1
        }
    }
    
    
    func alert(_ givenTile : String, _ givenMessage : String)
    {
        let alert = UIAlertController(title: givenTile, message: givenMessage, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
             self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

