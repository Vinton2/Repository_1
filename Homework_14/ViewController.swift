//
//  ViewController.swift
//  Homework_14
//
//  Created by Иван Степанов on 08.05.2021.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var secondNameLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameLabel.text = Name.shared.firstName
        secondNameLabel.text = Name.shared.secondName
    }
    
    @IBAction func changeButton(_ sender: Any) {
        
        if firstNameTextField.text != ""{
            Name.shared.firstName = firstNameTextField.text ?? ""
            firstNameLabel.text = Name.shared.firstName
        }
        
        if secondNameTextField.text != ""{
        Name.shared.secondName = secondNameTextField.text ?? ""
        secondNameLabel.text = Name.shared.secondName
        }
    }
}
