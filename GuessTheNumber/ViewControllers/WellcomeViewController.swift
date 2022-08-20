//
//  WellcomeViewController.swift
//  GuessTheNumber
//
//  Created by Сергей Цайбель on 18.08.2022.
//

import UIKit

class WellcomeViewController: UIViewController {
	
	let difficultyLevels = DifficultyLevels.allCases.map({ $0.rawValue.capitalized })
	
	var selectedDifficulty: DifficultyLevels?
	
	var tableHeight: NSLayoutConstraint?
	
	var hintsControlCenter = HintsControl()

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationController?.navigationBar.isHidden = true
		view.backgroundColor = K.Colors.appBackgroundColor
		
		view.addSubview(gameLabel)
		view.addSubview(questionmarkButton)
		view.addSubview(startGameButton)
		view.addSubview(difficultyStack)
		
		NSLayoutConstraint.activate([
			gameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
			gameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 70),
			gameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -70),
			
			questionmarkButton.bottomAnchor.constraint(equalTo: difficultyStack.topAnchor, constant: -10),
			questionmarkButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
			questionmarkButton.widthAnchor.constraint(equalToConstant: K.DrawingConstants.questionmarkButtonWidth),
			questionmarkButton.heightAnchor.constraint(equalToConstant: K.DrawingConstants.questionmarkButtonHeight),

			
			difficultyStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
			difficultyStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
			difficultyStack.bottomAnchor.constraint(equalTo: startGameButton.topAnchor, constant: -30),
			
			tableView.topAnchor.constraint(equalTo: difficultyButton.bottomAnchor),
			tableView.bottomAnchor.constraint(equalTo: difficultyStack.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: difficultyStack.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: difficultyStack.trailingAnchor),
			
			startGameButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
			startGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			startGameButton.heightAnchor.constraint(equalToConstant: K.DrawingConstants.buttonHeight),
			startGameButton.widthAnchor.constraint(equalToConstant: K.DrawingConstants.buttonWidth)
		])
	}
	
	override func viewWillLayoutSubviews() {
		tableHeight?.isActive = false
		tableHeight = tableView.heightAnchor.constraint(equalToConstant: 120)
		tableHeight?.priority = .dragThatCanResizeScene
		tableHeight?.isActive = true
		super.viewWillLayoutSubviews()
	}
		
	var gameLabel: UILabel = {
		let label = UILabel(frame: CGRect())
		label.textAlignment = .center
		label.numberOfLines = 0
		label.attributedText = "Guess The Number".makeHollowAttributedString(withSize: 50)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	lazy private var difficultyStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [difficultyButton, tableView])
		stack.axis = .vertical
		stack.autoresizesSubviews = false
		stack.contentMode = .scaleAspectFit
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	var difficultyButton: UIButton = {
		let button = UIButton(type: .system)
		button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
		button.setTitle("Select difficulty", for: .normal)
		button.setTitleColor(UIColor.white, for: .normal)
		button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
		button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		button.backgroundColor = K.Colors.appButtonsColor
		button.makeBorderedWithShadow(cornerRadius: 0)
		button.addTarget(nil, action: #selector(toggleTableViewAppearance), for: .touchUpInside)
		return button
	}()
	
	lazy private var tableView: UITableView = {
		let table = UITableView(frame: CGRect(), style: .plain)
		table.register(UITableViewCell.self, forCellReuseIdentifier: K.TableViewsCell.difficultyCell)
		table.dataSource = self
		table.delegate = self
		table.rowHeight = 40
		table.isScrollEnabled = false
		table.backgroundColor = K.Colors.secondaryButtonColor
		table.translatesAutoresizingMaskIntoConstraints = false
		return table
	}()
	
	var startGameButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Start New Game", for: .normal)
		button.setTitleColor(UIColor.white, for: .normal)
		button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
		button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		button.backgroundColor = K.Colors.appButtonsColor
		button.makeBorderedWithShadow(cornerRadius: 25)
		button.layer.opacity = 0.6
		button.addTarget(nil, action: #selector(startGameButtonPressed), for: .touchUpInside)
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
	
	@objc func toggleIsShowingHint() {
		let hintText = K.Hints.difficultySelection
		let rulesVC = HintsViewController(hintsControlCenter.showHintBeforeStart, hint: hintText) { [weak self] showHintBeforeStart in
			if self?.hintsControlCenter.showHintBeforeStart != showHintBeforeStart {
				self?.hintsControlCenter.toggleHintBeforeStart()
			}
		}
		navigationController?.pushViewController(rulesVC, animated: true)
	}
	
	@objc func toggleTableViewAppearance() {
		UIView.animate(withDuration: 0.3) {
			self.tableView.isHidden.toggle()
		}
		
		guard selectedDifficulty != nil else { return }
		UIView.animate(withDuration: 0.3) {
			self.startGameButton.layer.opacity = 1
		}
	}
	
	@objc func startGameButtonPressed() {
		if let selectedDifficulty = selectedDifficulty {
			navigationController?.pushViewController(ChooseNumberViewController(difficulty: selectedDifficulty), animated: true)
		} else {
			let alertVC = UIAlertController(title: "Please select difficulty level!", message: "After that you can start game.", preferredStyle: .alert)
			let action = UIAlertAction(title: "OK", style: .default)
			alertVC.addAction(action)
			present(alertVC, animated: true)
		}
	}
}

extension WellcomeViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return DifficultyLevels.allCases.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: K.TableViewsCell.difficultyCell, for: indexPath)
		cell.textLabel?.text = difficultyLevels[indexPath.row]
		cell.textLabel?.textAlignment = .center
		cell.textLabel?.textColor = .white
		cell.textLabel?.font = UIFont.systemFont(ofSize: 25)
		let selectedBackground = UIView()
		selectedBackground.backgroundColor = K.Colors.extraColorForButton
		cell.selectedBackgroundView = selectedBackground
		cell.backgroundColor = K.Colors.secondaryButtonColor
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		difficultyButton.setTitle(difficultyLevels[indexPath.row], for: .normal)
		selectedDifficulty = DifficultyLevels.allCases[indexPath.row]
		toggleTableViewAppearance()
	}
}
