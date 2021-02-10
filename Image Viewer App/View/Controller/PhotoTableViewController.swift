//
//  PhotoTableViewController.swift
//  Image Viewer App
//
//  Created by Eszter Szabó on 2021. 02. 10..
//

import Foundation

import UIKit

class PhotoTableViewController: UITableViewController {
    // MARK: - Injection
    let photoListViewModel = PhotoListViewModel(dataService: DataService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attemptFetchAllPhotos()
    }
    
    private func attemptFetchAllPhotos() {
        photoListViewModel.fetchAllPhotos()
        
        photoListViewModel.updateLoadingStatus = {
            let _ = self.photoListViewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }
        
        photoListViewModel.showAlertClosure = {
            if let error = self.photoListViewModel.error {
                print(error.localizedDescription)
            }
        }
        
        photoListViewModel.didFinishFetch = {
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
