//
//  ViewController.swift
//  Compression
//
//  Created by spychatter mx on 1/24/18.
//  Copyright © 2018 trenx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		print(CompressedGene(original: "ATGAAAGCCTA").decompress())
	}


}

