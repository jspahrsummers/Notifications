//
//  JSON.swift
//  Notifications
//
//  Created by Justin Spahr-Summers on 2014-09-28.
//  Copyright (c) 2014 Justin Spahr-Summers. All rights reserved.
//

import Foundation
import LlamaKit
import SwiftyJSON

protocol JSONDecodable {
	class func decode(value: JSON) -> Result<Self>
}

extension NSURL {
	class func decode(value: JSON) -> Result<NSURL> {
		if let string = value.string {
			if let URL = NSURL(string: string) {
				return success(URL)
			}
		}
		
		return failure()
	}
}