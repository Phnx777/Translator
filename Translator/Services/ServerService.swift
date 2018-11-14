//
//  ServerService.swift
//  Translator
//
//  Created by Имал Фарук on 12/11/2018.
//  Copyright © 2018 Имал Фарук. All rights reserved.
//

import UIKit

protocol ServerServiceProtocol: class {
    func translate(word: String, fromLang: String, toLang: String,
                   completion: @escaping ([String: Any]?, Error?) -> ())
    func getLanguages(completion: @escaping ([String: Any]?, Error?) -> ())
}

class ServerService: ServerServiceProtocol {
    let apiKey = "trnsl.1.1.20181110T112034Z.d545d1929eb8be17.127dc0adfd245f5050311db77812621ae41833b8"
    let baseUrlStr = "https://translate.yandex.net/api/v1.5/tr.json/"
    
    //MARK: Requests
    
    func translate(word: String, fromLang: String, toLang: String,
                   completion: @escaping ([String : Any]?, Error?) -> ()) {
        sendRequest(url: baseUrlStr + "translate", httpMethod: "POST",
                body: ["key": apiKey, "text" : word, "lang" : fromLang + "-" + toLang],
                completion: completion)
    }
    
    func getLanguages(completion: @escaping ([String: Any]?, Error?) -> ()) {
        sendRequest(url: baseUrlStr + "getLangs", httpMethod: "GET",
                    body: ["key": apiKey, "ui" : "ru"], completion: completion)
    }
    
}

extension ServerService {
    //MARK: Methods for sending requests
    private func sendRequest(url: String, httpMethod: String, body : [String : Any],
                             completion: @escaping ([String: Any]?, Error?) -> ()) {
        
        let components = urlComponents(url: url, params: body)
        var request = URLRequest(url: components.url!)
        request.httpMethod = httpMethod
        
        URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            
            if error != nil {
                print("Error to load: \(String(describing: error?.localizedDescription))")
                completion(nil, error)
                return
            }
            
            if let dataResponse = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: dataResponse, options: []) as! [String: AnyObject]
                    
                    print("json: \(json), error: \(String(describing: error))")
                    completion(json, nil)
                    return
                    
                } catch let error as NSError {
                    
                    print("Failed to load: \(error.localizedDescription)")
                    completion(nil, error)
                }
            }
            }.resume()
    }
    
    func urlComponents(url : String, params: [String : Any]) -> NSURLComponents {
        let components = NSURLComponents(string: url)
        var items = [URLQueryItem]()
        for (key, value) in params {
            items.append(URLQueryItem(name: key, value: value as? String))
        }
        items = items.filter{!$0.name.isEmpty}
        if !items.isEmpty {
            components?.queryItems = items
        }
        return components!
    }
}
