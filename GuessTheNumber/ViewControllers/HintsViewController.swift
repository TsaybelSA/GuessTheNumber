//
//  HintsViewController.swift
//  GuessTheNumber
//
//  Created by Сергей Цайбель on 19.08.2022.
//

import UIKit

class HintsViewController: UIViewController {

	init(_ showHintBeforeStart: Bool, hint: String, complitionHandler: @escaping (Bool) -> Void) {
		self.showHintBeforeStart = showHintBeforeStart
		self.hintString = hint
		self.complitionHandler = complitionHandler
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	var complitionHandler: (Bool) -> Void
	
	var showHintBeforeStart: Bool
	
	let hintString: String
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		navigationController?.navigationBar.isHidden = true
		
		view.backgroundColor = UIColor(named: "materialGreen")
		
		view.addSubview(questionMarkImage)
		view.addSubview(hintLabel)
		view.addSubview(hintStateButton)
		view.addSubview(sureButton)

		NSLayoutConstraint.activate([
			
			questionMarkImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			questionMarkImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			questionMarkImage.heightAnchor.constraint(equalToConstant: 100),
			questionMarkImage.widthAnchor.constraint(equalToConstant: 100),

			hintLabel.topAnchor.constraint(equalTo: questionMarkImage.bottomAnchor, constant: 20),
			hintLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
			hintLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
			hintLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
						
			hintStateButton.leadingAnchor.constraint(equalTo: hintLabel.leadingAnchor),
			hintStateButton.widthAnchor.constraint(equalToConstant: 200),
			hintStateButton.heightAnchor.constraint(equalToConstant: 70),
			hintStateButton.topAnchor.constraint(equalTo: hintLabel.topAnchor),
			
			sureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			sureButton.heightAnchor.constraint(equalToConstant: 50),
			sureButton.widthAnchor.constraint(equalToConstant: 100),
			sureButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
		])
    }
    
	lazy private var hintLabel: UILabel = {
		let label = UILabel()
		label.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
		label.textColor = .white
		label.text = hintString
		label.numberOfLines = 0
		label.adjustsFontSizeToFitWidth = true
		label.textAlignment = .center
		label.layer.cornerRadius = label.bounds.height / 4
		label.layer.masksToBounds = true
		label.font = UIFont.preferredFont(forTextStyle: .title1)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	var hintStateButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle(" Show hints", for: .normal)
		button.setTitleColor(UIColor.white, for: .normal)
		button.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
		button.tintColor = .white
		button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
		button.addTarget(nil, action: #selector(toggleHintState), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	var sureButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Sure", for: .normal)
		button.setTitleColor(UIColor.white, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
		button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		button.backgroundColor = .blue
		button.layer.cornerRadius = 25
		button.addTarget(nil, action: #selector(closeView), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	var questionMarkImage: UIImageView = {
		let image = UIImage(named: "question-mark")
		let imageView = UIImageView(image: image)
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	
	@objc func toggleHintState() {
		showHintBeforeStart.toggle()
		hintStateButton.setImage(showHintBeforeStart ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square"), for: .normal)
	}
	
	@objc func closeView() {
		complitionHandler(showHintBeforeStart)
		navigationController?.popViewController(animated: true)
	}
}
