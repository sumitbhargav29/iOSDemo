import UIKit

class PostTVC: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    var postID: Int?
    let optimizer = HeavyComputationOptimizer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setPostData(post: PostModel) {
        // Capture post ID to ensure correctness during async completion
        self.postID = post.id
        
        lblTitle.text = "\(post.id ?? 0): \(post.title ?? "")"
        
        // Check if the result is cached for this post
        if let cachedResult = optimizer.getCache(for: post.id) {
            self.lblTitle.text = "\(post.id ?? 0): \(post.title ?? "")\n\(cachedResult)"
        } else {
            // Heavy computation optimization with callback memorization
            optimizer.optimizeHeavyComputation(for: post) { [weak self] additionalDetails in
                // Check if the post ID hasn't changed before updating UI
                if self?.postID == post.id {
                    self?.lblTitle.text = "\(post.id ?? 0): \(post.title ?? "")\n\(additionalDetails)"
                }
            }
        }
    }
}
