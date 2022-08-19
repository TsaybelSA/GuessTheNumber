//
//  ComputerGuessGameModel.swift
//  GuessTheNumber
//
//  Created by Сергей Цайбель on 18.08.2022.
//

import Foundation

class ComputerGuessGameModel {
	
	weak var delegate: GameModelDelegate?
	
	private(set) var numberOfTries = 1
		
	private(set) var selectedDifficulty: Difficulty = .hard
	
	private(set) var numberToGuess: Int
	
	private(set) var currentNumber = 50 {
		didSet {
			print(currentNumber)
		}
	}
	
	private var userScore = 0
	
	private var computerScore = 0
	
	private(set) var possibleNumbers = [Int].init(1...100)
	
	//hints
	private(set) var isShowingHint = true
	
	//maybe save to user defaults
	private(set) var showHintBeforeStart = true
	
	var informationLine: String {
		return "Computer is guessing\n\n Try \(numberOfTries)"
	}
	
	func toggleIsShowingHint() {
		isShowingHint.toggle()
	}
	
	func toggleHintBeforeStart() {
		showHintBeforeStart.toggle()
	}
	
	func guessedNumberIsGreater() {
		//if user said that number is greater, but in fact it`s less or equal
		//in this case will show alert
		if numberToGuess <= currentNumber {
			delegate?.wrongAnswer()
			return
		}
		print(currentNumber)

		numberOfTries += 1
		possibleNumbers = possibleNumbers.filter { $0 > currentNumber }
		currentNumber = selectNumber()
		delegate?.modelHasChanges()
	}
	
	func guessedNumberIsEqual() {
		if numberToGuess != currentNumber {
			delegate?.wrongAnswer()
			return
		}
		numberOfTries += 1
		
		delegate?.modelHasChanges()
		delegate?.gameOver()
	}
	
	func guessedNumberIsLess() {
		//if user said that number is less, but in fact it`s greater or equal
		//in this case will show alert
		if numberToGuess >= currentNumber {
			delegate?.wrongAnswer()
			return
		}
		numberOfTries += 1
		possibleNumbers = possibleNumbers.filter { $0 < currentNumber }
		currentNumber = selectNumber()
		delegate?.modelHasChanges()
	}
	
	func selectNumber() -> Int {
		guard !possibleNumbers.isEmpty else {
			print("Possible numbers array is empty!")
			return 0
		}
		if selectedDifficulty == .easy {
			//force unwrapped because array had been already checked is empty or no
			return possibleNumbers.randomElement()!
		} else {
			let minNumber = possibleNumbers.min()!
			let maxNumber = possibleNumbers.max()!
			let middle = Int((minNumber + maxNumber) / 2)
			
			return middle
		}
	}
	
	func userPickedNumber(_ number: Int) {
		
	}
	
	init(numberToGuess: Int) {
		self.numberToGuess = numberToGuess
	}
}

protocol GameModelDelegate: AnyObject {
	func modelHasChanges()
	func wrongAnswer()
	func gameOver()
}
