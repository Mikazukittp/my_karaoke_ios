//
//  BaseFetcher.swift
//  My Karaoke
//
//  Created by 石部達也 on 2015/07/21.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import UIKit

class BaseFetcher: NSObject {
  
    func sendAsynchronousByUrl(request :NSURLRequest ,completion:(items :NSDictionary)->Void) {
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                println(error)
            } else {                
                let json:NSDictionary = (NSJSONSerialization.JSONObjectWithData(data,
                    options: NSJSONReadingOptions.AllowFragments, error: nil) as? NSDictionary)!
                println(json)
                completion(items: json)
            }
        })
        
        dataTask.resume()
    }
    
}

