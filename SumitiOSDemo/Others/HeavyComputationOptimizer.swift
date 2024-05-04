//
//  HeavyComputationOptimizer.swift
//  SumitiOSDemo
//
//  Created by SamMac on 03/05/24.
//

import Foundation

class HeavyComputationOptimizer {
    private var computationCache: [Int: String] = [:] // Cache for heavy computation results
    
    func optimizeHeavyComputation(for post: PostModel, completion: @escaping (String) -> Void) {
        let startTime = CFAbsoluteTimeGetCurrent() // Record start time
        
        // Check if the result is already cached
        if let cachedResult = computationCache[post.id ?? 0] {
            completion(cachedResult)
        } else {
            // Perform heavy computation
            DispatchQueue.global().async {
                // Simulate heavy computation
                Thread.sleep(forTimeInterval: 2) // Simulate a 2-second computation
                let result = "Additional details for post \(post.id)"
                
                // Cache the result
                self.computationCache[post.id ?? 0] = result
                
                let endTime = CFAbsoluteTimeGetCurrent() // Record end time
                let duration = endTime - startTime // Calculate duration
                
                print("Heavy computation took \(duration) seconds")
                
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
    }
    
    // Function to retrieve cached result for a post
    func getCache(for postId: Int?) -> String? {
        guard let postId = postId else {
            return nil
        }
        return computationCache[postId]
    }
}
