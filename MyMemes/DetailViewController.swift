//
//  DetailViewController.swift
//  MyMemes
//
//  Created by Kimberly Smith on 11/2/17.
//  Copyright © 2017 Smith Kimberly. All rights reserved.
//

import UIKit
class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var meme: Meme! {
        didSet {
            navigationItem.title = meme.title
        }
    }
    var imageCollector: ImageCollector!
    
    @IBOutlet var imageView: UIImageView!
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        present(imagePicker,animated: true,completion: nil)
    }
    
    
    @IBOutlet var titleField: UITextField!
    
    @IBOutlet var typeField: UITextField!
    
    @IBOutlet var ratingField: UITextField!
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleField.text = meme.title
        typeField.text = meme.type
        ratingField.text = String(meme.rating)
        let key = meme.itemKey
        let imageToDisplay = imageCollector.image(forKey: key)
        imageView.image = imageToDisplay
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        meme.title = titleField.text ?? ""
        meme.type = typeField.text ?? ""
        if let rat: Int = Int(ratingField.text!) {
            meme.rating = rat
        } else {
            meme.rating = 0
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        let image = info[UIImagePickerControllerOriginalImage]
            as! UIImage
        imageCollector.setImage(image, forKey: meme.itemKey)
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
}
