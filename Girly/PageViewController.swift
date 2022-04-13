//
//  PageViewController.swift
//  Girly
//
//  Created by Bridget Falkenhayn on 4/13/22.
//

import UIKit

class PageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        self.delegate = self
        self.dataSource = self
        setViewControllers([createJournallViewController(forPage: 0)], direction: .forward, animated: false, completion: nil)
        print("Pageview viewdid load")
    }
    func createJournallViewController(forPage page:Int ) -> JournalViewController {
        let detailViewController = storyboard!.instantiateViewController(identifier: "JournalViewController") as! JournalViewController
        detailViewController.dateIndex = page
        return detailViewController
        
        
    }


}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as? JournalViewController {
            if currentViewController.dateIndex > -100 {
                print(" swipe")
                return createJournallViewController(forPage: currentViewController.dateIndex-1)
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as? JournalViewController {
            if currentViewController.dateIndex < 100 {
                print("swipe")
                return createJournallViewController(forPage: currentViewController.dateIndex+1)
            }
        }
        return nil
    }
    
    
}
