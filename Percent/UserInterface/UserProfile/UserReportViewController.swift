//
//  UserReportViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 18/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

class UserReportData: BaseData {
    var name: String? {
        return rawData["report_name"] as? String
    }
    
    var code: String? {
        return rawData["report_code"] as? String
    }
}

class UserReportViewController: BaseViewController {
    private let theScrollView = UIScrollView()
    
    private let buttonTextView = UIButton(type: .custom)
    private let labelPlaceholder = UILabel()
    private let textViewComment = UITextView()
    private var constraintTextViewHeight: NSLayoutConstraint!
    
    private let buttonCancel = UIButton(type: .custom)
    private let buttonConfirm = UIButton(type: .custom)
    
    private var selectedIndex: Int?
    
    private let dataArray: [UserReportData]
    
    private var buttons = [UserReportButton]()
    
    private let opposite_mem_idx: Int
    
    init(navigationViewEffect effect: UIVisualEffect? = nil, targetId: Int , data: [UserReportData]) {
        opposite_mem_idx = targetId
        dataArray = data
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "불량 사용자 신고"
        
        theScrollView.translatesAutoresizingMaskIntoConstraints = false
        theScrollView.delegate = self
        self.view.addSubview(theScrollView)
        
        theScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        theScrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        theScrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        theScrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.isUserInteractionEnabled = true
        theScrollView.addSubview(contentView)
        
        contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "신고사유"
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold)
        contentView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25 * QUtils.optimizeRatio()).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        
        var bottomAnchor = label.bottomAnchor
        var trailingAnchor = label.trailingAnchor
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "신고 사유를 선택하세요"
        label.textColor = #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12 * QUtils.optimizeRatio(), weight: .regular)
        contentView.addSubview(label)
        
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: trailingAnchor, constant: 4 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = label.bottomAnchor
        var constant = 16 * QUtils.optimizeRatio()
        
        for i in 0 ..< dataArray.count {
            let data = dataArray[i]
            
            let button = UserReportButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tag = i
            button.setTitle(data.name ?? "", for: .normal)
            button.addTarget(self, action: #selector(self.pressedReportButton(_:)), for: .touchUpInside)
            contentView.addSubview(button)
            
            buttons.append(button)
            
            button.topAnchor.constraint(equalTo: bottomAnchor, constant: constant).isActive = true
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
            button.heightAnchor.constraint(equalToConstant: 48 * QUtils.optimizeRatio()).isActive = true
            
            bottomAnchor = button.bottomAnchor
            constant = 8 * QUtils.optimizeRatio()
        }
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "상세내용"
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold)
        contentView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: bottomAnchor, constant: 25 * QUtils.optimizeRatio()).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        
        bottomAnchor = label.bottomAnchor
        trailingAnchor = label.trailingAnchor
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "상세내용을 적어주세요."
        label.textColor = #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7019607843, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12 * QUtils.optimizeRatio(), weight: .regular)
        contentView.addSubview(label)
        
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: trailingAnchor, constant: 4 * QUtils.optimizeRatio()).isActive = true
        
        let backView = UIView()
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.isUserInteractionEnabled = true
        backView.layer.borderColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        backView.layer.borderWidth = 1
        contentView.addSubview(backView)
        
        backView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        backView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        backView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        buttonTextView.translatesAutoresizingMaskIntoConstraints = false
        buttonTextView.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        backView.addSubview(buttonTextView)

        buttonTextView.topAnchor.constraint(equalTo: backView.topAnchor).isActive = true
        buttonTextView.bottomAnchor.constraint(equalTo: backView.bottomAnchor).isActive = true
        buttonTextView.leadingAnchor.constraint(equalTo: backView.leadingAnchor).isActive = true
        buttonTextView.trailingAnchor.constraint(equalTo: backView.trailingAnchor).isActive = true

        labelPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        labelPlaceholder.text = "내용을 입력해주세요.(최대 2000자)"
        labelPlaceholder.textColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        labelPlaceholder.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        backView.addSubview(labelPlaceholder)
        
        textViewComment.translatesAutoresizingMaskIntoConstraints = false
        textViewComment.isUserInteractionEnabled = true
        textViewComment.backgroundColor = .clear
        textViewComment.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        textViewComment.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        textViewComment.delegate = self
        textViewComment.isEditable = true
        backView.addSubview(textViewComment)

        textViewComment.topAnchor.constraint(equalTo: backView.topAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        textViewComment.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        textViewComment.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        constraintTextViewHeight = textViewComment.heightAnchor.constraint(equalToConstant: 56 * QUtils.optimizeRatio())
        constraintTextViewHeight.isActive = true
        textViewComment.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        
        labelPlaceholder.topAnchor.constraint(equalTo: textViewComment.topAnchor, constant: 7).isActive = true
        labelPlaceholder.leadingAnchor.constraint(equalTo: textViewComment.leadingAnchor, constant: 5).isActive = true
        
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.clipsToBounds = true
        buttonCancel.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)), for: .normal)
        buttonCancel.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), for: .highlighted)
        buttonCancel.setTitle("취소", for: .normal)
        buttonCancel.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonCancel.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonCancel.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonCancel.layer.cornerRadius = 24 * QUtils.optimizeRatio()
        buttonCancel.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        self.view.addSubview(buttonCancel)
        
        buttonCancel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -7 * QUtils.optimizeRatio()).isActive = true
        buttonCancel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        buttonCancel.trailingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        buttonCancel.heightAnchor.constraint(equalToConstant: buttonCancel.layer.cornerRadius * 2).isActive = true
        
        buttonConfirm.translatesAutoresizingMaskIntoConstraints = false
        buttonConfirm.clipsToBounds = true
        buttonConfirm.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1)), for: .normal)
        buttonConfirm.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.9411764706, green: 0.1921568627, blue: 0.2549019608, alpha: 1)), for: .highlighted)
        buttonConfirm.setTitle("신고하기", for: .normal)
        buttonConfirm.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonConfirm.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .highlighted)
        buttonConfirm.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonConfirm.layer.cornerRadius = buttonCancel.layer.cornerRadius
        buttonConfirm.titleLabel?.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        self.view.addSubview(buttonConfirm)
        
        buttonConfirm.topAnchor.constraint(equalTo: buttonCancel.topAnchor).isActive = true
        buttonConfirm.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 8 * QUtils.optimizeRatio()).isActive = true
        buttonConfirm.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        buttonConfirm.heightAnchor.constraint(equalTo: buttonCancel.heightAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        _ = textViewComment.resignFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        reloadContentSize()
    }
    
    override func pressedButton(_ sender: UIButton) {
        super.pressedButton(sender)
        
        switch sender {
        case buttonTextView:
            _ = textViewComment.becomeFirstResponder()
            break
            
        case buttonCancel:
            self.navigationController?.popViewController(animated: true)
            break
            
        case buttonConfirm:
            guard selectedIndex != nil else {
                InstanceMessageManager.shared.showMessage("신고 사유를 선택하세요.", margin: buttonCancel.frame.size.height + 8 * QUtils.optimizeRatio())
                break
            }
            
            let alertController = AlertPopupViewController(withTitle: "신고하기", message: "신고하시겠습니까?")
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), title: "아니오", colour: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: nil))
            alertController.addAction(action: AlertPopupAction(backgroundColour: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2941176471, alpha: 1), title: "예", colour: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .bold), completion: { (action) in
                LoadingIndicatorManager.shared.showIndicatorView()
                
                let selectedData = self.dataArray[self.selectedIndex!]
                
                var params = [String:Any]()
                params["opposite_mem_idx"] = self.opposite_mem_idx
                params["report_code"] = selectedData.code
                params["report_text"] = self.textViewComment.text
                
                let httpCient = QHttpClient()
                httpCient.request(to: RequestUrl.Report + "\(MyData.shared.mem_idx)", params: params, completion: { (isSucceed, errMessage, response) in
                    LoadingIndicatorManager.shared.hideIndicatorView()
                    
                    InstanceMessageManager.shared.showMessage("신고가 완료됐습니다.", margin: self.buttonCancel.frame.size.height + 8 * QUtils.optimizeRatio())
                    
                    self.navigationController?.popViewController(animated: true)
                })
            }))
            UIApplication.appDelegate().window?.addSubview(alertController.view)
            self.addChild(alertController)
            alertController.show()
            break
            
        default: break
        }
    }
    
    @objc private func pressedReportButton(_ sender: UserReportButton) {
        for i in 0 ..< buttons.count {
            let button = buttons[i]
            button.isSelected = button == sender
            
            selectedIndex = i
        }
    }
    
    private func reloadContentSize() {
        textViewComment.superview?.superview?.layoutIfNeeded()
        
        var contentSize = theScrollView.contentSize
        contentSize.width = self.view.frame.size.width
        contentSize.height = textViewComment.superview!.superview!.frame.maxY + buttonConfirm.frame.size.height + 16 * QUtils.optimizeRatio()
        theScrollView.contentSize = contentSize
    }
    
    @objc private func keyboardShown(notification: NSNotification) {
        guard let editingView = textViewComment.superview else { return }

        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue

        var contentSize = theScrollView.contentSize
        contentSize.height = editingView.frame.maxY + keyboardFrame.size.height + 7 * QUtils.optimizeRatio()
        theScrollView.contentSize = contentSize

        var contentOffset = theScrollView.contentOffset
        contentOffset.y = editingView.frame.maxY - theScrollView.frame.size.height + keyboardFrame.size.height - kHeightNavigationView
        theScrollView.setContentOffset(contentOffset, animated: true)
    }
    
    @objc private func keyboardHidden(notification: NSNotification) {
//        guard blockScrolling == false else {
//            blockScrolling = false
//            return
//        }

        reloadContentSize()

        var contentOffset = theScrollView.contentOffset
        contentOffset.y = theScrollView.contentSize.height - theScrollView.frame.size.height
        theScrollView.setContentOffset(contentOffset, animated: true)
    }
}

extension UserReportViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        labelPlaceholder.isHidden = textView.text.count > 0
        
        let originHeight = constraintTextViewHeight.constant
        
        let textview = UITextView(frame: textViewComment.frame)
        textview.font = textViewComment.font
        textview.textContainerInset = textViewComment.textContainerInset
        textview.text = textViewComment.text
        textview.sizeToFit()
        
        var height = textview.frame.size.height
        if textview.frame.size.height < 56 * QUtils.optimizeRatio() {
            height = 56 * QUtils.optimizeRatio()
        }
        
        textViewComment.removeConstraint(constraintTextViewHeight)
        constraintTextViewHeight = textViewComment.heightAnchor.constraint(equalToConstant: height)
        constraintTextViewHeight.isActive = true
        
        theScrollView.layoutIfNeeded()
        
        let diff = height - originHeight
        
        if diff != 0 {
            var contentOffset = theScrollView.contentOffset
            contentOffset.y += diff
            theScrollView.setContentOffset(contentOffset, animated: false)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text.count > 1999, text != "" {
            return false
        }
        
        return true
    }
}

extension UserReportViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        _ = textViewComment.resignFirstResponder()
    }
}
