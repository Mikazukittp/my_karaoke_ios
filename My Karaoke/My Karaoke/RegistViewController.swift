//
//  RegistViewController.swift
//  My Karaoke
//
//  Created by 石部達也 on 2015/07/19.
//  Copyright (c) 2015年 石部達也. All rights reserved.
//

import UIKit

class RegistViewController: UIViewController ,UIPickerViewDelegate,UIToolbarDelegate{

    var num = ["10代", "20代", "30代", "40代"]
    var toolBar: UIToolbar!
    
    @IBOutlet weak var userNameTextInput: UITextField!
    @IBOutlet weak var userStatusBar: UISegmentedControl!
    @IBOutlet weak var userGenerationInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        //Naviagationbar潜り込み防止
        self.edgesForExtendedLayout = UIRectEdge.None
        
        self.title = "My Karaoke"
        
        var pickerView = UIPickerView()
        pickerView.showsSelectionIndicator = true
        pickerView.delegate = self
        
        userGenerationInput.inputView = pickerView
        
        toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = .BlackTranslucent
        toolBar.tintColor = UIColor.whiteColor()
        toolBar.backgroundColor = UIColor.blackColor()
        
        let toolBarBtn = UIBarButtonItem(title: "完了", style: .Bordered, target: self, action: "tappedToolBarBtn:")
        toolBarBtn.tag = 1
        toolBar.items = [toolBarBtn]
        
        userGenerationInput.inputAccessoryView = toolBar
    
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return num.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return num[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userGenerationInput.text = num[row]
    }
    
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        userGenerationInput.resignFirstResponder()
    }

    
    @IBAction func registButtonTapped(sender: AnyObject) {
        
        var pc = CategoryListViewController(nibName: "CategoryListViewController", bundle: nil)
        
        self.navigationController?.pushViewController(pc, animated: true)

    }
}
