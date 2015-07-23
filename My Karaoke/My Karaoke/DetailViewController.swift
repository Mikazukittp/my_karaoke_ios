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
    @IBOutlet weak var playButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "YouTube Movie"
        
        //Naviagationbar潜り込み防止
        self.edgesForExtendedLayout = UIRectEdge.None
        
        let myVideoURL = NSURL(string: "https://www.youtube.com/watch?v=wQg3bXrVLtg")
        playerView.loadVideoURL(myVideoURL!)
    }
    
    @IBAction func play(sender: UIButton) {
        if playerView.ready {
            if playerView.playerState != YouTubePlayerState.Playing {
                playerView.play()
                playButton.setTitle("Pause", forState: .Normal)
            } else {
                playerView.pause()
                playButton.setTitle("Play", forState: .Normal)
            }
        }
    }
    
    @IBAction func prev(sender: UIButton) {
        playerView.previousVideo()
    }
    
    @IBAction func next(sender: UIButton) {
        playerView.nextVideo()
    }
    
    @IBAction func loadVideo(sender: UIButton) {
        playerView.playerVars = ["playsinline": "1"]
        playerView.loadVideoID("wQg3bXrVLtg")
    }
    
    @IBAction func loadPlaylist(sender: UIButton) {
        playerView.loadPlaylistID("RDe-ORhEE9VVg")
    }
    
    func showAlert(message: String) {
        self.presentViewController(alertWithMessage(message), animated: true, completion: nil)
    }
    
    func alertWithMessage(message: String) -> UIAlertController {
        let alertController =  UIAlertController(title: "", message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        
        return alertController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
