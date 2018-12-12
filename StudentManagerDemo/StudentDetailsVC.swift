//
//  StudentDetailsVC.swift
//  StudentManagerDemo
//
//  Created by Duc Anh on 11/28/18.
//  Copyright © 2018 Duc Anh. All rights reserved.
//

import UIKit
import CoreData

class StudentDetailsVC: UITableViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    var student: PersonEntity?
    @IBOutlet weak var avarta: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if student != nil {
            if let avartaImage = student?.avarta {
                avarta.image = student?.avarta as? UIImage
            }
            nameTextField.text = student?.name
            phoneTextField.text = student?.phone
        }
//        updateData()
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        saveBtn.isEnabled = false
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        updateData()
//        navigationItem.title = textField.text
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        guard let selectedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // Set photoImageView to display the selected image.
        
        avarta.image = selectedImage
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func selectAvarta(_ sender: Any) {
        // Hide the keyboard.
        nameTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func onClickSave(_ sender: Any) {
        let student = PersonEntity(context: AppDelegate.context)
        student.avarta = avarta.image
        student.name = nameTextField.text
        student.phone = phoneTextField.text
        AppDelegate.saveContext()
//        navigationController?.popViewController(animated: true)
    }
    
//    func updateData() {
//        let text = nameTextField.text ?? ""
//        saveBtn.isEnabled = !text.isEmpty
//    }
    
}

fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (key.rawValue, value)})
}

fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
