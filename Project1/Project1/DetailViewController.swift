//
//  DetailViewController.swift
//  Project1
//
//  Created by Mohammed Hamdi on 8/24/19.
//  Copyright © 2019 Mohammed Hamdi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var totalNumberOfImages = 0
    var numberOfselectedImage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Picture \(numberOfselectedImage + 1) of \(totalNumberOfImages)"
        navigationItem.largeTitleDisplayMode = .never

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        
        assert(selectedImage != nil, "There is no selected image")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
