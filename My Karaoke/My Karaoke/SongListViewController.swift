//
//  SongListViewController.swift
//  My Karaoke
//
//  Created by 石部達也 on 2015/07/18.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import UIKit

class SongListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    var songs = [Song]()
    var category = Int()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Songs"
        
        
        var nib  = UINib(nibName: "SongTableCell", bundle:nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier:"SongTableCell")

        self.initializeTheSongs()
        
    }

    func initializeTheSongs() {
        
        self.indicatorStart()
        
        let fetcher = SongFetcher()
        fetcher.list(category, successBlock: { (items) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.songs = items
                self.tableView.reloadData()
                self.indicatorStop()
            })
        }) { (error) -> Void in
           
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.indicatorStop()
            })
        }
}

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier: String = "SongTableCell"
        
        var cell: SongTableCell! = self.tableView.dequeueReusableCellWithIdentifier(identifier) as? SongTableCell
        
        if cell == nil {
            cell = SongTableCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier)
        }
        
        cell!.nameLabel!.text = "\(indexPath.row+1). " + songs[indexPath.row].title
        cell!.artistName!.text = songs[indexPath.row].artistName
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 78.0
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        songs.removeAtIndex(indexPath.row)
        
        tableView.reloadData()
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var pc = DetailViewController(nibName: "DetailViewController", bundle: nil)
       
        pc.song = songs[indexPath.row]
        
        self.navigationController?.pushViewController(pc, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
