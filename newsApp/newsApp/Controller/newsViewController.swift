//
//  newsViewController.swift
//  newsApp
//
//  Created by kranthi.kumar on 31/07/22.
//

import UIKit

class newsViewController: UIViewController{

    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var getNewsModel: newsModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bringSubviewToFront(activityIndicator)
        apiHitToCallNewsArticles()
        setTableView()
    }
    
    func setTableView() {
        self.newsTableView.delegate = self
        self.newsTableView.dataSource = self
        self.newsTableView.register(UINib(nibName: "newLayoutTableViewCell", bundle: nil), forCellReuseIdentifier: "newLayoutTableViewCell")
    }

    @objc func afterdelay() {
        activityIndicator.stopAnimating()
        newsTableView.reloadData()
        newsTableView.isHidden = false
        activityIndicator.isHidden = true
        
    }
    
    
    func apiHitToCallNewsArticles() {
        newsTableView.isHidden = true
        activityIndicator.startAnimating()
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=97adac52766a476ebf6b38a7b40ed49f") else{
                return
            }


        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            if(response != nil && data != nil) {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any] {
                        print(json)
                        self.getNewsModel = newsModel(json: json)
                    }
                } catch let parseError {
                    
                    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print(jsonStr!, parseError)
                }
            } else {
                print("")
            }
        }
        task.resume()
        self.perform(#selector(self.afterdelay), with: nil, afterDelay: 3.0)
        
    }
    

}

extension newsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getNewsModel?.totalResults ?? 10
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "newLayoutTableViewCell") as! newLayoutTableViewCell
        
        let url = URL(string: getNewsModel?.articles[indexPath.row].imageURL ?? "https://techcrunch.com/wp-content/uploads/2022/07/volunteer_header.jpg?w=764")
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            cell.newsImageView.image = UIImage(data: imageData)
        }
        cell.newsLabel.text = getNewsModel?.articles[indexPath.row].title
        cell.newsAuthor.text = "Author: \(getNewsModel?.articles[indexPath.row].author ?? "")"
        cell.newsDescription.text = getNewsModel?.articles[indexPath.row].newsDescription
        cell.newsDescription.isUserInteractionEnabled = false
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 206/255, green: 255/255, blue: 92/255, alpha: 1)
        cell.selectedBackgroundView = bgColorView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webview = self.storyboard?.instantiateViewController(withIdentifier:"webViewController") as! webViewController
        webview.urlWebView = getNewsModel?.articles[indexPath.row].newsURL
        self.present(webview, animated: true, completion: nil)
    }
    
    
}
