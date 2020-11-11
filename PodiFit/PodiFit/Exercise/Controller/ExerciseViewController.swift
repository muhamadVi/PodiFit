//
//  ExerciseViewController.swift
//  PodiFit
//
//  Created by Muhamad Vicky on 23/10/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import UIKit
import WebKit
import CoreData

class ExerciseViewController: UIViewController {

    @IBOutlet weak var exerciseView : ExerciseView!
    @IBOutlet weak var circularProgressView : CircularProgressView!

    var count = 30
    var countTimeAddition = 20
    var timer: Timer?
    var isVideo: Int = 2
    var countChosenExercise = 3
    var finishExercise = 1
    
    //reference to moc
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
//        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
//           self.navigationController!.navigationBar.shadowImage = UIImage()
//        self.navigationController!.navigationBar.isTranslucent = true
        // Setup View
        circularProgressView.trackClr = UIColor(red: 95/255, green: 104/255, blue: 71/255, alpha: 100)
        circularProgressView.progressClr = UIColor.init(red: 228/255, green: 246/255, blue: 80/255, alpha: 100)
        exerciseView.videoView()
        
        // get exercise from core data
//        fetchPlan()
    }
    
    @IBAction func didTap(_ sender: Any) {

        //create alert
        let alert = UIAlertController(title: "Add Exercise", message: "What do you want to choose", preferredStyle: .alert)
        alert.addTextField()
        
        // configure button handler
        let submitButton = UIAlertAction(title: "Add", style: .default) { (action) in
            //get the textfield for the alert
            let textfield = alert.textFields![0]
            
            //create a exercise object
            let newPlan = Exercise(context: self.context)
            newPlan.idDifficulty = 1
            newPlan.idExercise = 1
            newPlan.listIdSteps = [2,3,4]
            newPlan.namaExercise = textfield.text
            newPlan.videoUrl = "https://www.youtube.com/embed/xXRU28mfIJQ?playsinline=1"
            newPlan.warningData = 3
            
            
            let step = ExerciseSteps(context: self.context)
            step.idStep = 2
            step.steps = "bangun bro"
            
            let step1 = ExerciseSteps(context: self.context)
            step1.idStep = 3
            step1.steps = "jongkok lagi bro"
            
            let step2 = ExerciseSteps(context: self.context)
            step2.idStep = 4
            step2.steps = "baru tidur"
            
            newPlan.steps = NSSet.init(array: [step, step1, step2])
            
            
//
            
            
//            newPlan.chosenExercise = [1,3,5,6]
//            newPlan.durasiPlan = 60
//            newPlan.durasiSession = 30
//            newPlan.idDifficulty = 3
//            newPlan.idPlan = 2
//            newPlan.namaPlan = textfield.text
//
            
            // save the data
            do {
                try self.context.save()
                
            }
            catch {
                
            }
            
            // re-fetch
//            self.fetchPlan()
        }
        
        // add button
        alert.addAction(submitButton)
        
        // show alert
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func informationExercise(_ sender: Any) {
        self.performSegue(withIdentifier: "toInformationExercise", sender: nil)
    }
    
    @IBAction func previous(_ sender: Any) {
        var countProgress = Double((Double(finishExercise) / Double(countChosenExercise)))
        print("ini \(countProgress)")
        print("angka dari \(finishExercise), \(countChosenExercise)")

        if finishExercise == countChosenExercise {
            exerciseView.lastExercise()
        } else {
            if ((isVideo % 2) != 0) {
                timer?.invalidate()
                exerciseView.countDownView(count: "30")
                circularProgressView.setProgressWithAnimation(duration: 1.0, value: 0.50)
                exerciseView.videoView()
                isVideo += 1
            } else {
                exerciseView.restView()
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownTimer), userInfo: nil, repeats: true)
                isVideo += 1
            }
            finishExercise -= 1
        }
    }
    
    @IBAction func next(_ sender: Any) {
        var countProgress = Float((Float(finishExercise) / Float(countChosenExercise)))
        circularProgressView.setProgressWithAnimation(duration: 1.0, value: countProgress)
        exerciseView.setProgressNumber(number: finishExercise, totalExercise: countChosenExercise)
        if finishExercise == countChosenExercise {
            exerciseView.lastExercise()
        } else {
//            print("harusnya masuk\(finishExercise), \(isVideo)")
            if ((isVideo % 2) != 1) {
                exerciseView.restView()
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownTimer), userInfo: nil, repeats: true)
                isVideo += 1
            }
            finishExercise += 1
        }
    }
    
    @IBAction func doneExercise(_ sender: Any) {
        self.performSegue(withIdentifier: "toSummary", sender: nil)
    }
    
    @IBAction func Skip(_ sender: Any) {
        
        timer?.invalidate()
        exerciseView.countDownView(count: "30")
        exerciseView.videoView()
        isVideo += 1
    }
    
    @IBAction func addTimeRest(_ sender: Any) {
        timer?.invalidate()
        exerciseView.countDownView(count: "5")
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(additionTime), userInfo: nil, repeats: true)
        countTimeAddition = 5
    }
    
    @IBAction func exit(_ sender: Any) {
        timer?.invalidate()
        self.performSegue(withIdentifier: "tocoba", sender: nil)
        
    
    }
    
    @objc func countDownTimer(){
        var countString = String(count)
    
        if (count >= 0) {
            if count >= 10 {
                exerciseView.countDownView(count: countString)
                
                count -= 1
                print(countString)
            } else {
                countString = "0\(countString)"
                exerciseView.countDownView(count: countString)
                count -= 1
            }
        }
    }
    
    @objc func additionTime(){
        var countStringAdd = String(countTimeAddition)
        
        if (countTimeAddition >= 0) {
            if countTimeAddition >= 10 {
                exerciseView.countDownView(count: countStringAdd)
                
                countTimeAddition -= 1
                print(countStringAdd)
            } else {
                countStringAdd = "0\(countStringAdd)"
                exerciseView.countDownView(count: countStringAdd)
                countTimeAddition -= 1
            }
        }

        
    }
    
}
