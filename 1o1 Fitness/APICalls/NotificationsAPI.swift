//
//  NotificationsAPI.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 02/12/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation
final class NotificationsAPI: API
{
    static func getNotifications(header:[String: String],
                        successHandler: @escaping ([Notifications]?) -> Void,
                        errorHandler: @escaping (APIError) -> Void) {
           
           let urlString =  String(format: "%@%@?pagesize=25&pagenumber=0&selection=false&requestedBy=Trainee", getNotificationsAPI,UserDefaults.standard.string(forKey: UserDefaultsKeys.subId)!)
           let request = APIRequest(method: .get, url: urlString, parameters: nil, headers: header, dataParams: nil)
        sendAPIRequest(request,
                       successHandler: { (json: JSON) in
                        do {
                             if json[ResponseKeys.data.rawValue] != nil
                             {
                            if  let jsonDict = json[ResponseKeys.data.rawValue]   {
                                if jsonDict != nil {
                                    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict as Any,
                                                                              options: .prettyPrinted)
                                    let notifications = try JSONDecoder().decode([Notifications].self, from: jsonData)
                                    successHandler(notifications)
                                }else {
                                   successHandler(nil)
                                }
                                
                            } else {
                                successHandler(nil)
                            }
                        } }catch let error {
                            errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
                        }
                        
        }, errorHandler: { error in
            errorHandler(error)
        })
       }
}
