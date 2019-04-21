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
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        labelRandomString(stringObjectLabel, colorString)
        
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
            }
        }
        else if (imageView.frame.maxY >= bottomBoundry.frame.minY + 10)
        {
            if stringObjectLabel.tag == 2
            {
                
                rightColor = true
            }        }
        else if (imageView.frame.minX <= leftBoundry.frame.maxX - 10)
        {
            if stringObjectLabel.tag == 3
            {
                
                rightColor = true
            }
            
        }
        else if (imageView.frame.maxX >= rightBoundry.frame.minX + 10)
        {
            if stringObjectLabel.tag == 4
            {
                
                rightColor = true
            }
            
        }
        

    }
}

