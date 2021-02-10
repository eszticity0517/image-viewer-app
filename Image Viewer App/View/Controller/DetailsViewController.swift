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
    
    // These are coming from the previous ViewController.
    public var photoID: Int = 0
    public var photoText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoTitle.text = photoText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
