//
//  ComputerGuessViewController.swift
//  GuessTheNumber
//
//  Created by Сергей Цайбель on 18.08.2022.
//

import UIKit


class ComputerGuessViewController: UIViewController {
		
	init(selectedNumber: Int, difficulty selectedDifficulty: DifficultyLevels) {
		gameModel = ComputerGuessGameModel(numberToGuess: selectedNumber, difficulty: selectedDifficulty)
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	let gameModel: ComputerGuessGameModel
	var hintsControlCenter = HintsControl()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		navigationController?.navigationBar.isHidden = true
		navigationController?.interactivePopGestureRecognizer?.isEnabled = false

		view.backgroundColor = K.Colors.appBackgroundColor

		gameModel.delegate = self
		modelHasChanges()
		
		view.addSubview(informationLabel)
		view.addSubview(questionForNumberLabel)
		view.addSubview(buttonsStack)
		view.addSubview(questionmarkButton)
		view.addSubview(resultsBackground)
		view.addSubview(resultLabel)
		view.addSubview(goToNextScreenButton)
		
		NSLayoutConstraint.activate([
			informationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
			informationLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
			informationLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
			
			questionForNumberLabel.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 40),
			questionForNumberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			
			buttonsStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
			buttonsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
			buttonsStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
			buttonsStack.heightAnchor.constraint(equalToConstant: 100),
			
			questionmarkButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200),
			questionmarkButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
			questionmarkButton.heightAnchor.constraint(equalToConstant: K.DrawingConstants.questionmarkButtonHeight),
			questionmarkButton.widthAnchor.constraint(equalToConstant: K.DrawingConstants.questionmarkButtonWidth),
			
			resultsBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			resultsBackground.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			resultsBackground.widthAnchor.constraint(equalToConstant: 300),
			resultsBackground.heightAnchor.constraint(equalToConstant: 350),
			
			resultLabel.topAnchor.constraint(equalTo: resultsBackground.topAnchor, constant: 30),
			resultLabel.heightAnchor.constraint(equalToConstant: 200),
			resultLabel.leadingAnchor.constraint(equalTo: resultsBackground.leadingAnchor, constant: 20),
			resultLabel.trailingAnchor.constraint(equalTo: resultsBackground.trailingAnchor, constant: -20),
			
			goToNextScreenButton.bottomAnchor.constraint(equalTo: resultsBackground.bottomAnchor, constant: -30),
			goToNextScreenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			goToNextScreenButton.widthAnchor.constraint(equalToConstant: 150),
			goToNextScreenButton.heightAnchor.constraint(equalToConstant: 70)
		])
		checkIfNeedHint()
    }
	
	lazy var informationLabel: UILabel = {
		let label = UILabel()
		let text = "Computer is guessing\n\n Try \(gameModel.numberOfTries)"
		label.attributedText = text.makeHollowAttributedString(withSize: 30)
		label.numberOfLines = 0
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	var questionForNumberLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private func makeComparisonButton(from comparisonButton: ComparisonButton) -> UIButton {
		let button = UIButton(type: .system)
		button.setTitle(comparisonButton.conditionMark, for: .normal)
		button.tag = comparisonButton.id
		button.setTitleColor(.label, for: .normal)
		button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
		button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		button.makeBorderedWithShadow(cornerRadius: 25)
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
			instanceOfButton.backgroundColor = K.Colors.appButtonsColor
			stackView.addArrangedSubview(instanceOfButton)
		}
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()
		
	var resultsBackground: UIView = {
		let background = UIView()
		background.backgroundColor = K.Colors.secondaryBackgroundColor
		background.layer.cornerRadius = 25
		background.isHidden = true
		background.translatesAutoresizingMaskIntoConstraints = false
		return background
	}()
	
	private var resultLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 25)
		label.numberOfLines = 0
		label.textAlignment = .center
		label.isHidden = true
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	var goToNextScreenButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Let`s go", for: .normal)
		button.setTitleColor(UIColor.white, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
		button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		button.backgroundColor = K.Colors.appButtonsColor
		button.makeBorderedWithShadow(cornerRadius: 25)
		button.isHidden = true
		button.addTarget(nil, action: #selector(goToNextScreenButtonPressed), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	var questionmarkButton: UIButton = {
		let button = UIButton(type: .custom)
		button.setImage(UIImage(named: "question-mark"), for: .normal)
		button.tintColor = .blue
		button.addTarget(nil, action: #selector(toggleIsShowingHint), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	@objc func goToNextScreenButtonPressed() {
		let userGuessVC = UserGuessViewController(difficulty: gameModel.selectedDifficulty, computerScore: gameModel.numberOfTries)
		navigationController?.pushViewController(userGuessVC, animated: true)
	}
	
	@objc func comparisonButtonPressed(_ sender: UIButton) {
		switch sender.tag {
			case 0: gameModel.guessedNumberIsGreater()
			case 1: gameModel.guessedNumberIsEqual()
			case 2: gameModel.guessedNumberIsLess()
			default: break
		}
	}
	
	@objc func toggleIsShowingHint() {
		let hintText = K.Hints.computerGuess.makeAttibutedStringWith(size: 25, isBold: false)
		let rulesVC = HintsViewController(hintsControlCenter.showHintBeforeStart, hint: hintText) { [weak self] showHintBeforeStart in
			if self?.hintsControlCenter.showHintBeforeStart != showHintBeforeStart {
				self?.hintsControlCenter.toggleHintBeforeStart()
			}
		}
		navigationController?.pushViewController(rulesVC, animated: true)
	}
	
	func checkIfNeedHint() {
		if hintsControlCenter.showHintBeforeStart {
			toggleIsShowingHint()
		}
	}
	
	func updateQuestionLabel() {
		let resultString = NSMutableAttributedString()
		resultString.append("Your number is ".makeAttibutedStringWith(size: 30, isBold: false))
		resultString.append(String(gameModel.currentNumber).makeAttibutedStringWith(size: 40, isBold: true))
		resultString.append(" ?".makeAttibutedStringWith(size: 30, isBold: true))
		
		questionForNumberLabel.attributedText = resultString
	}
	
	func updateResultLabel() {
		let resultString = NSMutableAttributedString()
		resultString.append("Your number is ".makeAttibutedStringWith(size: 30, isBold: false))
		resultString.append("\(gameModel.currentNumber)\n".makeAttibutedStringWith(size: 30, isBold: true))
		resultString.append("Computer guessed it on the ".makeAttibutedStringWith(size: 25, isBold: false))
		
		resultString.append("\(gameModel.numberOfTries) ".makeAttibutedStringWith(size: 30, isBold: true))
		let tryOrTries = gameModel.numberOfTries > 1 ? "tries.\n" : "try.\n"
		resultString.append(tryOrTries.makeAttibutedStringWith(size: 25, isBold: false))
		resultString.append("Now is you turn to guess!".makeAttibutedStringWith(size: 30, isBold: true))
		resultLabel.attributedText = resultString
	}
}

extension ComputerGuessViewController: GameModelDelegate {
	func wrongAnswer() {
		let alert = UIAlertController(title: "You misclicked or you cheating? 🤔", message: "Anyway, compare guessed number with number from computer question and try again.", preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .default)
		alert.addAction(action)
		self.present(alert, animated: true)
	}
	
	func modelHasChanges() {
		let newText = gameModel.informationLine.makeHollowAttributedString(withSize: 30)
		informationLabel.attributedText = newText
		updateQuestionLabel()
		print(gameModel.possibleNumbers)
	}
	
	func gameOver() {
		updateResultLabel()
		
		let buttons = buttonsStack.subviews as! [UIButton]
		buttons.forEach({ $0.isEnabled = false })
		questionmarkButton.isEnabled = false
		
		resultsBackground.layer.opacity = 0
		resultLabel.layer.opacity = 0
		goToNextScreenButton.layer.opacity = 0
		
		resultsBackground.isHidden = false
		resultLabel.isHidden = false
		goToNextScreenButton.isHidden = false
		
		UIView.animate(withDuration: 0.4) {
			buttons.forEach({ $0.layer.opacity = 0.5 })
			
			self.resultsBackground.layer.opacity = 1
			self.resultLabel.layer.opacity = 1
			self.goToNextScreenButton.layer.opacity = 1
		}
	}
}
