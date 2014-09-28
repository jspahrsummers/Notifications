//
//  Notification.swift
//  Notifications
//
//  Created by Justin Spahr-Summers on 2014-09-27.
//  Copyright (c) 2014 Justin Spahr-Summers. All rights reserved.
//

import Foundation
import LlamaKit
import SwiftyJSON

struct Notification: JSONDecodable {
	struct Subject: JSONDecodable {
		enum Type: JSONDecodable {
			case Issue
			case PullRequest
			case Commit
			
			static func decode(value: JSON) -> Result<Type> {
				switch value.stringValue {
				case "Issue":
					return success(.Issue)
				case "PullRequest":
					return success(.PullRequest)
				case "Commit":
					return success(.Commit)
				default:
					return failure()
				}
			}
		}
	
		let title: String
		let URL: NSURL
		let latestCommentURL: NSURL
		let type: Type?
			
		static func decode(value: JSON) -> Result<Subject> {
			return success(self(
				title: value["title"].stringValue,
				URL: NSURL.decode(value["url"]).value()!,
				latestCommentURL: NSURL.decode(value["latest_comment_url"]).value()!,
				type: Type.decode(value["type"]).value()
			))
		}
	}
	
	enum Reason: JSONDecodable {
		case Subscribed
		case Manual
		case Author
		case Comment
		case Mention
		case TeamMention
		case StateChange
		case Assign
			
		static func decode(value: JSON) -> Result<Reason> {
			switch value.stringValue {
			case "subscribed":
				return success(.Subscribed)
			case "manual":
				return success(.Manual)
			case "author":
				return success(.Author)
			case "comment":
				return success(.Comment)
			case "mention":
				return success(.Mention)
			case "team_mention":
				return success(.TeamMention)
			case "state_change":
				return success(.StateChange)
			case "assign":
				return success(.Assign)
			default:
				return failure()
			}
		}
	}

	let ID: String
	let reason: Reason?
	let repository: Repository
	
	static func decode(value: JSON) -> Result<Notification> {
		return success(self(
			ID: value["id"].stringValue,
			reason: Reason.decode(value["reason"]).value(),
			repository: Repository.decode(value["repository"]).value()!
		))
	}
}