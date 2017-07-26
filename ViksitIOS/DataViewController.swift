//
//  DataViewController.swift
//  ViksitIOS
//
//  Created by Istar Feroz on 24/07/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        
        var response: String = Helper.makeHttpCall (url : "http://elt.talentify.in/t2c/user/3658/complex", method: "GET", param: [:])
        //print(response)
        //var complexObject = ComplexObject(JSONString: response)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel!.text = dataObject
    }


}

