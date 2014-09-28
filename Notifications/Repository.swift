//
//  Repository.swift
//  Notifications
//
//  Created by Justin Spahr-Summers on 2014-09-27.
//  Copyright (c) 2014 Justin Spahr-Summers. All rights reserved.
//

import Foundation
import LlamaKit
import SwiftyJSON

struct Repository: JSONDecodable {
	let ID: String
	let name: String
	let owner: User
	
	static func decode(value: JSON) -> Result<Repository> {
		return success(self(
			ID: value["id"].stringValue,
			name: value["name"].stringValue,
			owner: User.decode(value["owner"]).value()!
		))
	}
}