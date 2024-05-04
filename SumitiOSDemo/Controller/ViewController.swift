//
//  ViewController.swift
//  SumitiOSDemo
//
//  Created by SamMac on 03/05/24.
//
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tblPostData: UITableView!
    
    var currentPage = 1
    var isFetching = false
    let objUserModel = UserViewModel()
    var arrPostData : [PostModel] = [] {
        didSet {
            tblPostData.reloadData()
        }
    }
    let optimizer = HeavyComputationOptimizer() // Initialize HeavyComputationOptimizer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProjectData(cntPage: currentPage)
        tblPostData.tableFooterView = UIView()
    }
    
    // Implement pagination
    func loadMoreDataIfNeeded(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            getProjectData(cntPage: currentPage)
        }
    }
}

//MARK: - UITableView Delegate & DataSource methods
extension ViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPostData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: PostTVC = tableView.dequeueReusableCell(withIdentifier: "PostTVC", for: indexPath) as? PostTVC else {
            fatalError("AddressCell cell is not found")
        }
        let post = arrPostData[indexPath.row]
        cell.setPostData(post: post, viewController: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("value of body(post data) =",arrPostData[indexPath.row].body ?? "")
 
        let MainInStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = MainInStoryboard.instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
            vc.postData = arrPostData[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        loadMoreDataIfNeeded(scrollView: scrollView)
    }
}

//MARK: - API callinng
extension ViewController {
    
    func getProjectData(cntPage: Int) {
        guard !isFetching else { return }
        isFetching = true
        DispatchQueue.main.async {
            self.view.activityStartAnimating()
            self.view.isUserInteractionEnabled = false
        }
        objUserModel.getUserDataList(currentPageVal: cntPage) { isInternet, isError, data in
            DispatchQueue.main.async { [self] in
                self.view.activityStopAnimating()
                self.view.isUserInteractionEnabled = true
                if !isInternet {
                    self.showToast(message: "Check your internet connection.")
                } else if isError {
                    self.showAlert("Error", "Error")
                } else if let data = data {
                    self.arrPostData.append(contentsOf: data)
                    self.tblPostData.reloadData()
                    self.currentPage += 1
                    self.isFetching = false
                } else {
                    self.showAlert("Error", "Error")
                }
            }
        }
    }
}
