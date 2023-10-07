//
//  UserDataModel.swift
//  Practical_TensorIOT
//

struct UserDataModel : Codable {

    var timestamp : String?
    var fullname : String?
    var username : String?
    var emailId : String?
    var password : String?
    var bio : String?
    var imgProfilePic : String?

    enum CodingKeys: String, CodingKey {

        case timestamp = "timestamp"
        case fullname = "fullname"
        case username = "username"
        case emailId = "emailId"
        case password = "password"
        case bio = "bio"
        case imgProfilePic = "imgProfilePic"
    }

    func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(timestamp, forKey: .timestamp)
        try container.encode(fullname, forKey: .fullname)
        try container.encode(username, forKey: .username)
        try container.encode(emailId, forKey: .emailId)
        try container.encode(password, forKey: .password)
        try container.encode(bio, forKey: .bio)
        try container.encode(imgProfilePic, forKey: .imgProfilePic)
    }

    init(timestamp : String, fullname : String, username : String, emailId : String, password : String, bio : String, imgProfilePic : String) {
        self.timestamp = timestamp
        self.fullname = fullname
        self.username = username
        self.emailId = emailId
        self.password = password
        self.bio = bio
        self.imgProfilePic = imgProfilePic
    }
}

