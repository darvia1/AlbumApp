

import UIKit
import Alamofire

class Service: NSObject {
    
    func path() -> String!
    {
        return "";
    }
    
    private func getURL() -> String
    {
        return "http://jsonplaceholder.typicode.com" + self.path();
    }
    
    func GETRequest(param: AnyObject?, successBlock:((Any) -> Void)?, failureBlock:((Error) -> Void)?) -> Void
    {
        Alamofire.request(self.getURL(), method: .get, parameters: param as? Parameters)
            .validate()
            .responseJSON { response in
                switch response.result
                {
                    case .success:
                        successBlock?(response.result.value!);
                        break;
                    case .failure:
                        failureBlock?(response.result.error!);
                        break;
                    
                }
        }
    }
    
    func GetDataFromUrl(url: String, successBlock:((UIImage) -> Void)?) -> Void
{
        Alamofire.request(url).responseData { (response) in
            let data = response.result.value;
            let image = UIImage(data: data!);
            successBlock?(image!);
        }
    }
}
