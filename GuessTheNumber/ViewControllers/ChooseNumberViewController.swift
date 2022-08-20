//
//  ChooseNumberViewController.swift
//  GuessTheNumber
//
//  Created by Сергей Цайбель on 18.08.2022.
//

import UIKit

class ChooseNumberViewController: UIViewController {
	
	init(difficulty: DifficultyLevels) {
		self.selectedDifficulty = difficulty
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	let selectedDifficulty: DifficultyLevels

    override func viewDidLoad() {
        super.viewDidLoad()
		navigationController?.navigationBar.isHidden = true
		view.backgroundColor = K.Colors.appBackgroundColor

		setupToHideKeyboardOnTapOnView()
		
		guessNumberChanged()
		
		view.addSubview(guessNumberField)
		view.addSubview(promptLabel)
		view.addSubview(enterTheNumber)
		
		NSLayoutConstraint.activate([
			guessNumberField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
			guessNumberField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			guessNumberField.heightAnchor.constraint(equalToConstant: 70),
			guessNumberField.widthAnchor.constraint(equalToConstant: 300),
			
			promptLabel.topAnchor.constraint(equalTo: guessNumberField.bottomAnchor, constant: 20),
			promptLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			promptLabel.heightAnchor.constraint(equalToConstant: 50),
			
			enterTheNumber.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
			enterTheNumber.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			enterTheNumber.heightAnchor.constraint(equalToConstant: K.DrawingConstants.buttonHeight),
			enterTheNumber.widthAnchor.constraint(equalToConstant: K.DrawingConstants.buttonWidth)
		])
    }
	
	var guessNumberField: UITextField = {
		let textField = makeTextField()
		textField.addDoneButtonToKeyboard(myAction: #selector(textField.resignFirstResponder))
		textField.addTarget(nil, action: #selector(guessNumberChanged), for: .editingChanged)
		textField.backgroundColor = K.Colors.secondaryBackgroundColor
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
	
	var enterTheNumber: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Enter The Number", for: .normal)
		button.setTitleColor(UIColor.white, for: .normal)
		button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
		button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		button.backgroundColor = K.Colors.appButtonsColor
		button.makeBorderedWithShadow(cornerRadius: 25)
		button.addTarget(nil, action: #selector(enterNumberButtonPressed), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	@objc func enterNumberButtonPressed() {
		if let text = guessNumberField.text, let number = Int(text) {
			navigationController?.pushViewController(ComputerGuessViewController(selectedNumber: number, difficulty: selectedDifficulty), animated: true)
		}
	}
	
	@objc func guessNumberChanged() {
		if let text = guessNumberField.text, let number = Int(text) {
			if number >= 1 && number <= 100 {
				promptLabel.text = ""
				enterTheNumber.isEnabled = true
				UIView.animate(withDuration: 0.2) {
					self.enterTheNumber.layer.opacity = 1
				}
				return
			} else {
				promptLabel.text = "Number to guess should be from 1 to 100"
			}
		} else {
			promptLabel.text = ""
		}
		enterTheNumber.isEnabled = false
		UIView.animate(withDuration: 0.2) {
			self.enterTheNumber.layer.opacity = 0.4
		}
	}
}
