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
    
    @IBOutlet weak var stringObjectLabel: UILabel!
    
    //MARK:- Variables
    
    var initialCenter = CGPoint()  // The initial center point of the view.
    let colorString = ["Green", "Blue"]   //Colors we will be using
    
    
    
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
                || objectView.frame.maxY >= bottomBoundry.frame.minY + 10
            {
                randomPosition(objectView)
                labelRandomString(stringObjectLabel, colorString)
                objectView.removeFromSuperview()
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
        imageView.center = CGPoint(x: Double.random(in: 120...200), y: Double.random(in: 200...650))
    }
    
    func  labelRandomString(_ givenLabel : UILabel,_ givenArray: [String])
   {
    givenLabel.text = givenArray.randomElement()!
    givenLabel.textColor = UIColor.blue
    }
  
}

