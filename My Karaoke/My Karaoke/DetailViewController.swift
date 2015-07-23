//
//  DetailViewController.swift
//  My Karaoke
//
//  Created by 石部達也 on 2015/07/18.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import UIKit
import YouTubePlayer

class DetailViewController: UIViewController {
    
    var song: Song?
    
    @IBOutlet weak var playerView: YouTubePlayerView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Naviagationbar潜り込み防止
        self.edgesForExtendedLayout = UIRectEdge.None
        
        self.indicatorStart()
        
        let fetcher = SongDetailFetcher()
        fetcher.getUrl(song!.id, successBlock: { (item) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.title = item.title
                self.likeLabel.text = "歌いたい : " + self.song!.like.description
               
                let myVideoURL = NSURL(string: item.url)
                self.playerView.loadVideoURL(myVideoURL!)
                self.indicatorStop()
            })
        }) { (error) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.indicatorStop()
            })
    
        }
    }
    
    func showAlert(message: String) {
        self.presentViewController(alertWithMessage(message), animated: true, completion: nil)
    }
    
    func alertWithMessage(message: String) -> UIAlertController {
        let alertController =  UIAlertController(title: "", message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        
        return alertController
    }

    private func indicatorStart () {
        self.indicator.hidden = false
        self.indicator.startAnimating()
    }
    private func indicatorStop () {
        self.indicator.hidden = true
        self.indicator.stopAnimating()
    }

}
