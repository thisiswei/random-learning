//
//  ViewController.swift
//  checklist
//
//  Created by wei lu on 6/4/14.
//  Copyright (c) 2014 wei inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    var textField: UITextField!
    var data = ["Wei", "Bingbinglai", "Stylr"]

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //setup textView
        
        self.tableView = UITableView(frame: CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-100), style: UITableViewStyle.Plain)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.view.addSubview(self.tableView)
        
        // setup textfield
        self.textField = UITextField(frame: CGRectMake(0, 0, self.view.bounds.size.width, 100))
        self.textField.backgroundColor = UIColor.blueColor()
        self.textField.delegate = self
        self.view.addSubview(self.textField)
    
    }
    
    // textfielddelegate
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let nc: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as UITableViewCell
        nc.text = self.data[indexPath.row]
        return nc
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        data.append(textField.text)
        textField.text = ""
        self.tableView.reloadData()
        textField.resignFirstResponder()
        return true
    }



}
