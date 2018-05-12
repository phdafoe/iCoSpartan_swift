//
//  FormTextView.swift
//  canalmovil-swift
//
//  Created by Alfonso Miranda Castro on 20/10/16.
//  Copyright Â© 2016 Everis. All rights reserved.
//

import UIKit

class FormTextView: UIView , UITextFieldDelegate{
    
    @IBOutlet private var contentView: UIView?
    @IBOutlet weak var textField: JJMaterialTextfield!
    @IBOutlet weak var showButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initializeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializeView()
    }
    
    func initializeView() {
        Bundle.main.loadNibNamed("FormTextView", owner: self, options: nil)
        
        guard let content = contentView else { return }
        
        self.addSubview(content)
        content.frame = self.bounds
        content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        showButton.addTarget(self, action: #selector(showHidePassword), for: .touchUpInside)
    }
    
    func assignPlaceholder(placeholder: String, password: Bool, showPassword: Bool) {
        assignPlaceholder(placeholder: placeholder, password: password, showPassword: showPassword, upPlaceHolder: true, color:"E74C3C")
    }
    
    func assignPlaceholder(placeholder: String, password: Bool, showPassword: Bool, upPlaceHolder: Bool, textColor: String, placeholderTextColor: UIColor, font: UIFont, phColor: String, lineColor: UIColor) {
        
        textField.isSecureTextEntry = password
        showButton.isHidden = !showPassword
        
        textField.text = ""
        
        self.textField.initTextfield(withPlaceholder: placeholder, iconActive: nil, iconEmpty: nil, textColor: textColor, with: font, lineColor: lineColor, withLineBack: lineColor, errorColor: UIColor.red, upPlaceHolder: upPlaceHolder, withImage: false, andError: true, andIsLineUp: false, phColor: phColor, andFontForPhUp: UIFont(name: "Helvetica", size:14 )!)
        
        textField.attributedPlaceholder = NSAttributedString(string:placeholder,
                                                             attributes:[kCTForegroundColorAttributeName as NSAttributedStringKey: placeholderTextColor])
    }
    
    func assignPlaceholder(placeholder: String, password: Bool, showPassword: Bool, upPlaceHolder: Bool,color: String) {
        assignPlaceholder(placeholder: placeholder, password: password, showPassword: showPassword, upPlaceHolder: upPlaceHolder, textColor: color, placeholderTextColor: UIColor(hexString:color), font: UIFont(name: "Helvetica", size:16)!, phColor: "E74C3C", lineColor: UIColor(hexString:color))
    }
    
    @objc func showHidePassword() {
        if textField.isSecureTextEntry {
            showButton.setBackgroundImage(UIImage(named:"login_ico_view_off"), for: UIControlState.normal)
        }else{
            showButton.setBackgroundImage(UIImage(named:"login_ico_view"), for: UIControlState.normal)
        }
        textField.isSecureTextEntry = !textField.isSecureTextEntry
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }
    
}


extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
