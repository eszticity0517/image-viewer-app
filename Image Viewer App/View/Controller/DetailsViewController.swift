//
//  DetailsViewController.swift
//  Pods
//
//  Created by Eszter Szabó on 2021. 02. 10..
//

import Foundation
import UIKit
 
class DetailsViewController: UIViewController {
    
    // MARK: - Injection
    let photoViewModel = PhotoViewModel(dataService: DataService())
    
    @IBOutlet public weak var photoTitle: UILabel!
    @IBOutlet public weak var photoImage: UIImageView!
    
    // These are coming from the previous ViewController.
    public var photoID: Int = 0
    public var photoText: String = ""
    // Just in case ...
    public var photoURL: String = "https://via.placeholder.com/600/92c952"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoTitle.text = photoText
        
        // attemptDownloadPhoto(url: photoURL)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Networking
    private func attemptDownloadPhoto(url: String) {
        photoViewModel.downloadPhoto(withId: url)
        
        photoViewModel.updateLoadingStatus = {
            let _ = self.photoViewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }
        
        photoViewModel.showAlertClosure = {
            if let error = self.photoViewModel.error {
                print(error.localizedDescription)
            }
        }
        
        photoViewModel.didFinishFetch = {
            let yourImage: UIImage = UIImage(data: self.photoViewModel.imageData!)!
            self.photoImage.image = yourImage
        }
    }
    
    // MARK: - UI Setup
    private func activityIndicatorStart() {
        // Code for show activity indicator view
        // ...
        print("start")
    }
    
    private func activityIndicatorStop() {
        // Code for stop activity indicator view
        // ...
        print("stop")
    }
    
}
