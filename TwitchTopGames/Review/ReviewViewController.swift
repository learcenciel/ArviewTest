//
//  UIViewController.swift
//  TwitchTopGames
//
//  Created by Alexander on 21.07.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Cosmos
import SnapKit
import UIKit

class ReviewViewController: UIViewController {
    
    private let ratingStarsBarView: CosmosView = {
        let ratingStarsBarView = CosmosView()
        ratingStarsBarView.rating = 4
        ratingStarsBarView.text = "Rate this app!"
        return ratingStarsBarView
    }()
    
    private lazy var reviewTextView: UITextView = {
        let reviewTextView = UITextView()
        reviewTextView.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        reviewTextView.textColor = .black
        reviewTextView.backgroundColor = .clear
        reviewTextView.layer.borderColor = UIColor.black.cgColor
        reviewTextView.layer.cornerRadius = 4
        reviewTextView.layer.borderWidth = 0.4
        reviewTextView.delegate = self
        return reviewTextView
    }()
    
    private let submitButton: UIButton = {
        let submitButton = UIButton()
        submitButton.backgroundColor = .purple
        submitButton.layer.cornerRadius = 4
        submitButton.setTitle("Submit", for: .normal)
        return submitButton
    }()
    
    private var rating: Double = 0
    private let reviewText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureViews()
    }
    
    private func configureViews() {
        self.view.addSubview(ratingStarsBarView)
        self.view.addSubview(reviewTextView)
        self.view.addSubview(submitButton)
        ratingStarsBarView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
        }
        ratingStarsBarView.didTouchCosmos = { rating in
            self.rating = rating
        }
        
        reviewTextView.snp.makeConstraints { make in
            make.top.equalTo(ratingStarsBarView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24))
            make.height.equalToSuperview().multipliedBy(0.35)
        }
        
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(reviewTextView.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.35)
        }
        submitButton.addTarget(self, action: #selector(submitButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func submitButtonTapped(_ sender: UIButton) {
        if let text = self.reviewTextView.text, text != "" {
            let review = AppReview(text: text, rating: self.rating)
            // submit review
        }
    }
}

extension ReviewViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension ReviewViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text as NSString).rangeOfCharacter(from: CharacterSet.newlines).location == NSNotFound {
            return true
        }
        reviewTextView.resignFirstResponder()
        return false
    }
}
