//
//  MainScreen.swift
//  DisType
//
//  Created by Mike Kholomeev on 11/17/17.
//  Copyright © 2017 NixSolutions. All rights reserved.
//

import Foundation
import UIKit

class MainScreen: UIViewController, UITextViewDelegate {
    var delegate:HomeDelegate?
    var chatDelegate:ChatCollection?
    
    lazy var singleInputTextLineHeight: CGFloat = {
        return inputTextHeight.constant
    }()

    @IBOutlet weak var chatCollectionView: UICollectionView!
    @IBOutlet weak var sayButton: UIButton!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var phraseTableView: UITableView!
    @IBOutlet weak var inputTextHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSayButton()
        setupTextView()
        setupChatBar()
    }
    
    // MARK: - Setup
    fileprivate func setupChatBar() {
        chatCollectionView.delegate = chatDelegate
        chatCollectionView.dataSource = chatDelegate
    }

    fileprivate func setupSayButton() {
        sayButton.corner(radius: 4, width: 0)
    }

    fileprivate func setupTextView() {
        inputTextView.delegate = self
        inputTextView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }

    // MARK: - Actions
    @IBAction func deleteChatAction(_ sender: UIBarButtonItem) {
    }
    @IBAction func addChatAction(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func clearInputAction(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func toneSignalAction(_ sender: UIBarButtonItem) {
    }
    @IBAction func menuAction(_ sender: Any) {
    }
    @IBAction func speakInputAction(_ sender: Any) {
    }
    
    // MARK: - UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
    }

    // MARK: - Observations
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == "contentSize", let textView = object as? UITextView else { return }

        let contentHeight = textView.contentSize.height
        let inputBarHeight = textView.bounds.size.height

        //Center vertical alignment
        var topCorrect = (inputBarHeight - contentHeight * textView.zoomScale) / 2.0;
        topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
        textView.contentOffset = CGPoint(x: 0, y: -topCorrect)
        
        
        inputTextHeight.constant = textView.contentSize.height;
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
}
