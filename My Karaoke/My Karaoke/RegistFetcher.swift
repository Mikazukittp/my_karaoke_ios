//
//  RegistFetcher.swift
//  My Karaoke
//
//  Created by 石部達也 on 2015/07/21.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import UIKit

class RegistFetcher: BaseFetcher {

    func regist (
        userName :String?,
        userSex :Int?,
        userGeneration :Int?,
        successBlock :()->Void,
        failedBlock :(error :NSError) ->Void)
    {
        var request = NSMutableURLRequest(URL: NSURL(string: Const.urlDomain + "api/v1/users/")!,
            cachePolicy: .UseProtocolCachePolicy,
            timeoutInterval: 10.0)
        request.HTTPMethod = "POST"
        
        var postString:String = "name=\(userName!)&gender_id=\(userSex!)&generation_id=\(userGeneration!)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
      
        self.sendAsynchronousByUrl(request) { (items) -> Void in
            
            let ud = NSUserDefaults.standardUserDefaults()

            if let userToken: String = items.objectForKey("token") as? String {
                ud.setObject(userName, forKey: Const.userName)
                ud.setObject(userGeneration, forKey: Const.generationId)
                ud.setObject(userSex, forKey: Const.genderId)
                ud.setObject(userToken, forKey: Const.userToken)
            }
            successBlock()
        }
        
    }
}
