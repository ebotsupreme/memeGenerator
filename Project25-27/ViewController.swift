//
//  ViewController.swift
//  Project25-27
//
//  Created by Eddie Jung on 9/8/21.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var memes = [Meme]()
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO
        /*
         4. save image data to user defaults
         4.2 load image data from user defaults
         4.3 connect data to main view controller, reset background colors
         5. add share
         6. have details page to show image
         7. refactor
         */
        
        title = "Meme Generator"
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .camera, target: self, action: #selector(addImage))
        load()
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
    
    @objc func addImage() {
        let picker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentaryDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        } else {
            print("Could not retrieve jpegData from selected image.")
        }
        
        // move to add image & text screen
        if let avc = storyboard?.instantiateViewController(withIdentifier: "AddImage") as? AddImageViewController {
            avc.path = imagePath
            avc.memes = memes
            navigationController?.pushViewController(avc, animated: true)
        }
        
        dismiss(animated: true)
    }
    
    func getDocumentaryDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func load() {
        let defaults = UserDefaults.standard
        
        if let savedData = defaults.object(forKey: "memes") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                memes = try jsonDecoder.decode([Meme].self, from: savedData)
                print("MEMES LOADED!")
            } catch {
                print("Failed to load memes: \(error.localizedDescription)")
            }
        }
    }
}

