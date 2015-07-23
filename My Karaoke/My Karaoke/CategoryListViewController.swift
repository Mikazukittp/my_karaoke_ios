//
//  CategoryListViewController.swift
//  My Karaoke
//
//  Created by 石部達也 on 2015/07/18.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import UIKit

class CategoryListViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate,UIToolbarDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var generationTextInput: UITextField!
    @IBOutlet weak var generateStatus: UISegmentedControl!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var categories = [Category]()
    let generateStr = ["10代", "20代", "30代"]
    let generateValue = [1,2,3]
    var userGenerateValue :Int?
    var toolBar: UIToolbar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Category"
        
        //Naviagationbar潜り込み防止
        self.edgesForExtendedLayout = UIRectEdge.None
        
        
        //cellの登録
        var nib  = UINib(nibName: "CategoryTableCell", bundle:nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier:"CategoryTableCell")
        
        var pickerView = UIPickerView()
        pickerView.showsSelectionIndicator = true
        pickerView.delegate = self
        
        generationTextInput.inputView = pickerView
        
        toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = .BlackTranslucent
        toolBar.tintColor = UIColor.whiteColor()
        toolBar.backgroundColor = UIColor.blackColor()
        
        let toolBarBtn = UIBarButtonItem(title: "完了", style: .Bordered, target: self, action: "tappedToolBarBtn:")
        toolBarBtn.tag = 1
        toolBar.items = [toolBarBtn]
        
        generationTextInput.inputAccessoryView = toolBar
        
        let ud = NSUserDefaults.standardUserDefaults()
        
        userGenerateValue = ud.objectForKey(Const.generationId) as? Int
        let genderId = ud.objectForKey(Const.genderId) as? Int
        
        if userGenerateValue != nil && genderId != nil {
            initializeUserStatus(userGenerateValue!,genderId :genderId!)
            initializeTheCategoires()
        }
        
    }
    
    func initializeUserStatus (generationId :Int ,genderId: Int) {
        let generation = generateStr[generationId - 1]
        generationTextInput.text = generation
        generateStatus.selectedSegmentIndex = genderId - 1
    }
    
    func initializeTheCategoires() {
        
        self.indicatorStart()
        
        let fetcher = CategoryFetcher()
        fetcher.list({ (items) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.categories = items
                self.tableView.reloadData()
                self.indicatorStop()
            })
            
            }, failedBlock: { (error) -> Void in
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.indicatorStop()
                })
        })
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return generateStr.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return generateStr[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.userGenerateValue = generateValue[row]
        generationTextInput.text = generateStr[row]
    }
    
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        generationTextInput.resignFirstResponder()
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier: String = "CategoryTableCell"
        
        var cell: CategoryTableCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? CategoryTableCell
        
        if cell == nil {
            cell = CategoryTableCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier)
        }
        
        cell!.nameLabel!.text = categories[indexPath.row].name
        cell!.descriptionLabel!.text = categories[indexPath.row].description
        
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
    
    private func indicatorStart () {
        self.indicator.hidden = false
        self.indicator.startAnimating()
    }
    private func indicatorStop () {
        self.indicator.hidden = true
        self.indicator.stopAnimating()
    }
    
    
    @IBAction func searchButtonTapped(sender: AnyObject) {
        let ud = NSUserDefaults.standardUserDefaults()
        
        ud.setObject(generateStatus.selectedSegmentIndex + 1, forKey: Const.genderId)
        ud.setObject(userGenerateValue, forKey: Const.generationId)
        
        initializeTheCategoires()
    }
}
