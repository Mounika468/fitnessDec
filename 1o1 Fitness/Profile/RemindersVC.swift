//
//  RemindersVC.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 13/07/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class RemindersVC: UIViewController {

    @IBOutlet weak var weightView: CardView!
    @IBOutlet weak var exerciseView: CardView!
    @IBOutlet weak var waterView: CardView!
    @IBOutlet weak var mealView: CardView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Reminders"
        
        let    mealTapGesture = UITapGestureRecognizer()
           mealTapGesture.addTarget(self, action: #selector(self.mealsViewTouched(_:)))
           mealView.addGestureRecognizer(mealTapGesture)
        
        let   waterTapGesture = UITapGestureRecognizer()
          waterTapGesture.addTarget(self, action: #selector(self.waterViewTouched(_:)))
          waterView.addGestureRecognizer(  waterTapGesture)
        let  exerciseTapGesture = UITapGestureRecognizer()
         exerciseTapGesture.addTarget(self, action: #selector(self.exerciseTouched(_:)))
         exerciseView.addGestureRecognizer( exerciseTapGesture)
        let  weightTapGesture = UITapGestureRecognizer()
         weightTapGesture.addTarget(self, action: #selector(self.weightViewTouched(_:)))
        weightView.addGestureRecognizer( weightTapGesture)
    }
    

    
    @objc func weightViewTouched(_ sender: UITapGestureRecognizer) {
        
    }
    
    @objc func exerciseTouched(_ sender: UITapGestureRecognizer) {
        
    }
    
    @objc func waterViewTouched(_ sender: UITapGestureRecognizer) {
        
    }
    
    @objc func mealsViewTouched(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "MealEditViewController", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MealEditViewController")
        self.navigationController?.pushViewController(controller, animated: true)
        
    }

}
