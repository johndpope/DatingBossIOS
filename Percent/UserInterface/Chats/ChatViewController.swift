//
//  ChatViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 22/11/2018.
//  Copyright © 2018 연애대장. All rights reserved.
//

import UIKit

class ChatroomViewController: BaseViewController {
    private let theTableView = UITableView()
    
    private let footerView = UIView()
    private let textViewMessage = UITextView()
    private let buttonSend = QButton()
    
    private let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    private var keys = [String]()
    private var tableData = [String:[MessageData]]()
    
    private var phone: String
    private var chatroomData: ChatroomData!
    
    private var bottomConstraint: NSLayoutConstraint!
    private var heightConstraint: NSLayoutConstraint!
    
    private var constraintsNormal = [NSLayoutConstraint]()
    private var constraintsSending = [NSLayoutConstraint]()
    
    private var initialized = false
    
    private var isSending = false
    
    init(with aPhone: String) {
        phone = aPhone
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatroomData = ChatroomData(with: phone, messages: nil)
        
        var index: Int?
        
        if let userId = MyData.shared.userId {
            var rooms = QDataManager.shared.chatrooms[userId] ?? []
            for i in 0 ..< rooms.count  {
                let room = rooms[i]
                guard room.phone == phone else { continue }
                room.unreadCount = 0
                index = i
                chatroomData = room
            }
            
            if index != nil {
                rooms[index!] = chatroomData
                QDataManager.shared.chatrooms[userId] = rooms
                QDataManager.shared.commit()
            }
        }
        
        ((UIApplication.appDelegate().window?.rootViewController as? UINavigationController)?.viewControllers.first as? MainViewController)?.tabView.refreshNewMessageBadgeCount()
        
        theTableView.translatesAutoresizingMaskIntoConstraints = false
        theTableView.delegate = self
        theTableView.dataSource = self
        theTableView.separatorStyle = .none
        theTableView.register(ChatTableViewCell.self, forCellReuseIdentifier: "ChatReceivedTableViewCell")
        theTableView.register(ChatTableViewCell.self, forCellReuseIdentifier: "ChatSentTableViewCell")
        theTableView.estimatedRowHeight = 0
        theTableView.estimatedSectionHeaderHeight = 0
        theTableView.estimatedSectionFooterHeight = 0
        self.view.addSubview(theTableView)
        
        footerView.translatesAutoresizingMaskIntoConstraints = false
        footerView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.view.addSubview(footerView)
        
        let textview = UITextView()
        textview.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .regular)
        textview.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textview.text = ""
        textview.sizeToFit()
        
        buttonSend.translatesAutoresizingMaskIntoConstraints = false
        buttonSend.clipsToBounds = true
        buttonSend.layer.cornerRadius = textview.frame.size.height / 2
        buttonSend.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.01176470588, green: 0.6, blue: 0.8588235294, alpha: 1)), for: .normal)
        buttonSend.setBackgroundImage(UIImage.withSolid(colour: #colorLiteral(red: 0.3529411765, green: 0.3725490196, blue: 0.3843137255, alpha: 1)), for: .disabled)
        buttonSend.setTitle(kStringSend, for: .normal)
        buttonSend.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        buttonSend.titleLabel?.font = UIFont.systemFont(ofSize: 14 * QUtils.optimizeRatio(), weight: .semibold)
        buttonSend.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
        buttonSend.sizeToFit()
        footerView.addSubview(buttonSend)
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.hidesWhenStopped = true
        footerView.addSubview(indicatorView)
        
        indicatorView.topAnchor.constraint(equalTo: footerView.topAnchor).isActive = true
        indicatorView.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 18 * QUtils.optimizeRatio()).isActive = true
        indicatorView.heightAnchor.constraint(equalToConstant: 49).isActive = true
        
        textViewMessage.translatesAutoresizingMaskIntoConstraints = false
        textViewMessage.delegate = self
        textViewMessage.clipsToBounds = true
        textViewMessage.layer.borderColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        textViewMessage.layer.borderWidth = 1 / UIScreen.main.scale
        textViewMessage.layer.cornerRadius = 4 * QUtils.optimizeRatio()
        textViewMessage.isEditable = true
        textViewMessage.font = textview.font
        textViewMessage.textContainerInset = textview.textContainerInset
        footerView.addSubview(textViewMessage)
        
        buttonSend.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -18 * QUtils.optimizeRatio()).isActive = true
        buttonSend.bottomAnchor.constraint(equalTo: textViewMessage.bottomAnchor).isActive = true
        buttonSend.widthAnchor.constraint(equalToConstant: buttonSend.frame.size.width + buttonSend.layer.cornerRadius * 2).isActive = true
        buttonSend.heightAnchor.constraint(equalToConstant: buttonSend.layer.cornerRadius * 2).isActive = true
        
        var constraint = textViewMessage.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 18 * QUtils.optimizeRatio())
        constraint.isActive = true
        constraintsNormal.append(constraint)
        
        constraint = textViewMessage.leadingAnchor.constraint(equalTo: indicatorView.trailingAnchor, constant: 18 * QUtils.optimizeRatio())
        constraintsSending.append(constraint)
        
        textViewMessage.trailingAnchor.constraint(equalTo: buttonSend.leadingAnchor, constant: -8 * QUtils.optimizeRatio()).isActive = true
        textViewMessage.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        heightConstraint = textViewMessage.heightAnchor.constraint(equalToConstant: textview.frame.size.height)
        heightConstraint.isActive = true
        
        footerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        footerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bottomConstraint = footerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        bottomConstraint.isActive = true
        footerView.heightAnchor.constraint(equalTo: textViewMessage.heightAnchor, multiplier: 1.0, constant: 16 * QUtils.optimizeRatio()).isActive = true
        
        theTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        theTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        theTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        theTableView.bottomAnchor.constraint(equalTo: footerView.topAnchor).isActive = true
        
        self.view.layoutIfNeeded()
        
        reloadData()
        reloadTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.gotNewMessage(_:)), name: NOTIFICATION_NEWMESSAGE, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NOTIFICATION_NEWMESSAGE, object: nil)
        _ = textViewMessage.resignFirstResponder()
    }
    
    override func pressedButton(_ sender: UIButton) {
        super.pressedButton(sender)
        
        if sender == buttonSend {
            guard AFNetworkReachabilityManager.shared().isReachable else {
                let alertController = UIAlertController(title: kStringAppName, message: kStringErrorUnknown, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: kStringConfirm, style: .cancel, handler: {(action) -> Void in
                    UIApplication.appDelegate().gotoLogin()
                }))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            guard MyData.shared.session.dueDay ?? 0 > 0 else {
                let message = MyData.shared.session.message ?? kStringErrorUnknown
                let alertController = UIAlertController(title: kStringAppName, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: kStringConfirm, style: .cancel, handler: {(action) -> Void in
                    if message == kStringErrorUnknown {
                        UIApplication.appDelegate().gotoLogin()
                    }
                }))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            guard let message = textViewMessage.text, message.count > 0, let smsSVRURL = MyData.shared.session.smsSVRURL, let userId = MyData.shared.userId, let myPhone = MyData.shared.session.sipID?.replacingOccurrences(of: "-", with: "") else {
                return
            }
            
            var header =  [String:Any]()
            header["password"] = MyData.shared.session.sipPW
            
            var params = [String:Any]()
            params["message"] = message
            //            params["to"] = phone.replacingOccurrences(of: "-", with: "")
            params["to"] = phone.replacingOccurrences(of: "-", with: "")
            
            let update = {() -> Void in
                self.textViewMessage.text = nil
                
                let newData = MessageData(isMine: true, phone: nil, content: message)
                
                let formatter = DateFormatter()
                //                formatter.dateFormat = "yyyy-MM-dd" + kStringChatroomToday
                formatter.dateFormat = "yyyy-MM-dd"
                let key = formatter.string(from: Date())
                
                if self.keys.firstIndex(of: key) == nil {
                    self.keys.append(key)
                }
                
                var dataArray = self.tableData[key] ?? [MessageData]()
                dataArray.append(newData)
                self.tableData[key] = dataArray
                
                self.saveMessages(for: userId)
                
                self.theTableView.reloadData()
                
                self.view.layoutIfNeeded()
                
                guard self.theTableView.frame.size.height < self.theTableView.contentSize.height else { return }
                
                self.theTableView.scrollToRow(at: IndexPath(row: (self.tableData[self.keys.last ?? ""]?.count ?? 1) - 1, section: self.keys.count - 1), at: .bottom, animated: true)
            }
            
            textViewMessage.isEditable = false
            isSending = true
            
            indicatorView.startAnimating()
            
            for constraint in constraintsNormal {
                constraint.isActive = false
            }
            
            for constraint in constraintsSending {
                constraint.isActive = true
            }
            
            footerView.layoutIfNeeded()
            
            let httpClient = QHttpClient()
            httpClient.request(to: url, method: .put, headerValues: header, params: params, completion: {(isSucceed, errMessage,  response) -> Void in
                self.textViewMessage.isEditable = true
                self.isSending = false
                
                self.indicatorView.stopAnimating()
                
                for constraint in self.constraintsNormal {
                    constraint.isActive = true
                }
                
                for constraint in self.constraintsSending {
                    constraint.isActive = false
                }
                
                self.footerView.layoutIfNeeded()
                
                guard isSucceed else {
                    let alertController = UIAlertController(title: kStringAppName, message: kStringErrorUnknown, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: kStringConfirm, style: .cancel, handler: {(action) -> Void in
                        if message == kStringErrorUnknown {
                            UIApplication.appDelegate().gotoLogin()
                        }
                    }))
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                
                update()
            })
        }
    }
    
    private func saveMessages(for userId: String) {
        var messageArray = [MessageData]()
        
        for akey in self.keys {
            guard let arr = self.tableData[akey] else { continue }
            messageArray.append(contentsOf: arr)
        }
        
        self.chatroomData.messages = messageArray
        
        var index: Int?
        var chatrooms = QDataManager.shared.chatrooms[userId] ?? []
        for i in 0 ..< chatrooms.count {
            let room = chatrooms[i]
            guard room.phone ?? "" == self.chatroomData.phone?.replacingOccurrences(of: "-", with: "") else { continue }
            index = i
            break
        }
        
        if index != nil {
            _ = chatrooms.remove(at: index!)
        }
        chatrooms.insert(self.chatroomData, at: 0)
        QDataManager.shared.chatrooms[userId] = chatrooms
        QDataManager.shared.commit()
    }
    
    @objc private func gotNewMessage(_ notification: Notification) {
        guard let dict = notification.object as? [String:Any], let ph = dict["phone"] as? String, ph == phone, let msg = dict["message"] as? String else { return }
        
        var index: Int?
        
        if let userId = MyData.shared.userId {
            var rooms = QDataManager.shared.chatrooms[userId] ?? []
            for i in 0 ..< rooms.count  {
                let room = rooms[i]
                guard room.phone == phone else { continue }
                room.unreadCount = 0
                index = i
                chatroomData = room
            }
            
            if index != nil {
                rooms[index!] = chatroomData
                QDataManager.shared.chatrooms[userId] = rooms
                QDataManager.shared.commit()
            }
        }
        
        DispatchQueue.main.async {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            //            let key = formatter.string(from: Date()) + kStringChatroomToday
            let key = formatter.string(from: Date())
            if self.keys.firstIndex(of: key) == nil {
                self.keys.append(key)
            }
            
            var dataArray = self.tableData[key] ?? []
            let row = dataArray.count
            dataArray.append(MessageData(isMine: false, phone: self.phone, content: msg))
            
            //                let indexPath = IndexPath(row: row, section: self.keys.count - 1)
            
            self.tableData[key] = dataArray
            self.theTableView.reloadData()
            
            print(self.theTableView.frame.size.height)
            print(self.theTableView.contentSize.height)
            
            self.view.layoutIfNeeded()
            
            guard self.theTableView.frame.size.height < self.theTableView.contentSize.height else { return }
            
            self.theTableView.scrollToRow(at: IndexPath(row: (self.tableData[self.keys.last ?? ""]?.count ?? 1) - 1, section: self.keys.count - 1), at: .bottom, animated: true)
            //            self.theTableView.performBatchUpdates({
            //                let formatter = DateFormatter()
            //                formatter.dateFormat = "yyyy-MM-dd"
            //                let key = formatter.string(from: Date()) + kStringChatroomToday
            //                if self.keys.firstIndex(of: key) == nil {
            //                    self.keys.append(key)
            //                }
            //
            //                var dataArray = self.tableData[key] ?? []
            //                let row = dataArray.count
            //                dataArray.append(MessageData(isMine: false, phone: self.phone, content: msg))
            //
            //                let indexPath = IndexPath(row: row, section: self.keys.count - 1)
            //
            //                self.tableData[key] = dataArray
            //                self.theTableView.insertRows(at: [indexPath], with: .left)
            //            }, completion: {(complete) -> Void in
            //            })
        }
    }
    
    private func reloadTitle() {
        guard let mainViewController = (UIApplication.appDelegate().window?.rootViewController as? UINavigationController)?.viewControllers.first as? MainViewController, let contacts = mainViewController.contacts else {
            self.title = self.phone.formattedPhoneNumber
            return
        }
        
        var name: String?
        for contact in contacts {
            guard let ph = contact.phone?.replacingOccurrences(of: "-", with: ""), ph == phone.replacingOccurrences(of: "-", with: "") else {continue}
            
            name = contact.name
        }
        
        if name == nil, let phone = chatroomData.phone {
            name = phone.formattedPhoneNumber
        }
        
        self.title = name
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.initialized = true
            
            self.keys.removeAll()
            self.tableData.removeAll()
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            let messages = self.chatroomData.messages.sorted { (a, b) -> Bool in
                return a.timeInterval < b.timeInterval
            }
            
            for i in 0 ..< messages.count {
                let data = messages[i]
                let date = Date(timeIntervalSince1970: data.timeInterval)
                
                var key = formatter.string(from: date)
                //                if date.daysFrom(Date()) == 0 {
                //                    key += kStringChatroomToday
                //                } else if date.daysFrom(Date()) == 1 {
                //                    key += kStringChatroomYesterday
                //                }
                
                if self.keys.firstIndex(of: key) == nil {
                    self.keys.append(key)
                }
                
                var dataArray = self.tableData[key] ?? [MessageData]()
                dataArray.append(data)
                self.tableData[key] = dataArray
            }
            
            self.theTableView.reloadData()
            
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
            
            guard self.theTableView.frame.size.height < self.theTableView.contentSize.height else { return }
            
            self.theTableView.scrollToRow(at: IndexPath(row: (self.tableData[self.keys.last ?? ""]?.count ?? 1) - 1, section: self.keys.count - 1), at: .bottom, animated: true)
        }
    }
    
    @objc private func keyboardShown(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        UIView.animate(withDuration: 0.3, animations: {
            self.bottomConstraint.constant = -keyboardFrame.size.height + self.view.safeAreaInsets.bottom
            self.view.layoutIfNeeded()
            
            guard self.theTableView.frame.size.height < self.theTableView.contentSize.height else { return }
            
            self.theTableView.scrollToRow(at: IndexPath(row: (self.tableData[self.keys.last ?? ""]?.count ?? 1) - 1, section: self.keys.count - 1), at: .bottom, animated: true)
        }, completion: { (complete) in
        })
    }
}

extension ChatroomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = textViewMessage.resignFirstResponder()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return keys.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36 * QUtils.optimizeRatio()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: self.tableView(tableView, heightForHeaderInSection: section)))
        headerView.backgroundColor = tableView.backgroundColor
        
        let title = keys[section]
        //        if title.range(of: kStringChatroomToday) != nil {
        //            title = kStringChatroomToday
        //        } else if title.range(of: kStringChatroomYesterday) != nil {
        //            title = kStringChatroomYesterday
        //        }
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.textColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 13 * QUtils.optimizeRatio(), weight: .regular)
        headerView.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        
        var seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        headerView.addSubview(seperator)
        
        seperator.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 18 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -18 * QUtils.optimizeRatio()).isActive = true
        seperator.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale).isActive = true
        
        seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        headerView.addSubview(seperator)
        
        seperator.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 18 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -18 * QUtils.optimizeRatio()).isActive = true
        seperator.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale).isActive = true
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < keys.count else { return 0 }
        let key = keys[section]
        return tableData[key]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath.section < keys.count else { return 0 }
        return 32
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath.section < keys.count else { return 0 }
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section < keys.count,
            let dataArray = tableData[keys[indexPath.section]],
            indexPath.row < dataArray.count else { return UITableViewCell() }
        
        let data = dataArray[indexPath.row]
        let identifier = data.isMine ? "ChatSentTableViewCell" : "ChatReceivedTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ChatTableViewCell else { return UITableViewCell() }
        cell.data = data
        return cell
    }
}

extension ChatroomViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        _ = textViewMessage.resignFirstResponder()
    }
}

extension ChatroomViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return !isSending
    }
    
    func textViewDidChange(_ textView: UITextView) {
        var height = heightConstraint.constant
        
        let textview = UITextView(frame: textViewMessage.frame)
        textview.font = textViewMessage.font
        textview.textContainerInset = textViewMessage.textContainerInset
        textview.text = textViewMessage.text
        textview.sizeToFit()
        print(textview.frame)
        
        if textview.frame.size.height < 180 * QUtils.optimizeRatio() {
            height = textview.frame.size.height
        }
        
        textViewMessage.removeConstraint(heightConstraint)
        heightConstraint = textViewMessage.heightAnchor.constraint(equalToConstant: height)
        heightConstraint.isActive = true
        
        self.view.layoutIfNeeded()
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        UIView.animate(withDuration: 0.3) {
            self.bottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
        
        return true
    }
}
