//
//  NotificationsViewController.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 17/11/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {

    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nodataLbl: UILabel!
    @IBOutlet weak var notificationTbleView: UITableView!
    var notificationsArr : [Notifications]?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       // self.notificationTbleView.register(NotificationTableViewCell.self, forCellReuseIdentifier: "notificationCell")
        self.notificationTbleView.tableFooterView = UIView()
        self.notificationTbleView.separatorStyle = .none
        self.notificationTbleView.reloadData()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        let userdefaults = UserDefaults.standard
        if let savedValue = userdefaults.string(forKey: UserDefaultsKeys.guestLogin) {
            if  savedValue == UserDefaultsKeys.guestLogin {
                self.nodataLbl.isHidden = false
                let storyboard = UIStoryboard(name: "CustomAlertVC", bundle: nil)
                let alertVC = storyboard.instantiateViewController(withIdentifier: "CAVC") as! CustomAlertViewController
               // alertVC.customAlertDelegate = self
                alertVC.message = "Please Sign up to access the notifications"
                alertVC.modalPresentationStyle = .custom
                present(alertVC, animated: false, completion: nil)
                self.notificationTbleView.isHidden = true
            }else {
                self.notificationTbleView.isHidden = false
                self.getMyNotifications()
            }
        }
        
        
    }
    func reloadPrograms() {
        self.notificationTbleView.reloadData()
        self.tblHeightConstraint.constant = CGFloat((self.notificationsArr?.count ?? 0) * 85 + 40)
    }
    func getMyNotifications() {
        LoadingOverlay.shared.showOverlay(view: self.view)
        let token = UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken)
               var authenticatedHeaders: [String: String] {
                   [
                       HeadersKeys.authorization: "\(HeaderValues.token) \(token!) ",
                       HeadersKeys.contentType: HeaderValues.json
                   ]
               }
               if let id = UserDefaults.standard.string(forKey: UserDefaultsKeys.subId) {
                                            ProgramDetails.programDetails.subId = id
                                        }
        NotificationsAPI.getNotifications(header:authenticatedHeaders){[weak self] (notifications) in
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
                if notifications?.count ?? 0 > 0 {
                    self?.nodataLbl.isHidden = true
                    self?.notificationsArr = notifications
                    self?.reloadPrograms()
                }else {
                    self?.notificationsArr = nil
                    self?.reloadPrograms()
                    self?.nodataLbl.isHidden = false
                }
            }
            
        } errorHandler: { (error) in
            DispatchQueue.main.async {
            LoadingOverlay.shared.hideOverlayView()
                self.presentAlertWithTitle(title: "Error", message:"\(error.errorDescription)", options: "OK") {[weak self] (_) in
                    self?.notificationsArr = nil
                    self?.reloadPrograms()
                    self?.nodataLbl.isHidden = true
            }
            }
        }
    }

}
extension NotificationsViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 85
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notificationsArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"notificationCell")
            as? NotificationTableViewCell
            else {
                return UITableViewCell()
        }
        let imageURl = self.notificationsArr?[indexPath.row].imgPath
        if imageURl != nil && imageURl?.count ?? 0 > 0 {
            cell.imgView.sd_setImage(with: URL(string:imageURl!)!, placeholderImage: UIImage(named: "chest"))
        }
        cell.nameLbl.text = self.notificationsArr?[indexPath.row].notificationHeader ?? ""
        cell.detailLbl.text = self.notificationsArr?[indexPath.row].message ?? ""
        return cell
    }
}

