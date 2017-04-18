//
//  RootPageViewController.swift
//  PageViewControllerDemo
//
//  Created by PhongLe on 4/16/17.
//  Copyright © 2017 PhongLe. All rights reserved.
//

import UIKit

class Tab1PageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    @IBOutlet weak var SegmentControl: UISegmentedControl!
    var segmentCurrentIndex: Int = 0
    
    //Mảng chứ các viewController để show trong PageViewController
    lazy var viewControllerList: [UIViewController] = { ()->[UIViewController] in
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = sb.instantiateViewController(withIdentifier: "pinkVC")
        let vc2 = sb.instantiateViewController(withIdentifier: "yellowVC")
        let vc3 = sb.instantiateViewController(withIdentifier: "greenVC")
        return [vc1, vc2, vc3]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        if let firstViewController = viewControllerList.first {
            self.setViewControllers([firstViewController], direction: .reverse, animated: false, completion: nil)
        }
    }
    //Khi chuyển qua trang trước
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerList.index(of: viewController) else {
            return nil
        }
        print("pre\(vcIndex)")
        segmentCurrentIndex = vcIndex
        SegmentControl.selectedSegmentIndex = segmentCurrentIndex
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        guard viewControllerList.count > previousIndex else {
            return nil
        }
        return viewControllerList[previousIndex]
    }
    
    //Khi chuyển qua trang sau
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerList.index(of: viewController) else {
            return nil
        }
        print("nexr\(vcIndex)")
        segmentCurrentIndex = vcIndex
        SegmentControl.selectedSegmentIndex = segmentCurrentIndex
        
        let nextIndex = vcIndex + 1
        guard viewControllerList.count > nextIndex else {
            return nil
        }
        return viewControllerList[nextIndex]
    }
    //Nhấn vào segmented control
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        let moveToIndex = sender.selectedSegmentIndex
        print("here: \(segmentCurrentIndex), move to \(moveToIndex)")
        
        if moveToIndex > segmentCurrentIndex {
            setViewControllers([viewControllerList[sender.selectedSegmentIndex]], direction: .forward, animated: true, completion: nil)
            segmentCurrentIndex = moveToIndex
        }else {
            setViewControllers([viewControllerList[sender.selectedSegmentIndex]], direction: .reverse, animated: true, completion: nil)
            segmentCurrentIndex = moveToIndex
        }
    }
}
