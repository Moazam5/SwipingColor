//
//  GameViewController.swift
//
//  Created by Mir Moazam Abass on 2/8/19.
//  Copyright © 2019 Mir Moazam Abass. All rights reserved.
//

import UIKit

class GameViewController: UIViewController
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
    let colorString = ["Green", "Blue", "Red","Yellow"]   //Colors we will be using, this name is misleading
 //   let colors = [UIColor.green, UIColor.blue, UIColor.red, UIColor.yellow]
    let labelColorRed = [UIColor.green, UIColor.blue, UIColor.red, UIColor.yellow, UIColor.red, UIColor.red]
    let labelColorBlue = [UIColor.green, UIColor.blue, UIColor.red, UIColor.yellow, UIColor.blue, UIColor.blue]
    let labelColorGreen = [UIColor.green, UIColor.blue, UIColor.red, UIColor.yellow, UIColor.green, UIColor.green]
    let labelColorYellow = [UIColor.green, UIColor.blue, UIColor.red, UIColor.yellow, UIColor.yellow, UIColor.yellow]
    var rightColor = false
    var timerTime : Int = 0
    var totalSwipes = 1000
    var swipeCount = 0
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        labelRandomString(stringObjectLabel, colorString)
        print(timerTime)
        if (timerTime > 0 )//&& totalSwipes == 0)
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
        //Check for the sender to be not nil
        guard sender.view != nil else {return}
        //naming sender.view objectView to make the referencing easier
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
           
            // *---> find a better way for this; look into views and how they interact
            
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
    

    // Assigns random position to the view
    
    func randomPosition(_ imageView : UIView)
    {
        imageView.center = CGPoint(x: Double.random(in: 170...240), y: Double.random(in: 100...650))
    }
    
    
    
    func  labelRandomString(_ givenLabel : UILabel,_ givenArray: [String])
   {
        //Assign a random text to the label
        givenLabel.text = givenArray.randomElement()!
    
    //next line is for test ; it works
   // stringObjectLabel.textColor = colors.randomElement()
    
        //Assign a tag as per the color
    
    
        if givenLabel.text == "Blue"
        {
            stringObjectLabel.tag = 1
            stringObjectLabel.textColor = labelColorBlue.randomElement()
        }
      
        else if  givenLabel.text == "Green"
        {
            stringObjectLabel.tag = 2
            stringObjectLabel.textColor = labelColorGreen.randomElement()
        }
        else if givenLabel.text == "Red"
        {
            stringObjectLabel.tag = 3
            stringObjectLabel.textColor = labelColorRed.randomElement()
        }
            else if givenLabel.text == "Yellow"
        {
            stringObjectLabel.tag = 4
            stringObjectLabel.textColor = labelColorYellow.randomElement()
        }
  }
    
    

    /*  MARK:- THE FUNCTION TO CHECK IF THE COLOR IS TAKEN TO THE RIGHT SIDE
 
     Here I have four conditions to check if the word is taken to the right color
     all conditions work the same way
     1. first the if part checks what catefory the position of the frame falls in
     
     2. the second if checks the tag of the label. only if the tag is right the variable
     rightColor is changed from false to true.
     
 */
    
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
        else if (imageView.frame.maxX >= rightBoundry.frame.minX + 20)
        {
            if stringObjectLabel.tag == 4
            {
                rightColor = true
                completeSwipes()
            }
        }
    }
    
    //Timer Function;
    //*---> Improve this by makig it take desired time as input
    
    func time()
    {
        let timer = Timer.scheduledTimer(withTimeInterval: Double(timerTime), repeats: true, block: { timer in

            self.alert("End of Activity", "You may pass the phone to the proctor")
            
        })
    }
    
    //Checks if the swipeCount(which starts at 0) has reached the desired value;
    // if not then adds 1 to swipeCount
    // if yes, make it zero and end activity
    
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
    
    //Alert Function
    
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

