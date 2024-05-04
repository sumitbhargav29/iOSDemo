import UIKit
 
class PostTVC: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    var viewController: ViewController?
    let optimizer = HeavyComputationOptimizer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setPostData(post: PostModel, viewController: ViewController) {
        lblTitle.text = "\(String(describing: post.id!)): \(String(describing: post.title!))"
        self.viewController = viewController
        
        // Heavy computation optimization with callback memorization
        optimizer.optimizeHeavyComputation(for: post) { additionalDetails in
            self.lblTitle.text = "\(post.id!): \(post.title!)\n\(additionalDetails)"
        }
    }
}
