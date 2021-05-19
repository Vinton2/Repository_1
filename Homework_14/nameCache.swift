import Foundation

class Name{
    static let shared = Name()
    
    private let kFirstNameKey = "Name.kFirstNameKey"
    private let kSecondNameKey = "Name.kSecondNameKey"
    
    var firstName: String?{
        set{ UserDefaults.standard.setValue(newValue, forKey: kFirstNameKey) }
        get{ return UserDefaults.standard.string(forKey: kFirstNameKey) }
    }
    
    var secondName: String?{
        set{ UserDefaults.standard.setValue(newValue, forKey: kSecondNameKey) }
        get{ return UserDefaults.standard.string(forKey: kSecondNameKey) }
    }
}
