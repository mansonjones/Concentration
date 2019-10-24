//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Manson Jones on 10/24/19.
//  Copyright © 2019 Manson Jones. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    let themes = [
        "Sports":"⚽️🏀🏈⚾️🎾🏐🏉🎱🏓⛷🎳⛳️",
        "Animals":"🐶🐔🦊🐼🦀🐪🐓🐋🐙🦄🐵",
        "Faces":"😀😂😎😫😰😴😳🤔😘😷"
    ]

    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    // true means that I did the collapse
    // false means that I did not do the collapse
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        } else if let cvc = lastSeguedToConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        }
        else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
        
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSeguedToConcentrationViewController = cvc
            }
        }
    }
}


}
