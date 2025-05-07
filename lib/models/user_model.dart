// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  bool? isverified;
  String? id;
  String? imageurl;
  String? payment;
  String? address;
  bool? allownotification;
  UserModel({
    this.firstname,
    this.lastname,
    this.email,
    this.password,
    this.isverified,
    this.id,
    this.imageurl,
    this.payment,
    this.address,
    this.allownotification,
  });

 
 

  UserModel copyWith({
    String? firstname,
    String? lastname,
    String? email,
    String? password,
    bool? isverified,
    String? id,
    String? imageurl,
    String? payment,
    String? address,
    bool? allownotification,
  }) {
    return UserModel(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      password: password ?? this.password,
      isverified: isverified ?? this.isverified,
      id: id ?? this.id,
      imageurl: imageurl ?? this.imageurl,
      payment: payment ?? this.payment,
      address: address ?? this.address,
      allownotification: allownotification ?? this.allownotification,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'isverified': isverified,
      'id': id,
      'imageurl': imageurl,
      'payment': payment,
      'address': address,
      'allownotification': allownotification,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      // firstname: map['firstname'] != null ? map['firstname'] as String : null,
      // lastname: map['lastname'] != null ? map['lastname'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      // password: map['password'] != null ? map['password'] as String : null,
      // isverified: map['isverified'] != null ? map['isverified'] as bool : null,
      id: map['uid'] != null ? map['uid'] as String : null,
      imageurl: map['imageurl'] != null ? map['imageurl'] as String : null,
      payment: map['payment'] != null ? map['payment'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      allownotification: map['allownotification'] != null ? map['allownotification'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(firstname: $firstname, lastname: $lastname, email: $email, password: $password, isverified: $isverified, id: $id, imageurl: $imageurl, payment: $payment, address: $address, allownotification: $allownotification)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.firstname == firstname &&
      other.lastname == lastname &&
      other.email == email &&
      other.password == password &&
      other.isverified == isverified &&
      other.id == id &&
      other.imageurl == imageurl &&
      other.payment == payment &&
      other.address == address &&
      other.allownotification == allownotification;
  }

  @override
  int get hashCode {
    return firstname.hashCode ^
      lastname.hashCode ^
      email.hashCode ^
      password.hashCode ^
      isverified.hashCode ^
      id.hashCode ^
      imageurl.hashCode ^
      payment.hashCode ^
      address.hashCode ^
      allownotification.hashCode;
  }
}
