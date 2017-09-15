//
//  ViewController.swift
//  PushNotificationSample
//
//  Created by Sujan Vaidya on 9/14/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var myLabel: UILabel!
  var text = ""

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    // Do any additional setup after loading the view, typically from a nib.
  }

  func setup() {
    myLabel = UILabel()
    myLabel.text = text
    self.view.addSubview(myLabel)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    myLabel.frame = CGRect(x: 12, y: 40, width: 300, height: 20);
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

