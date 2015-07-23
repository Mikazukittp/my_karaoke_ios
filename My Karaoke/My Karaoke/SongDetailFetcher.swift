//
//  SongDetailFetcher.swift
//  My Karaoke
//
//  Created by 朏島一樹 on 2015/07/24.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import UIKit

class SongDetailFetcher: BaseFetcher {
    
    func getUrl (songId :Int,
        successBlock :(item :SongDetail)->Void,
        failedBlock :(error :NSError) ->Void) {
            
            let ud = NSUserDefaults.standardUserDefaults()
            let token = ud.objectForKey(Const.userToken) as? String
            
            var request = NSMutableURLRequest(URL: NSURL(string: Const.urlDomain + "/api/v1/songs/" + songId.description)!,
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
            
            self.sendAsynchronousByUrl(request) { (item) -> Void in
                
                let dict = item as? NSDictionary
                let title = dict?.objectForKey("title") as? String
                let url = dict?.objectForKey("url") as? String
                
                var entity = SongDetail(title :title!, url :url!)
                successBlock(item: entity)
            }
            
    }
    
}
