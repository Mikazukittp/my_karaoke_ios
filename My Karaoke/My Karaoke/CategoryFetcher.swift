//
//  CategoryFetcher.swift
//  My Karaoke
//
//  Created by 石部達也 on 2015/07/21.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import UIKit

class CategoryFetcher: BaseFetcher {
   
    func list (successBlock :(items :NSDictionary)->Void,
        failedBlock :(error :NSError) ->Void) {
        
            let ud = NSUserDefaults.standardUserDefaults()
            let token = ud.objectForKey(Const.userToken) as? String
            let genderId = ud.objectForKey(Const.genderId) as? Int
            let generationId = ud.objectForKey(Const.generationId) as? Int
            
            var request = NSMutableURLRequest(URL: NSURL(string: Const.urlDomain + "api/v1/categories/")!,
                cachePolicy: .UseProtocolCachePolicy,
                timeoutInterval: 10.0)
            request.HTTPMethod = "GET"
            request.addValue("Token", forHTTPHeaderField: token!)
            
            var postString:String = "generation_id=\(generationId!)&gender_id=\(genderId!)"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            
            self.sendAsynchronousByUrl(request) { (items) -> Void in
                
                successBlock(items: items)
            }
     
        
    }
    
}
