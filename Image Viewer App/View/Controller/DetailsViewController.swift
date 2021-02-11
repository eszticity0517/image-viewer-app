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
    
    // MARK: -These are coming from the previous ViewController.
    public var photoID: Int = 0
    public var photoText: String = ""
    
    // MARK: - Just in case, a pre-set value ...
    public var photoURL: String = "https://via.placeholder.com/600/92c952"
    public var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoTitle.text = photoText
        
        photoViewModel.image.observe(on: MainScheduler.instance).subscribe(onNext: { (image) in
            self.photoImage.image = UIImage(data: image)
        })
        .disposed(by: disposeBag)
        
        photoViewModel.downloadPhoto(withUrl: photoURL)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
