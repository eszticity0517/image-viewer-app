//
//  ViewController.swift
//  Image Viewer App
//
//  Created by Eszter Szabó on 2021. 02. 09..
//

class PhotoTableViewCell: UITableViewCell {
    @IBOutlet weak var downloadButton: UIButton!
}

import UIKit
// The view controller no longer owns the model.
// It's the view model that owns the model, and the view controller asks the view model for the data it needs to display.
// We don´t need the UITableViewController inheritance, this extends from UIViewController already, but DataSource and ViewDelegate are needed.
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: - Injection
    let photoViewModel = PhotoViewModel(dataService: DataService())
    let photoListViewModel = PhotoListViewModel(dataService: DataService())
    
    @IBOutlet public weak var photosTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosTable.dataSource = self
        photosTable.delegate = self
        photosTable.rowHeight = 60
        
        attemptFetchPhoto(withId: 8)
        attemptFetchAllPhotos()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        // print("Value: \(myArray[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return myArray.count
        print(photoListViewModel.numberOfRowsInSection())
        return photoListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photo = photoListViewModel.photos![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! PhotoTableViewCell
        // cell.textLabel!.text = "\(myArray[indexPath.row])"
        cell.textLabel!.text = photo.title
        cell.downloadButton!.tag = photo.id!
    
        return cell
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
            self.photosTable.reloadData()
        }
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
            self.photosTable.reloadData()
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

