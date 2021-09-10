//
//  AddImageViewController.swift
//  Project25-27
//
//  Created by Eddie Jung on 9/9/21.
//

import UIKit

class AddImageViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var path: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Image and text"

        print("AddimageViewController page.")
        
        if let imagePath = path {
            imageView.image = UIImage(contentsOfFile: imagePath.path)
        }
    }
    

}
