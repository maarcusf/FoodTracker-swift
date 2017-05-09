//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Marcus Ferreira on 28/04/17.
//  Copyright © 2017 Vladyslav Chornobai. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    //Propriedades
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var starRating: StarRatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 //Faz qualquer configuração adicional após carregar a view, normalmente a partir de uma ponta.
        nameTextField.delegate = self
        
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text   = meal.name
            photoImageView.image = meal.photo
            starRating.rating = meal.rating
        }
        
        updateSaveButtonState()
    }
    
    
    //UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    //UIImagePickerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Dicionário de imagem esperado com a imagem original, mas em vez disso obteve isso \(info)")
            
        }
        photoImageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    //Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configura a ViewController de destino somente quando o botão Salvar for pressionado.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("O botão salvar não foi pressionado, cancelando.", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = starRating.rating
        
        // Define a refeição a ser passada para MealTableViewController.
        meal = Meal(name: name, photo: photo, rating: rating)
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("O MealViewController não está dentro de um NavigationController.")
        }
    }

    //Acões
    //Selecionar a imagem da galeria
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = .photoLibrary
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    //Ações privadas
    private func updateSaveButtonState() {
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    

}

