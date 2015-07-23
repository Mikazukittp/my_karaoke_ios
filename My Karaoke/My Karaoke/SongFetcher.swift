//
//  SongFetcher.swift
//  My Karaoke
//
//  Created by 石部達也 on 2015/07/22.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import UIKit

class SongFetcher: BaseFetcher {
 
    func list (categoryId :Int?,
        successBlock :(items :Array<Song>)->Void,
        failedBlock :(error :NSError) ->Void) {

            let ud = NSUserDefaults.standardUserDefaults()
            let token = ud.objectForKey(Const.userToken) as? String
            
            var getParam:String = "?category_id=\(categoryId!)"
            
            var request = NSMutableURLRequest(URL: NSURL(string: Const.urlDomain + "/api/v1/songs" + getParam)!,
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
                var songs = [Song]()
                
                for anItem in array! {
                    let dict = anItem as? NSDictionary
                    let id = anItem.objectForKey("id") as? Int
                    let title = anItem.objectForKey("title") as? String
                    let like = anItem.objectForKey("like") as? Int
                    let artist = anItem.objectForKey("artist") as? NSDictionary
                    let artistName = artist?.objectForKey("name") as? String

                    var entity = Song(title :title!,id :id!,like :like!,artistName :artistName!)
                    songs.append(entity)
                }
                
                successBlock(items: songs)
            }

   
    }
    
}
