//
//  ComputerGuessViewController.swift
//  GuessTheNumber
//
//  Created by Сергей Цайбель on 18.08.2022.
//

import UIKit

enum GuessState {
	case computer, user
}

class ComputerGuessViewController: UIViewController {

	var numbersOfTries = 1
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		//for test
		navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "repeat.circle"), style: .plain, target: nil, action: #selector(changeWhoGuess))
		//
		
		view.backgroundColor = .white
		
		view.addSubview(informationLabel)
		view.addSubview(questionForNumberLabel)
		view.addSubview(buttonsStack)
		
		NSLayoutConstraint.activate([
			informationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			informationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			
			questionForNumberLabel.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 40),
			questionForNumberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			
			buttonsStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
			buttonsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
			buttonsStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
			buttonsStack.heightAnchor.constraint(equalToConstant: 100)
		])
    }
	
	lazy var informationLabel: UILabel = {
		let label = UILabel()
		label.text = "Computer is guessing\n\n Try \(numbersOfTries)"
		label.font = UIFont.systemFont(ofSize: 25)
		label.numberOfLines = 0
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	var questionForNumberLabel: UILabel = {
		let label = UILabel()
		
		let resultString = NSMutableAttributedString()
		
		var attributes = [NSAttributedString.Key: AnyObject]()
		attributes[.font] = UIFont.systemFont(ofSize: 30)
		resultString.append(NSAttributedString(string: "Your number is ", attributes: attributes))
		
		let number = "80"
		attributes[.font] = UIFont.boldSystemFont(ofSize: 40)
		resultString.append(NSAttributedString(string: number, attributes: attributes))
		
		attributes[.font] = UIFont.systemFont(ofSize: 30)
		resultString.append(NSAttributedString(string: " ?", attributes: attributes))
		
		label.attributedText = resultString
		label.numberOfLines = 0
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private func makeComparisonButton(from comparisonButton: ComparisonButton) -> UIButton {
		let button = UIButton(type: .system)
		button.setTitle(comparisonButton.conditionMark, for: .normal)
		button.tag = comparisonButton.id
		button.setTitleColor(UIColor.white, for: .normal)
		button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
		button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		button.backgroundColor = .blue
		button.layer.cornerRadius = 25
		button.addTarget(nil, action: #selector(comparisonButtonPressed), for: .touchUpInside)
		return button
	}
	
	lazy private var buttonsStack: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		stackView.spacing = 20
		for comparisonButton in ComparisonButton.buttons {
			let instanceOfButton = makeComparisonButton(from: comparisonButton)
			stackView.addArrangedSubview(instanceOfButton)
		}
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()
	
	@objc func changeWhoGuess() {
		
	}
	
	@objc func comparisonButtonPressed(_ sender: UIButton) {
		switch sender.tag {
			case 0: print("Number is higher than guessed")
			case 1: print("Number is equal with guessed")
			case 2: print("Number is less than guessed")
			default: break
		}
	}
}
