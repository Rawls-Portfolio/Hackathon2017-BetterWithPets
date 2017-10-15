//
//  CarouselViewController.swift
//  SmartNeighborhood
//
//  Created by Amanda Rawls on 10/15/17.
//  Copyright © 2017 Amanda Rawls. All rights reserved.
//

import UIKit

protocol CarouselDelegate : class {
    func updateCaption(on image: Int)
}

class CarouselViewController: UIPageViewController {

    // MARK: - Properties
    weak var captionDelegate: CarouselDelegate?
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        var array = [UIViewController]()
        
        var viewController = self.newColoredViewController("Green")
        viewController.view.tag = 0
        array.append(viewController)
        
        viewController = self.newColoredViewController("Red")
        viewController.view.tag = 1
        array.append(viewController)
        
        viewController = self.newColoredViewController("Blue")
        viewController.view.tag = 2
        array.append(viewController)
        
        return array
    }()
    
    // MARK: - View Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - Methods
    private func newColoredViewController(_ color: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Carousel", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: "\(color)ViewController")
    }

}

// MARK: - Paging View Control Delegate and Data Source Methods
extension CarouselViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
            return 0
        }

        return firstViewControllerIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,didFinishAnimating finished: Bool,previousViewControllers: [UIViewController],transitionCompleted completed: Bool){
        guard completed else { return }
        
        captionDelegate?.updateCaption(on: pageViewController.viewControllers!.first!.view.tag)
    }
}
