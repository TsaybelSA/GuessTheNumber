//
//  UserGuessGameModel.swift
//  GuessTheNumber
//
//  Created by Сергей Цайбель on 19.08.2022.
//

import Foundation

class UserGuessGameModel {
	
	weak var delegate: UserGuessGameModelDelegate?
	
	let difficulty: DifficultyLevels
	
	let computerScore: Int
	
	let numberToGuess = Int.random(in: 1...100)
	
	private(set) var possibleNumbers = [Int].init(1...100)
	
	private(set) var selectedNumber: Int?
	
	private(set) var numberOfTries = 1
		
	var clue: String {
		guard let selectedNumber = selectedNumber else { return "" }
		var line = ""
		if selectedNumber > numberToGuess {
			line = "My number is less than yours."
		} else if  selectedNumber < numberToGuess {
			line = "My number is greater than yours."
		} else {
			line = "Yes, you guessed my number. 👻 \nCongratulations!"
		}
		return line
	}
	
	func userPickedNumber(_ number: Int) {
		selectedNumber = number
		print("selected number \(selectedNumber)")
		//если уровень сложности высокий - то не будет помощи в отсечении неподходящих чисел
		if difficulty != .hard {
			guard let selectedNumber = selectedNumber else { return }
			if selectedNumber > numberToGuess {
				possibleNumbers = possibleNumbers.filter { $0 < selectedNumber }
			} else if selectedNumber < numberToGuess{
				possibleNumbers = possibleNumbers.filter { $0 > selectedNumber }
			}
		}
		numberOfTries += 1
		delegate?.modelHasChanges()
		
		if selectedNumber == numberToGuess {
			delegate?.gameOver()
			return
		}
		
	}
	
	init(difficulty: DifficultyLevels, computerScore: Int) {
		self.difficulty = difficulty
		self.computerScore = computerScore
		print("\(numberToGuess)")
	}
}

protocol UserGuessGameModelDelegate: AnyObject {
	func modelHasChanges()
	func gameOver()
}
