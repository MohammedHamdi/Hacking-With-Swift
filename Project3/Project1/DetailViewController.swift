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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationItem.largeTitleDisplayMode = .never

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image else {return}
        guard let imageSize = imageView.image?.size else {return}
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: imageSize.width, height: imageSize.height))
        
        let img = renderer.image { ctx in
            image.draw(at: CGPoint(x: 0, y: 0))
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 24)
            ]
            
            let string = "From storm viewer"
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            
            attributedString.draw(with: CGRect(x: 16, y: 16, width: imageSize.width - 16, height: imageSize.height - 16), options: .usesLineFragmentOrigin, context: nil)
        }
        
        
        
        guard let imageData = img.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        guard let imageName = selectedImage else {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [imageData, imageName], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
