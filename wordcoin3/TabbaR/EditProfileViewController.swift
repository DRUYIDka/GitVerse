//
//  EditProfileViewController.swift
//  wordcoin3
//
//  Created by admin on 23.02.2024.
//  Copyright © 2024 admin. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var savebutton: UIButton!
    @IBOutlet weak var slovodna: UIButton!
    
    @IBOutlet weak var textField: UITextField!
    let textFieldKey = "SavedTextFieldText"
    @IBOutlet weak var profileImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        savebutton.layer.cornerRadius = savebutton.frame.size.width / 5
        slovodna.layer.cornerRadius = slovodna.frame.size.width / 5
        if let savedText = UserDefaults.standard.string(forKey: textFieldKey) {
            textField.text = savedText
            profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
            profileImageView.clipsToBounds = true
            if let savedImage = UserDefaults.standard.object(forKey: "profileImage") as? Data {
                profileImageView.image = UIImage(data: savedImage)
            }
            profileImageView.clipsToBounds = true
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func saveText(_ sender: UIButton) {
        if let text = textField.text {
            UserDefaults.standard.set(text, forKey: textFieldKey)
        }
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        if let savedImage = UserDefaults.standard.object(forKey: "profileImage") as? Data {
            profileImageView.image = UIImage(data: savedImage)
        }
        profileImageView.clipsToBounds = true
    }
    
    
    @IBAction func changeProfileImage(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage {
            profileImageView.image = selectedImage
            profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
            profileImageView.clipsToBounds = true
            
            if let imageData = selectedImage.pngData() {
                UserDefaults.standard.set(imageData, forKey: "profileImage")
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
