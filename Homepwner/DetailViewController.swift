//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Jayden Olsen on 3/26/17.
//  Copyright © 2017 Jayden Olsen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate,
        UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var nameField: UITextField!
    
    var item: Item! {
        didSet {
            //the title for the view is the tapped item
            navigationItem.title = item.name
        }
    }
    var imageStore: ImageStore!
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        
        //If device has a camera, take a picture; otherwise,
        //just pick from photo library
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        
        //Place image picker on screen
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            
            //Get picked image from info
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
            //Store the image in the ImageStore for the item's key
            imageStore.setImage(image, forKey: item.itemKey)
            
            //Put that image on screen in the image view
            imageView.image = image
            
            //Take image picker off the screen in the image view
            //you must call this dismiss method
            dismiss(animated: true, completion: nil)
    }
    
    //tapping the background dismisses the keyboard.
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //Formats numbers for the value text field
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    } ()
    
    //Formats the date for the Date Created label
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    } ()
    
    //When this view appears, the fields are loaded with the appropriate
    //values from the tapped item.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text =
            numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
        
        //Get the item key
        let key = item.itemKey
        
        //If there is an associated image with the item
        //display it on the image view
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image = imageToDisplay
    }
    
    //When this view disappears/is closed, the data in the fields
    //is saved into the item displayed
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Clear first responder
        view.endEditing(true)
        
        // "Save" changes to item
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        if let valueText = valueField.text,
            let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }
    
    //If the user taps enter on the keyboard, the text field resigns as
    //first responder and the resignFirstResponder method is called.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
