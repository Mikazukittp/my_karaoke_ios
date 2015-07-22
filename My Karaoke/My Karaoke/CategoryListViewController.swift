//
//  CategoryListViewController.swift
//  My Karaoke
//
//  Created by 石部達也 on 2015/07/18.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import UIKit

class CategoryListViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    var categories = [Category]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Category"
        
        //cellの登録
        var nib  = UINib(nibName: "CategoryTableCell", bundle:nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier:"CategoryTableCell")
        
        initializeTheCategoires()
    }

    func initializeTheCategoires() {
       let fetcher = CategoryFetcher()
        fetcher.list({ (items) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.categories = items
                self.tableView.reloadData()
            })
            
        }, failedBlock: { (error) -> Void in
            
        })
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier: String = "CategoryTableCell"
        
        var cell: CategoryTableCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? CategoryTableCell
        
        if cell == nil {
            cell = CategoryTableCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier)
        }
        
        //cell!.backgroundColor = UIColor.orangeColor()
        cell!.nameLabel!.text = categories[indexPath.row].name
//        cell!.thumbnailImageView!.image = UIImage(named:categories[indexPath.row].thumbnails)
//        cell!.prepTimeLabel!.text = categories[indexPath.row].prepTime
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 78.0
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        categories.removeAtIndex(indexPath.row)
        
        tableView.reloadData()
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var pc = SongListViewController(nibName: "SongListViewController", bundle: nil)
        pc.category = categories[indexPath.row].id
        
        self.navigationController?.pushViewController(pc, animated: true)
    }

}
