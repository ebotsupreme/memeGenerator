//
//  AddImageViewController.swift
//  Project25-27
//
//  Created by Eddie Jung on 9/9/21.
//

import CoreImage
import UIKit

class AddImageViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var path: URL?
    var topText = ""
    var bottomText = ""
    var filePath: URL?
    
    var meme = [Meme]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Image and text"

        print("AddimageViewController page.")
        
        if let imagePath = path {
            imageView.image = UIImage(contentsOfFile: imagePath.path)
//            let meme = Meme(filePath: imagePath, topText: "", bottomText: "")
            filePath = imagePath
        }
        
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor(named: "grey")?.cgColor
    }
    
    @IBAction func addTopText(_ sender: UIButton) {
        let ac = UIAlertController(title: "Add top text", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let newTopText = ac?.textFields?[0].text else { return }
            self?.topText = newTopText
        })
        
        present(ac, animated: true)
        
    }
    
    @IBAction func addBottomText(_ sender: UIButton) {
        let ac = UIAlertController(title: "Add bottom text", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let newBottomText = ac?.textFields?[0].text else { return }
            self?.bottomText = newBottomText
        })
        
        present(ac, animated: true)
    }
    
    @IBAction func submit(_ sender: UIButton) {
        guard let image = imageView.image else {
            let ac = UIAlertController(title: "Save error. Please select an image first.", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
}
