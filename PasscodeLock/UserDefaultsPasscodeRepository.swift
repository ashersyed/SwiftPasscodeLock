//
//  UserDefaultsPasscodeRepository.swift
//  PasscodeLock
//
//  Created by Yanko Dimitrov on 8/29/15.
//  Copyright © 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation
import UICKeyChainStore
class UserDefaultsPasscodeRepository: PasscodeRepositoryType {
    
    fileprivate let passcodeKey = "passcode.lock.passcode"
    
    fileprivate lazy var defaults: UserDefaults = {
        
        return UserDefaults.standard
    }()
  
  fileprivate lazy var keyChainStore: UICKeyChainStore = {
    
    return UICKeyChainStore(service: "sh.blink.auth")
    
  }()
  
    var hasPasscode: Bool {
        
        if passcode != nil {
            return true
        }
        
        return false
    }
    
    var passcode: [String]? {
      guard let passCodeString = keyChainStore.string(forKey: passcodeKey) else {
        return nil
      }
      
      var result = [String]()
      for scalar in passCodeString.unicodeScalars {
        result.append(String(scalar))
      }
      return result
    }
    
    func savePasscode(_ passcode: [String]) {
        var passCodeString = ""
      for code in passcode {
        passCodeString += code
      }
      keyChainStore.setString(passCodeString, forKey: passcodeKey)
    }
    
    func deletePasscode() {
        
        defaults.removeObject(forKey: passcodeKey)
        defaults.synchronize()
    }
}
