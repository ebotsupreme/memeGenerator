//
//  ViewController.swift
//  Project25-27
//
//  Created by Eddie Jung on 9/8/21.
//

import UIKit

class ViewController: UICollectionViewController {
    var memes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO
        /*
         1. create collectionview revised project 103c
         2. create detail view with imageView, 3 buttons
         3. add image alerts , image controller, image picker project101112 or project13
         4. render image with updated text in positions proj 27 ch 3 and share image
         5. add share
         6. have details page to show image
         */
        
        title = "Meme Generator"
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .camera, target: self, action: #selector(selectPhoto))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Meme", for: indexPath) as? MemeViewCell else {
            fatalError("Could not dequeue MemeView cell.")
        }
//        item.imageView.image = UIImage(named: "Philosoraptor")
        cell.imageName.text = "Image Name placeholder"
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.init(white: 0, alpha: 0.3).cgColor
        cell.layer.cornerRadius = 5
        
        return cell
    }
    
    @objc func selectPhoto() {
        // move to add image screen
        if let avc = storyboard?.instantiateViewController(withIdentifier: "AddImage") {
            navigationController?.pushViewController(avc, animated: true)
        }
        
    }


}

