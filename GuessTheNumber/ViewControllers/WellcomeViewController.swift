//
//  WellcomeViewController.swift
//  GuessTheNumber
//
//  Created by Сергей Цайбель on 18.08.2022.
//

import UIKit

class WellcomeViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationController?.navigationBar.isHidden = true
		view.backgroundColor = .white
		
		view.addSubview(gameLabel)
		view.addSubview(startGameButton)
		
		NSLayoutConstraint.activate([
			gameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
			gameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			
			startGameButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
			startGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			startGameButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
			startGameButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth)
		])
	}
	
	
	var gameLabel: UILabel = {
		let label = UILabel(frame: CGRect())
		label.text = "Guess The Number"
		label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	var startGameButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Start New Game", for: .normal)
		button.setTitleColor(UIColor.white, for: .normal)
		button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
		button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		button.backgroundColor = .blue
		button.layer.cornerRadius = 25
		button.addTarget(nil, action: #selector(startGameButtonPressed), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	@objc func startGameButtonPressed() {
		navigationController?.pushViewController(ChooseNumberViewController(), animated: true)
	}
}

