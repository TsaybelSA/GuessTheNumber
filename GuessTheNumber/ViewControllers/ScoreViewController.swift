//
//  ScoreViewController.swift
//  GuessTheNumber
//
//  Created by Сергей Цайбель on 19.08.2022.
//

import UIKit

class ScoreViewController: UIViewController {

	init(computerScore: Int, userScore: Int) {
		self.computerScore = computerScore
		self.userScore = userScore
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	let computerScore: Int
	let userScore: Int
	
    override func viewDidLoad() {
        super.viewDidLoad()

		navigationController?.navigationBar.isHidden = true
		
		view.backgroundColor = K.Colors.secondaryBackgroundColor
		
		view.addSubview(labelsStack)
		view.addSubview(mainMenuButton)
		
		NSLayoutConstraint.activate([
			labelsStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			labelsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			labelsStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			labelsStack.heightAnchor.constraint(equalToConstant: view.bounds.height / 1.5),
			
			mainMenuButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
			mainMenuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			mainMenuButton.heightAnchor.constraint(equalToConstant: 50),
			mainMenuButton.widthAnchor.constraint(equalToConstant: 200)
		])
    }
	
	override func viewWillDisappear(_ animated: Bool) {
		navigationController?.interactivePopGestureRecognizer?.isEnabled = true
		super.viewWillDisappear(animated)
	}
	
	lazy private var labelsStack: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [scoreLabel, triesLabel, winerLabel])
		stackView.axis = .vertical
		stackView.distribution = .fillProportionally
		stackView.spacing = 20
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()
	
	private var scoreLabel: UILabel = {
		let label = UILabel()
		label.textColor = .label
		label.text = "Scores: "
		label.numberOfLines = 1
		label.adjustsFontSizeToFitWidth = true
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 45, weight: .bold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	lazy private var triesLabel: UILabel = {
		let label = UILabel()
		label.textColor = .label
		label.text = "Your`s tries count: \(userScore)\n Computer`s tries count: \(computerScore)"
		label.numberOfLines = 0
		label.adjustsFontSizeToFitWidth = true
		label.textAlignment = .center
		label.font = UIFont.preferredFont(forTextStyle: .title1)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	lazy private var winerLabel: UILabel = {
		let label = UILabel()
		label.textColor = .label
		label.text = computerScore < userScore ? "Computer Win 👾": "You Win 🎉"
		label.numberOfLines = 1
		label.adjustsFontSizeToFitWidth = true
		label.textAlignment = .center
		label.font = UIFont.boldSystemFont(ofSize: 30)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	var mainMenuButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Main menu", for: .normal)
		button.setTitleColor(UIColor.white, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
		button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		button.backgroundColor = K.Colors.secondaryButtonColor
		button.makeBorderedWithShadow(cornerRadius: 25)
		button.addTarget(nil, action: #selector(mainMenuButtonPressed), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	@objc func mainMenuButtonPressed() {
		guard let wellcomeVC = navigationController?.viewControllers.first else { return }
		navigationController?.popToViewController(wellcomeVC, animated: true)
	}
}
