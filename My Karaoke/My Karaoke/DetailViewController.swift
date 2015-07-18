//
//  DetailViewController.swift
//  My Karaoke
//
//  Created by 石部達也 on 2015/07/18.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var song: Song?
    
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "YouTube Movie"
        
        
        //Naviagationbar潜り込み防止
        self.edgesForExtendedLayout = UIRectEdge.None
        
        self.setMovie()
        self.setDetail()
    }
    
    private func setMovie () {
        
        var url = NSURL(string: song!.url)
        var urlRequest: NSURLRequest = NSURLRequest(URL: url!)
        self.webView.allowsInlineMediaPlayback = true;
        self.webView.loadRequest(urlRequest)
    }
    
    private func setDetail () {
        detailView.layer.borderWidth = 1.0
        detailView.layer.borderColor = UIColor(red: 0.475, green: 0.620, blue: 0.620, alpha: 1.0).CGColor
        detailView.layer.cornerRadius = 3.0
        
    }

}
