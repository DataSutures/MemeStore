//
//  DetailViewController.swift
//  MyMemes
//
//  Created by Kimberly Smith on 11/2/17.
//  Copyright © 2017 Smith Kimberly. All rights reserved.
//

import UIKit
class NewMemeViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var titleM: String?
    var type: String?
    var rating: String?
    var meme: Meme!
    var memeCollection: MemeCollection!
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var typeField: UITextField!
    @IBOutlet var ratingField: UITextField!
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
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "saveMemeDetail",
            let title = titleField.text,
            let typeR = typeField.text,
            let rating = ratingField.text{
                self.meme = Meme(title: title, type: typeR, rating: Int(rating)!)
            }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (titleM != nil) {
            titleField.text = titleM
        }
        if (type != nil ) {
            typeField.text = type
        }
        if (rating != nil) {
            ratingField.text = String(describing: rating)
        }
        
    }
    func showAlert(){
        let alertController = UIAlertController(title: "No Image Selected.", message: "You must select an image.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
}

