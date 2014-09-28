//
//  GitHubClient.swift
//  Notifications
//
//  Created by Justin Spahr-Summers on 2014-09-27.
//  Copyright (c) 2014 Justin Spahr-Summers. All rights reserved.
//

import Foundation
import ReactiveCocoa

class GitHubClient {
	private let session: NSURLSession
	private let authorizationString: String

	init(username: String, password: String) {
		let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
		configuration.HTTPAdditionalHeaders = [
			"Accept": "application/vnd.github.v3+json",
			"User-Agent": "jspahrsummers/Notifications"
		]
		
		session = NSURLSession(configuration: configuration)
	
		let encodableString = "\(username):\(password)"
		let base64String = encodableString.dataUsingEncoding(NSUTF8StringEncoding)!.base64EncodedStringWithOptions(nil)

		authorizationString = "Basic \(base64String)"
	}
	
	func fetchNotifications(includeRead: Bool = false, onlyParticipating: Bool = false) -> Producer<Notification> {
		let endpoint = NSURL(string: "https://api.github.com/notifications")
		let request = NSMutableURLRequest(URL: endpoint!)
		request.setValue(authorizationString, forHTTPHeaderField: "Authorization")
		
		return session.rac_dataProducerWithRequest(request)
	}
}
