

import UIKit

class UserModel: NSObject
{
    var email: String? = nil;
    var id: Int = 0;
    var name: String? = nil;
    var phone: String? = nil;
    var username: String? = nil;
    
    func convertToObject(dict: NSDictionary)
    {
        self.email = dict.object(forKey: "email") as? String ?? "";
        let number: NSNumber = dict.object(forKey: "id") as! NSNumber;
        self.id = number.intValue;
        self.name = dict.object(forKey: "name") as? String ?? "";
        self.phone = dict.object(forKey: "phone") as? String ?? "";
        self.username = dict.object(forKey: "username") as? String ?? "";
    }
}
