//
//  CategoryFetcher.swift
//  My Karaoke
//
//  Created by 石部達也 on 2015/07/21.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import UIKit

class CategoryFetcher: BaseFetcher {
   
    func list (successBlock :(items :Array<Category>)->Void,
        failedBlock :(error :NSError) ->Void) {
        
            let ud = NSUserDefaults.standardUserDefaults()
            let token = ud.objectForKey(Const.userToken) as? String
            let genderId = ud.objectForKey(Const.genderId) as? Int
            let generationId = ud.objectForKey(Const.generationId) as? Int
            
            var getParam:String = "?generation_id=\(generationId!)&gender_id=\(genderId!)"

            var request = NSMutableURLRequest(URL: NSURL(string: Const.urlDomain + "api/v1/categories" + getParam)!,
                cachePolicy: .UseProtocolCachePolicy,
                timeoutInterval: 10.0)
            request.HTTPMethod = "GET"

            let properties = [NSHTTPCookieOriginURL: Const.urlDomain,
                NSHTTPCookieName: "Token",
                NSHTTPCookieValue: "\(token!)",
                NSHTTPCookiePath : "\\"]
            
            let cookie : NSHTTPCookie = NSHTTPCookie(properties: properties)!
            let cookies = [cookie]
            let headers = NSHTTPCookie.requestHeaderFieldsWithCookies(cookies)

            self.sendAsynchronousByUrl(request) { (items) -> Void in
                
                let array = items as? NSArray
                var categories = [Category]()

                for anItem in array! {
                    let dict = anItem as? NSDictionary
                    let id = anItem.objectForKey("id") as? Int
                    let name = anItem.objectForKey("name") as? String
                    let decription = anItem.objectForKey("description") as? String
                    
                    var entity = Category(name: name!,id: id!,description: decription!)
                    categories.append(entity)
                }
 
                successBlock(items: categories)
            }
    }
    
}
