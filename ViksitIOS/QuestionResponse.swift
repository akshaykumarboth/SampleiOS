//
//  QuestionResponse.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 9/19/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import Foundation

class QuestionResponse {
    var questionId: Int!
    var options: [Int] = []
    var duration: Int! = 0
    
    init() {}
    
    func toJSON() -> [String : Any] {
        var dictionary: [String : Any] = [:]
        
        dictionary["questionId"] = questionId
        dictionary["duration"] = duration
        var optionsDictionary: [Int : Any] = [:]
        /*
        for index in 0...options.count - 1 {
            let option: Int = options[index]
            optionsDictionary[index] = option
        }*/
        dictionary["options"] = options
        
        //var productsDictionary: [Int : Any] = [:]
        /*
        for index in 0...self.products.count - 1 {
            let product: Product = products[index]
            productsDictionary[index] = product.toJSON()
        }*/
        
        //dictionary["product"] = productsDictionary
        
        return dictionary
    }
    
    static func listToJSON(list: [QuestionResponse]) -> String{
        var result: String = ""
        var dictionary: [String : Any] = [:]
        var listDictionary: [[String: Any]] = []
        for index in 0...list.count - 1 {
            let item: QuestionResponse = list[index]
            listDictionary.append(item.toJSON())
        }
        dictionary["response"] = listDictionary
        //s(dictionaryOrArray: listDictionary)
        
        
        //
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: listDictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            //Convert back to string. Usually only do this for debugging
            guard let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) else {
                return "error"
            }
            result = JSONString
            print(JSONString)
        }catch {
            //print(error.description)
        }
        


        //
        return result
    }
    
    static func s(dictionaryOrArray: [[String:Any]]) {
        do {
            
            //Convert to Data
            let jsonData = try JSONSerialization.data(withJSONObject: dictionaryOrArray, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            //Convert back to string. Usually only do this for debugging
            guard let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) else {
                return
            }
            print(JSONString)
            
            //In production, you usually want to try and cast as the root data structure. Here we are casting as a dictionary. If the root object is an array cast as [Any].
            //var json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
            //print(json)
            
            
            
        } catch {
            //print(error.description)
        }
    }
}
