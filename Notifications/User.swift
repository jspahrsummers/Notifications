//
//  User.swift
//  Notifications
//
//  Created by Justin Spahr-Summers on 2014-09-27.
//  Copyright (c) 2014 Justin Spahr-Summers. All rights reserved.
//

import Foundation
import LlamaKit
import SwiftyJSON

struct User: JSONDecodable, Printable {
	let ID: String
	let login: String
	
	static func decode(value: JSON) -> Result<User> {
		return success(self(
			ID: value["id"].stringValue,
			login: value["login"].stringValue
		))
	}
	
	var description: String {
		return "User(\(login))"
	}
}