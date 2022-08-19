//
//  UserGuessViewController.swift
//  GuessTheNumber
//
//  Created by Сергей Цайбель on 18.08.2022.
//

import UIKit

class UserGuessViewController: UIViewController {

	init(difficulty: Difficulty, computerScore: Int) {
		gameModel = UserGuessGameModel(difficulty: difficulty, computerScore: computerScore)
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	let gameModel: UserGuessGameModel
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		gameModel.delegate = self
		modelHasChanges()
		updateEnterNumberButton()
		
		navigationController?.navigationBar.isHidden = true

		view.backgroundColor = .white
		
		numberPicker.delegate = self
		numberPicker.dataSource = self
		
		view.addSubview(informationLabel)
		view.addSubview(guessNumberField)
		view.addSubview(promptLabel)
		view.addSubview(enterTheNumberButton)
		
		NSLayoutConstraint.activate([
			informationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
			informationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			
			guessNumberField.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 20),
			guessNumberField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			guessNumberField.heightAnchor.constraint(equalToConstant: 70),
			guessNumberField.widthAnchor.constraint(equalToConstant: 300),
			
			promptLabel.topAnchor.constraint(equalTo: guessNumberField.bottomAnchor, constant: 20),
			promptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
			promptLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
			promptLabel.heightAnchor.constraint(equalToConstant: 100),
			
			enterTheNumberButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
			enterTheNumberButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			enterTheNumberButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
			enterTheNumberButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth)
			])
    }
    
	lazy var informationLabel: UILabel = {
		let label = UILabel()
		label.text = "You are guessing\n\n Try \(gameModel.numberOfTries)"
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
		textField.addTarget(nil, action: #selector(updateEnterNumberButton), for: .editingDidEnd)
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	
	var promptLabel: UILabel = {
		let label = UILabel()
		label.text = ""
		label.font = UIFont.systemFont(ofSize: 35)
		label.numberOfLines = 0
		label.adjustsFontSizeToFitWidth = true
		label.textAlignment = .center
		label.textColor = .red
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	var enterTheNumberButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Enter The Number", for: .normal)
		button.setTitleColor(UIColor.white, for: .normal)
		button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
		button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		button.backgroundColor = .blue
		button.layer.cornerRadius = 25
		button.addTarget(nil, action: #selector(enterTheNumberButtonPressed), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	@objc func updateEnterNumberButton() {
		if let text = guessNumberField.text, !text.isEmpty {
			enterTheNumberButton.isEnabled = true
			UIView.animate(withDuration: 0.4) {
				self.enterTheNumberButton.layer.opacity = 1
			}
		} else {
			enterTheNumberButton.isEnabled = false
			UIView.animate(withDuration: 0.4) {
				self.enterTheNumberButton.layer.opacity = 0.6
			}
		}
	}
	
	@objc func enterTheNumberButtonPressed() {
		if let text = guessNumberField.text, let number = Int(text) {
			gameModel.userPickedNumber(number)
			guessNumberField.text = ""
			updateEnterNumberButton()
		}
	}
}


extension UserGuessViewController: UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return gameModel.possibleNumbers.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return String(gameModel.possibleNumbers[row])
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		guessNumberField.text = String(gameModel.possibleNumbers[row])
		guessNumberField.resignFirstResponder()
	}
}

extension UserGuessViewController: UserGuessGameModelDelegate {
	func modelHasChanges() {
		informationLabel.text = "You are guessing\n\n Try \(gameModel.numberOfTries)"
		promptLabel.makeTypeEffectFor(gameModel.clue)
	}
	
	func gameOver() {
		guessNumberField.isEnabled = false
		updateEnterNumberButton()
	}
}