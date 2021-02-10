//
//  ViewController.swift
//  Image Viewer App
//
//  Created by Eszter Szabó on 2021. 02. 09..
//

import UIKit
// The view controller no longer owns the model.
// It's the view model that owns the model, and the view controller asks the view model for the data it needs to display.
class ViewController: UIViewController {
    // MARK: - Injection
    let photoViewModel = PhotoViewModel(dataService: DataService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attemptFetchPhoto(withId: 8)
    }
    
    // MARK: - Networking
    private func attemptFetchPhoto(withId id: Int) {
        photoViewModel.fetchPhoto(withId: id)
        
        photoViewModel.updateLoadingStatus = {
            let _ = self.photoViewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }
        
        photoViewModel.showAlertClosure = {
            if let error = self.photoViewModel.error {
                print(error.localizedDescription)
            }
        }
        
        photoViewModel.didFinishFetch = {
            // TODO: fill the table with objects.
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

