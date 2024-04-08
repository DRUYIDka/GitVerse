//
//  ZnakViewController.swift
//  wordcoin3
//
//  Created by admin on 17.02.2024.
//  Copyright © 2024 admin. All rights reserved.
//

import UIKit

class ZnakViewController: UIViewController, UIScrollViewDelegate {
    
    var scrollView: UIScrollView!
    var images = [UIImage(named: "image1-1"), UIImage(named: "image2-1"), UIImage(named: "image-3-2"), UIImage(named: "image-2-2"), UIImage(named: "image-1-2")]
    var imageViews: [UIImageView] = []
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(images.count), height: view.frame.height)
        
        for (index, image) in images.enumerated() {
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: view.frame.width * CGFloat(index), y: 0, width: view.frame.width, height: view.frame.height)
            imageView.contentMode = .scaleAspectFit
            scrollView.addSubview(imageView)
            imageViews.append(imageView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let startLocation = touch.location(in: view)
        
        if startLocation.x < view.bounds.width / 5 {
            scrollToPreviousPage()
        } else if startLocation.x > view.bounds.width / 5 * 2 {
            scrollToNextPage()
        }
    }
    
    func scrollToPreviousPage() {
        if currentPage > 0 {
            currentPage -= 1
            let newOffset = CGPoint(x: CGFloat(currentPage) * scrollView.frame.size.width, y: 0)
            scrollView.setContentOffset(newOffset, animated: true)
        }
    }
    
    func scrollToNextPage() {
        if currentPage < images.count - 1 {
            currentPage += 1
            let newOffset = CGPoint(x: CGFloat(currentPage) * scrollView.frame.size.width, y: 0)
            scrollView.setContentOffset(newOffset, animated: true)
        }
    }
}
