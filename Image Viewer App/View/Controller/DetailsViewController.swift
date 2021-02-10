//
//  DetailsViewController.swift
//  Pods
//
//  Created by Eszter Szabó on 2021. 02. 10..
//

import Foundation
import UIKit
 
class DetailsViewController: UIViewController {
    @IBOutlet public weak var photoTitle: UILabel!
    @IBOutlet public weak var photoImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoTitle.text = "elm"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
