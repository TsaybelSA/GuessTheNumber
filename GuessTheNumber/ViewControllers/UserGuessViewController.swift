//
//  UserGuessViewController.swift
//  GuessTheNumber
//
//  Created by Сергей Цайбель on 18.08.2022.
//

import UIKit

class UserGuessViewController: UIViewController {

	var numbersOfTries = 1

	var possibleNumbers = [1,2,3,4,5,6]
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = .white
		
		numberPicker.delegate = self
		numberPicker.dataSource = self
		
		view.addSubview(informationLabel)
		view.addSubview(guessNumberField)
		view.addSubview(promptLabel)
		view.addSubview(guessButton)
		
		NSLayoutConstraint.activate([
			informationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
			informationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			
			guessNumberField.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 20),
			guessNumberField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			guessNumberField.heightAnchor.constraint(equalToConstant: 70),
//			guessNumberField.widthAnchor.constraint(equalToConstant: 300),
			
//			promptLabel.topAnchor.constraint(equalTo: guessNumberField.bottomAnchor, constant: 20),
//			promptLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//			promptLabel.heightAnchor.constraint(equalToConstant: 50),
			
			guessButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
			guessButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			guessButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
			guessButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth)
			])
    }
    
	lazy var informationLabel: UILabel = {
		let label = UILabel()
		label.text = "You are guessing\n\n Try \(numbersOfTries)"
		label.font = UIFont.systemFont(ofSize: 25)
		label.numberOfLines = 0
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	var numberPicker: UIPickerView = {
		let picker = UIPickerView()
		picker.translatesAutoresizingMaskIntoConstraints = false
		return picker
	}()
	
	lazy var guessNumberField: UITextField = {
		let textField = makeTextField()
		textField.inputView = numberPicker
		textField.addTarget(nil, action: #selector(guessNumberChanged), for: .editingChanged)
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	
	var promptLabel: UILabel = {
		let label = UILabel()
		label.text = ""
		label.font = UIFont.systemFont(ofSize: 20)
		label.numberOfLines = 0
		label.textAlignment = .center
		label.textColor = .red
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	var guessButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Enter The Number", for: .normal)
		button.setTitleColor(UIColor.white, for: .normal)
		button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
		button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		button.backgroundColor = .blue
		button.layer.cornerRadius = 25
		button.addTarget(nil, action: #selector(guessButtonPressed), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	@objc func guessButtonPressed() {
		
	}
	
	@objc func guessNumberChanged() {
		if let text = guessNumberField.text, let number = Int(text) {
			if number >= 1 && number <= 100 {
				promptLabel.text = ""
				guessButton.isEnabled = true
				UIView.animate(withDuration: 0.2) {
					self.guessButton.layer.opacity = 1
				}
				return
			} else {
				promptLabel.text = "Number to guess should be from 1 to 100"
			}
		} else {
			promptLabel.text = ""
		}
		guessButton.isEnabled = false
		UIView.animate(withDuration: 0.2) {
			self.guessButton.layer.opacity = 0.4
		}
	}
}


extension UserGuessViewController: UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return possibleNumbers.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return String(possibleNumbers[row])
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		guessNumberField.text = String(possibleNumbers[row])
		guessNumberField.resignFirstResponder()
	}
}
