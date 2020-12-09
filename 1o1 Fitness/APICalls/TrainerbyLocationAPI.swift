//
//  TrainerbyLocationAPI.swift
//  1O1 Fitness
//
//  Created by Mounika.x.muduganti on 07/01/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import Foundation


final class TrainerbyLocationAPI: API
{
    static func post(parameters: Dictionary<String, Any>,header:[String: String],
                     successHandler: @escaping ([TrainerInfo]) -> Void,
                     errorHandler: @escaping (APIError) -> Void) {
        let longitude = parameters["longitude"] as! String
        let latitude = parameters["latitude"] as! String
        let urlString =  getTrainerByLocation + "longitude=" + longitude + "&latitude=" + latitude + "&details=partial"
        let parameters = parameters as [String: Any]
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
                                    let trainerInfo = try JSONDecoder().decode([TrainerInfo].self, from: jsonData)
                                    successHandler(trainerInfo)
                                }else {
                                   successHandler([])
                                }
                                
                            } else {
                                successHandler([])
                            }
                        } }catch let error {
                            errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
                        }
                        
        }, errorHandler: { error in
            errorHandler(error)
        })

    }
}
final class GetTrainersAPI: API
{
    static func post(parameters: Dictionary<String, Any>,header:[String: String],
                     successHandler: @escaping ([TrainerInfo]) -> Void,
                     errorHandler: @escaping (APIError) -> Void) {
        let urlString =  getAllTrainers
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
                                                                   let trainerInfo = try JSONDecoder().decode([TrainerInfo].self, from: jsonData)
                                                                   successHandler(trainerInfo)
                                }else {
                                    successHandler([])
                                }
                               
                            } else {
                                successHandler([])
                            }
                        } }catch let error {
                            errorHandler(APIError.invalidResponse(ErrorMessage("error.parsing")))
                        }
                        
        }, errorHandler: { error in
            errorHandler(error)
        })

    }
}
final class GetLocationsAPI: API
{
    static func getCountries(header:[String: String],
                     successHandler: @escaping ([CountriesInfo]?) -> Void,
                     errorHandler: @escaping (APIError) -> Void) {
        let urlString =  getCountriesList
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
                                                                   let countries = try JSONDecoder().decode([CountriesInfo].self, from: jsonData)
                                                                   successHandler(countries)
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
    static func getStates(countriesID:String ,header:[String: String],
                        successHandler: @escaping ([StatesInfo]?) -> Void,
                        errorHandler: @escaping (APIError) -> Void) {
           let urlString =  getCountriesList + "/" + countriesID + "/states"
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
                                                                      let states = try JSONDecoder().decode([StatesInfo].self, from: jsonData)
                                                                      successHandler(states)
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
