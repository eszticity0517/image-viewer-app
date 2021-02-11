//
//  DetailsViewController.swift
//  Pods
//
//  Created by Eszter Szabó on 2021. 02. 10..
//

import Foundation
import UIKit
import RxSwift
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
    public var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoTitle.text = photoText
        
        photoViewModel.image.observe(on: MainScheduler.instance).subscribe(onNext: { (image) in
            print(image)
            self.photoImage.image = UIImage(data: image)
        })
        .disposed(by: disposeBag)
        
        photoViewModel.downloadPhoto(withId: photoURL)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
