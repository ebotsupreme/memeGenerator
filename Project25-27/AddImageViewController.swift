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
    
    var memes = [Meme]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Image and text"
        
        if let imagePath = path {
            imageView.image = UIImage(contentsOfFile: imagePath.path)
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
        
        let imageData = drawImagesAndText(imageToLoad: image)
        if let imageToSave = UIImage(data: imageData) {
            UIImageWriteToSavedPhotosAlbum(imageToSave, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
            present(ac, animated: true)
            
        }
    }
    
    func drawImagesAndText(imageToLoad: UIImage) -> Data {
        let renderer = UIGraphicsImageRenderer(size: imageToLoad.size)
        
        let renderedImage = renderer.image { ctx in
            imageToLoad.draw(at: CGPoint(x: 0, y: 0))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            
            let attr: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 100),
                .paragraphStyle: paragraphStyle,
                .strokeWidth: -3,
                .strokeColor: UIColor.black,
                .foregroundColor: UIColor.white
            ]
            
            let margin = 22
            let textWidth = Int(imageToLoad.size.width) - (margin * 2)
            let textHeight = Int(imageToLoad.size.height) - (margin * 2)
            let bottomTextYValue = (Int(imageToLoad.size.height) / 6) * 4
            print("height \(Int(imageToLoad.size.height))")
            print("textHeight \(textHeight)")
            
            let attributtedStringTopText = NSAttributedString(string: topText.uppercased(), attributes: attr)
            attributtedStringTopText.draw(with: CGRect(x: margin, y: margin, width: textWidth, height: textHeight), options: .usesLineFragmentOrigin, context: nil)
            
            let attributtedStringBottomText = NSAttributedString(string: bottomText.uppercased(), attributes: attr)
            attributtedStringBottomText.draw(with: CGRect(x: margin, y: bottomTextYValue, width: textWidth, height: textHeight), options: .usesLineFragmentOrigin, context: nil)
            
        }
        
        return renderedImage.jpegData(compressionQuality: 0.8)!
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(memes) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "memes")
            print("SAVED!")
        }
    }
    
}
