//
//  MealViewController.swift
//  FoodTracker
//
//  Created by csair on 2018/4/25.
//  Copyright © 2018年 Pop Team Epic. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController,UITextFieldDelegate,
    UIImagePickerControllerDelegate,UINavigationControllerDelegate {
// Mark properties
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var ratingControl: RatingControl!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var hourButton: UITextField!
    @IBOutlet var minuteButton: UITextField!
    @IBOutlet var priceTextField: UITextField!
    
    /*
     This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal.
     */
    var meal: Meal?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameTextField.delegate = self
        nameTextField.tag = 1
        hourButton.delegate = self
        hourButton.tag = 2
        minuteButton.delegate = self
        minuteButton.tag = 2
        priceTextField.delegate = self
        priceTextField.tag = 2
        // Set up views if editing an existing Meal.
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
            hourButton.text = String(meal.hour)
            minuteButton.text = String(meal.minute)
            priceTextField.text = String(describing: meal.price)
        }
        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
    }
    override func viewDidAppear(_ animated: Bool) {
        print("view did appear")
    }
    //mark uitextdelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        if(textField.tag == 1){
            navigationItem.title = textField.text
        }
        
    }
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
            // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    
    // This method lets you configure a view controller before it's presented.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        let hour = hourButton.text ?? ""
        let minute = minuteButton.text ?? ""
        let price = priceTextField.text ?? ""
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        meal = Meal(name: name, photo: photo, rating: rating, hour: hour, minute:minute, price:price)
    }
    

    // Mark action
    @IBAction func selectImageLibrary(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        let imageController = UIImagePickerController()
        imageController.sourceType = .photoLibrary
        imageController.delegate = self
        present(imageController, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    //MARK: Private Methods
    
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        let hourEnable = hourButton.text ?? ""
        var minuteEnable = minuteButton.text ?? ""
        if(minuteEnable.isEmpty || Int(minuteEnable)! > 59){
            minuteEnable = ""
        }
        var priceEnable = priceTextField.text ?? ""
        if(priceEnable != ""){
            if(priceEnable.split(separator: ".").count > 2){
                priceEnable = ""
            }
        }
        saveButton.isEnabled = !text.isEmpty && !hourEnable.isEmpty && !minuteEnable.isEmpty && !priceEnable.isEmpty
    }
    


}

