//
//  Notification.swift
//  Notifications
//
//  Created by Justin Spahr-Summers on 2014-09-27.
//  Copyright (c) 2014 Justin Spahr-Summers. All rights reserved.
//

import Foundation

struct Notification {
	struct Subject {
		enum Type {
			case Issue
			case PullRequest
		}
	
		let title: String
		let URL: NSURL
		let latestCommentURL: NSURL
		let type: Type?
	}
	
	enum Reason {
		case Subscribed
		case Manual
		case Author
		case Comment
		case Mention
		case TeamMention
		case StateChange
		case Assign
	}

	let ID: String
	let reason: Reason?
	let updatedAt: NSDate
	let lastReadAt: NSDate
	let repository: Repository
}