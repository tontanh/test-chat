class Welcome {
    Welcome({
        this.id,
        this.username,
        this.email,
        this.avatarImage,
    });

    String? id;
    String? username;
    String? email;
    String? avatarImage;

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        avatarImage: json["avatarImage"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "avatarImage": avatarImage,
    };
}
