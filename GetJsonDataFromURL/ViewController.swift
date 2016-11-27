
import UIKit

class ViewController: UIViewController, URLSessionDelegate, URLSessionDownloadDelegate {
    
    var dataArray = [AnyObject]() // 儲存JSON資料
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // JSON格式資料網址
        let url: URL = NSURL(string: "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=201d8ae8-dffc-4d17-ae1f-e58d8a95b162") as! URL
        
        // 建立session設定
        let sessionWithConfigure = URLSessionConfiguration.default
        
        // 設定委任對象為自己
        let session = URLSession(configuration: sessionWithConfigure, delegate: self, delegateQueue: OperationQueue.main)
        
        // 設定下載網址
        let dataTask = session.downloadTask(with: url)
        
        dataTask.resume()
    }
    
    // 下載完成觸發的Delegate
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        do {
            // 將取得的資料轉型為JSON格式
            let dataDic = try JSONSerialization.jsonObject(with: NSData(contentsOf: location as URL)! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:[String:AnyObject]]
            
            // 將資料存放在陣列裡
            dataArray = dataDic["result"]!["results"] as! [AnyObject]
            
            // 印出取到的第一筆資料
            print("\(dataArray)")
            //            print("\(dataArray[0]["Destination"]!)")
            //            print("\(dataArray[0]["Station"]!)")
            //            print("\(dataArray[0]["UpdateTime"]!)")
            //            print("\(dataArray[0]["_id"]!)")
        } catch {
            print("Error!")
        }
    }
    
}

