
//  HomeProfileViewController.swift
//  PodiFit
//
//  Created by Nathanael Adolf Sukiman on 22/10/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import UIKit
import UserNotifications

var userHelper = UserBasicDataHelper()
var planHelper = PlanHelper()
var difficultyHelper = DifficultyHelper()
var badgesHelper = BadgesHelper()

protocol HomeProfileDelegate {
    func nextDidTap()
}

struct AppUtility {

    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
    
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }

    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
   
        self.lockOrientation(orientation)
    
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }

}

class HomeProfileViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var completedData = [CompletedPlanModel]()
    var reminderData = [ReminderModel]()
    var tempDataToEdit = [ReminderModel]()
    var userData = [UserDataModel]()
    
    var addButton = UIButton()
    
    var counter: Int = 0
    
    var reminderNameArray: [String] = []
    var badgesImageArray: [String] = []
    
    var swipeState: String = ""
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return 5 nanti bikin jadi 5 setelah semua cellnya jadi
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        else if section == 1{
            return 1
        }
        else if section == 2
        {
            return 1
        }
        else if section == 3
        {
            return (reminderData.count == 0) ? 1 : reminderData.count
        }
        else if section == 4
        {
            return 1
        }
        else
        {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return 170
        }
        else if indexPath.section == 1
        {
            return 110
        }
        else if indexPath.section == 2
        {
            return (completedData.count == 0) ? 48 : 210
        }
        else if indexPath.section == 3
        {
            return (reminderData.count == 0) ? 48 : 90
        }
        else if indexPath.section == 4
        {
            return 110
        }
        else
        {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imagePersonCell", for: indexPath) as! imagePersonTableViewCell
            
            cell.persomImage.image = UIImage(data: userData[indexPath.row].img)
            cell.persomImage.layer.cornerRadius = 20
            
            if userData.count != 0 {
                cell.userName.text = userData[indexPath.row].Name
            }
            
            cell.backgroundColor = .none
            cell.contentView.backgroundColor = .none
            
            cell.buttonProtocol = self
            
            return cell
        }
        else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userDataCell", for: indexPath) as! userDataTableViewCell
            
            
            if userData.count != 0 {
                cell.numberOfActivePlansLabel.text = String(userData[indexPath.row].userIdPlan!.count)
                cell.numberWeightLabel.text = String(userData[indexPath.row].weight)
                cell.heightLabel.text = String(userData[indexPath.row].height)
            }
            
            
            return cell
            
            
        }
        else if indexPath.section == 2
        {
            if completedData.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell", for: indexPath) as! NoDataTableViewCell
                cell.emptyMessageLabel.text = "You have no completed plan"
                
                return cell
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "completedPlanCell", for: indexPath) as! CompletedPlanTableViewCell
                
                cell.loadCollectionView(data: completedData)
                
                return cell
            }
            
        }
        else if indexPath.section == 3
        {
            if reminderData.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell", for: indexPath) as! NoDataTableViewCell
                cell.emptyMessageLabel.text = "No Reminder"
                
                return cell
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath) as! ReminderTableViewCell
                
                cell.hourLabel.text = reminderData[indexPath.row].Hour
                cell.reminderNameLabel.text = reminderData[indexPath.row].reminderName
                
                if reminderData[indexPath.row].isMon == true {
                    cell.mondayLabel.textColor = .white
                }
                else
                {
                    cell.mondayLabel.textColor = .gray
                }
                
                if reminderData[indexPath.row].isTue == true {
                    cell.TuesdayLabel.textColor = .white
                }
                else
                {
                    cell.TuesdayLabel.textColor = .gray
                }
                if reminderData[indexPath.row].isWed == true {
                    cell.wednesdayLabel.textColor = .white
                }
                else
                {
                    cell.wednesdayLabel.textColor = .gray
                }
                if reminderData[indexPath.row].isThu == true {
                    cell.thursdayLabel.textColor = .white
                }
                else
                {
                    cell.thursdayLabel.textColor = .gray
                }
                if reminderData[indexPath.row].isFri == true {
                    cell.fridayLabel.textColor = .white
                }
                else
                {
                    cell.fridayLabel.textColor = .gray
                }
                if reminderData[indexPath.row].isSat == true {
                    cell.saturdayLabel.textColor = .white
                }
                else
                {
                    cell.saturdayLabel.textColor = .gray
                }
                if reminderData[indexPath.row].isSun == true {
                    cell.sundayLabel.textColor = .white
                }
                else
                {
                    cell.sundayLabel.textColor = .gray
                }
                
                if reminderData[indexPath.row].isReminderActive == true {
                    cell.reminderSwitch.setOn(true, animated: false)
                }
                else
                {
                    cell.reminderSwitch.setOn(false, animated: false)
                }
                
                return cell
            }
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "badgesCell", for: indexPath) as! BadgesTableViewCell
            
            cell.loadCollectionView(data: badgesImageArray)
            
            return cell
        }
    
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0
        {
            return nil
        }
        else if section == 1
        {
            return nil
        }
        else if section == 2 {
            return "Completed Plan"
        }
        else if section == 3
        {
            return "Reminder"
        }
        else if section == 4
        {
            return "badges"
        }
        else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 || section == 1
        {
            return nil
        }
        
        if section == 2 || section == 3 || section == 4
        {
            let headerView = UIView()
            headerView.backgroundColor = .none
            
            let sectionLabel = UILabel(frame: CGRect(x: 20, y: 10, width:
                                                        tableView.bounds.size.width, height: tableView.bounds.size.height))
            sectionLabel.font = UIFont(name: "Helvetica", size: 20)
            sectionLabel.font = UIFont.boldSystemFont(ofSize: 20)
            sectionLabel.textColor = UIColor.white
            
            addButton = UIButton(frame: CGRect(x: tableView.frame.size.width - 100, y: 6, width:
                                                80, height: 33))
            addButton.titleLabel?.textColor = .gray
            
            if section == 2 {
                sectionLabel.text = "Completed Plan"
                addButton.setTitle("History", for: .normal)
                addButton.setTitleColor(.lightGray, for: .normal)
                
                addButton.addTarget(self, action: #selector(completeButtonPressed), for: .touchUpInside)
            }
            if section == 3
            {
                addButton.setTitle("Add new", for: .normal)
                addButton.setTitleColor(.lightGray, for: .normal)
                swipeState = ""
                addButton.addTarget(self, action: #selector(reminderButtonPressed), for: .touchUpInside)
                sectionLabel.text = "Reminder"
            }
            if section == 4 {
                addButton.setTitle("See more", for: .normal)
                addButton.setTitleColor(.lightGray, for: .normal)
                swipeState = ""
                addButton.addTarget(self, action: #selector(badgesButtonPressed), for: .touchUpInside)
                sectionLabel.text = "Badges"
            }
            
            sectionLabel.sizeToFit()
            
            headerView.addSubview(sectionLabel)
            headerView.addSubview(addButton)
            
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        if indexPath.section == 3
        {
            self.tempDataToEdit = []
            let edit = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, actionPerformed: (Bool)-> ()) in
                
                self.tempDataToEdit.append(ReminderModel(Hour: self.reminderData[indexPath.row].Hour, remindName: self.reminderData[indexPath.row].reminderName, isMon: self.reminderData[indexPath.row].isMon, isTue: self.reminderData[indexPath.row].isTue, isWed: self.reminderData[indexPath.row].isWed, isThu: self.reminderData[indexPath.row].isThu, isFri: self.reminderData[indexPath.row].isFri, isSat: self.reminderData[indexPath.row].isSat, isSun: self.reminderData[indexPath.row].isSun, isReminderActive: self.reminderData[indexPath.row].isReminderActive))
                
                self.performSegue(withIdentifier: "toEditReminder", sender:nil)
                actionPerformed(true)
                
            }
            
            let delete = UIContextualAction(style: .normal, title: "Delete") { (contextualAction, view, actionPerformed: (Bool)-> ()) in
                self.counter = 0
                
                if self.reminderData[indexPath.row].isMon == true
                {
                    self.counter += 1
                }
                if self.reminderData[indexPath.row].isTue == true
                {
                    self.counter += 1
                }
                if self.reminderData[indexPath.row].isWed == true
                {
                    self.counter += 1
                }
                if self.reminderData[indexPath.row].isThu == true
                {
                    self.counter += 1
                }
                if self.reminderData[indexPath.row].isFri == true
                {
                    self.counter += 1
                }
                if self.reminderData[indexPath.row].isSat == true
                {
                    self.counter += 1
                }
                if self.reminderData[indexPath.row].isSun == true
                {
                    self.counter += 1
                }
                
                for i in 0...self.counter - 1
                {
                    self.reminderNameArray.append("\(self.reminderData[indexPath.row].reminderName!)\(i)")
                }
                
                for _ in 0...self.reminderNameArray.count - 1
                {
                    notifHelper.notificationCenter.removeDeliveredNotifications(withIdentifiers: self.reminderNameArray)
                    notifHelper.notificationCenter.removePendingNotificationRequests(withIdentifiers: self.reminderNameArray)
                    
                }
                
                notifHelper.deleteDataInReminder(uniqueReminderName: self.reminderData[indexPath.row].reminderName)
                self.reminderData.remove(at: indexPath.row)
                self.completeRemindBadgeTableView.reloadData()
                
                actionPerformed(true)
            }
            
            edit.backgroundColor = UIColor.init(red: 191/255, green: 210/255, blue: 34/255, alpha: 1)
            delete.backgroundColor = UIColor.red
            
            return UISwipeActionsConfiguration(actions: [delete,edit])
            
        }
        return nil
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toEditReminder"
        {
            if let destination = segue.destination as? AddReminderViewController
            {
                destination.pageState = "Edit"
                destination.tempDataEdit = self.tempDataToEdit
                destination.delegate = self
            }
        }
        if segue.identifier == "toAddReminder"
        {
            if let destination = segue.destination as? AddReminderViewController
            {
                destination.pageState = "Create"
                destination.delegate = self
            }
        }
        if segue.identifier == "toEditProfile" {
            if let destination = segue.destination as? EditProfileViewController
            {
                destination.tempDataToEdit = self.userData
            }
        }
        if segue.identifier == "toCompletedHistory" {
            if let destination = segue.destination as? CompletedPlanDetailsViewController
            {
                destination.tempPlanData = completedData
            }
        }
        
    }
    
    @objc func completeButtonPressed()
    {
        print("pressed complete button")
        performSegue(withIdentifier: "toCompletedHistory", sender: self)
    }
    @objc func reminderButtonPressed()
    {
        print("pressed reminder button")
        performSegue(withIdentifier: "toAddReminder", sender: self)
    }
    @objc func badgesButtonPressed()
    {
        performSegue(withIdentifier: "toDetailBadgesSegue", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        reminderData = notifHelper.retrieveNotificationFromCoreData()
    
        if badgesHelper.isBadgesTableEmpty() == true {
            badgesHelper.storeToBadgesData(id: 1, complete5Plan: false, completePlan: false, customExercise: false, exerciseAddict: false, exerciseMaster: false, firstTimeBadge: false, reminderBadge: false)
        }
       // planHelper.updatePlanIntoDone(planNameToUpdate: "Beginner Leg", isPlanDone: true)
        
        badgesHelper.checkUserEarnBadge()
        badgesImageArray = badgesHelper.retreiveDataFromBadges().imageData
        badgesHelper.retreiveDataFromBadges()
        
        if userHelper.isUserTableEmpty() == false {
            userData = userHelper.retrieveUserBasicData()
        }
        
        if userHelper.isUserTableEmpty() == false && planHelper.isPlanTableEmpty() == false && difficultyHelper.isDifficultyTableEmpty() == false {
            completedData = planHelper.retrieveCompletedPlanData().tempModel
            //completedData.append(CompletedPlanModel(titleMovement: "Intermediate", level: "Medium", period: 3, movement: 6))
        }
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
        self.swipeState = ""
        
        AppUtility.lockOrientation(.portrait)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //AppUtility.lockOrientation(.all)
    }
    @IBAction func unwindSegueFromAddReminder(sender: UIStoryboardSegue){
    
    }
    
    @IBAction func unwindSegueFromEditProfile(sender: UIStoryboardSegue){
        self.userData = userHelper.retrieveUserBasicData()
        
        completeRemindBadgeTableView.reloadData()
    }
    
    @IBOutlet weak var completeRemindBadgeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        completeRemindBadgeTableView.delegate = self
        completeRemindBadgeTableView.dataSource = self
        
        completeRemindBadgeTableView.separatorStyle = .none
        
        self.view.backgroundColor = Colors.backgroundBaseColor
        self.completeRemindBadgeTableView.backgroundColor = .none
        
        notifHelper.configureUserNotificationCenter()
            
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        hideKeyboardWhenTappedAround()
    }
        
}

extension HomeProfileViewController: editButtonProtocol
{
    func moveToEditPage() {
        performSegue(withIdentifier: "toEditProfile", sender: self)
    }
}

extension UIViewController
{
    
    func hideKeyboardWhenTappedAround()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.endEditingKeyboard))
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
    }
    
    @objc func endEditingKeyboard()
    {
        view.endEditing(true)
    }
}

extension HomeProfileViewController: HomeProfileDelegate {
    func nextDidTap() {
        self.reminderData = notifHelper.retrieveNotificationFromCoreData()
        badgesHelper.checkUserEarnBadge()
        self.badgesImageArray = badgesHelper.retreiveDataFromBadges().imageData
        self.completeRemindBadgeTableView.reloadData()
    }
}
