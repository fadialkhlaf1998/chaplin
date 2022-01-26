import 'dart:convert';


class Customer {
  final int? id;
  final String? dateCreated;
  final String? dateCreatedGmt;
  final String? dateModified;
  final String? dateModifiedGmt;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? role;
  final String? username;
  final Billing? billing;
  final Shipping? shipping;
  final bool? isPayingCustomer;
  final String? avatarUrl;
  Customer({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.email,
    this.firstName,
    this.lastName,
    this.role,
    this.username,
    this.billing,
    this.shipping,
    this.isPayingCustomer,
    this.avatarUrl,
  });

  Customer copyWith({
    int? id,
    String? dateCreated,
    String? dateCreatedGmt,
    String? dateModified,
    String? dateModifiedGmt,
    String? email,
    String? firstName,
    String? lastName,
    String? role,
    String? username,
    Billing? billing,
    Shipping? shipping,
    bool? isPayingCustomer,
    String? avatarUrl,
  }) {
    return Customer(
      id: id ?? this.id,
      dateCreated: dateCreated ?? this.dateCreated,
      dateCreatedGmt: dateCreatedGmt ?? this.dateCreatedGmt,
      dateModified: dateModified ?? this.dateModified,
      dateModifiedGmt: dateModifiedGmt ?? this.dateModifiedGmt,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      role: role ?? this.role,
      username: username ?? this.username,
      billing: billing ?? this.billing,
      shipping: shipping ?? this.shipping,
      isPayingCustomer: isPayingCustomer ?? this.isPayingCustomer,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date_created': dateCreated,
      'date_created_gmt': dateCreatedGmt,
      'date_modified': dateModified,
      'date_modified_gmt': dateModifiedGmt,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'role': role,
      'username': username,
      'billing': billing?.toMap(),
      'shipping': shipping?.toMap(),
      'is_paying_customer': isPayingCustomer,
      'avatar_url': avatarUrl,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id']?.toInt(),
      dateCreated: map['date_created'],
      dateCreatedGmt: map['date_created_gmt'],
      dateModified: map['date_modified'],
      dateModifiedGmt: map['date_modified_gmt'],
      email: map['email'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      role: map['role'],
      username: map['username'],
      billing: Billing.fromMap(map['billing']),
      shipping: Shipping.fromMap(map['shipping']),
      isPayingCustomer: map['is_paying_customer'],
      avatarUrl: map['avatar_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Customer(id: $id, dateCreated: $dateCreated, dateCreatedGmt: $dateCreatedGmt, dateModified: $dateModified, dateModifiedGmt: $dateModifiedGmt, email: $email, firstName: $firstName, lastName: $lastName, role: $role, username: $username, billing: $billing, shipping: $shipping, isPayingCustomer: $isPayingCustomer, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Customer &&
        o.id == id &&
        o.dateCreated == dateCreated &&
        o.dateCreatedGmt == dateCreatedGmt &&
        o.dateModified == dateModified &&
        o.dateModifiedGmt == dateModifiedGmt &&
        o.email == email &&
        o.firstName == firstName &&
        o.lastName == lastName &&
        o.role == role &&
        o.username == username &&
        o.billing == billing &&
        o.shipping == shipping &&
        o.isPayingCustomer == isPayingCustomer &&
        o.avatarUrl == avatarUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    dateCreated.hashCode ^
    dateCreatedGmt.hashCode ^
    dateModified.hashCode ^
    dateModifiedGmt.hashCode ^
    email.hashCode ^
    firstName.hashCode ^
    lastName.hashCode ^
    role.hashCode ^
    username.hashCode ^
    billing.hashCode ^
    shipping.hashCode ^
    isPayingCustomer.hashCode ^
    avatarUrl.hashCode;
  }
}


class Billing {
  final String? firstName;
  final String? lastName;
  final String? company;
  final String? address1;
  final String? address2;
  final String? city;
  final String? state;
  final String? postcode;
  final String? country;
  final String? email;
  final String? phone;
  Billing({
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
    this.email,
    this.phone,
  });

  Billing copyWith({
    String? firstName,
    String? lastName,
    String? company,
    String? address1,
    String? address2,
    String? city,
    String? state,
    String? postcode,
    String? country,
    String? email,
    String? phone,
  }) {
    return Billing(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      company: company ?? this.company,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      city: city ?? this.city,
      state: state ?? this.state,
      postcode: postcode ?? this.postcode,
      country: country ?? this.country,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'company': company,
      'address_1': address1,
      'address_2': address2,
      'city': city,
      'state': state,
      'postcode': postcode,
      'country': country,
      'email': email,
      'phone': phone,
    };
  }

  factory Billing.fromMap(Map<String, dynamic> map) {
    return Billing(
      firstName: map['first_name'],
      lastName: map['last_name'],
      company: map['company'],
      address1: map['address_1'],
      address2: map['address_2'],
      city: map['city'],
      state: map['state'],
      postcode: map['postcode'],
      country: map['country'],
      email: map['email'],
      phone: map['phone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Billing.fromJson(String source) =>
      Billing.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Billing(firstName: $firstName, lastName: $lastName, company: $company, address1: $address1, address2: $address2, city: $city, state: $state, postcode: $postcode, country: $country, email: $email, phone: $phone)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Billing &&
        o.firstName == firstName &&
        o.lastName == lastName &&
        o.company == company &&
        o.address1 == address1 &&
        o.address2 == address2 &&
        o.city == city &&
        o.state == state &&
        o.postcode == postcode &&
        o.country == country &&
        o.email == email &&
        o.phone == phone;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
    lastName.hashCode ^
    company.hashCode ^
    address1.hashCode ^
    address2.hashCode ^
    city.hashCode ^
    state.hashCode ^
    postcode.hashCode ^
    country.hashCode ^
    email.hashCode ^
    phone.hashCode;
  }
}


class Shipping {
  final String? firstName;
  final String? lastName;
  final String? company;
  final String? address1;
  final String? address2;
  final String? city;
  final String? state;
  final String? postcode;
  final String? country;
  Shipping({
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
  });

  Shipping copyWith({
    String? firstName,
    String? lastName,
    String? company,
    String? address1,
    String? address2,
    String? city,
    String? state,
    String? postcode,
    String? country,
  }) {
    return Shipping(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      company: company ?? this.company,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      city: city ?? this.city,
      state: state ?? this.state,
      postcode: postcode ?? this.postcode,
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'company': company,
      'address_1': address1,
      'address_2': address2,
      'city': city,
      'state': state,
      'postcode': postcode,
      'country': country,
    };
  }

  factory Shipping.fromMap(Map<String, dynamic> map) {
    return Shipping(
      firstName: map['first_name'],
      lastName: map['last_name'],
      company: map['company'],
      address1: map['address_1'],
      address2: map['address_2'],
      city: map['city'],
      state: map['state'],
      postcode: map['postcode'],
      country: map['country'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Shipping.fromJson(String source) =>
      Shipping.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Shipping(firstName: $firstName, lastName: $lastName, company: $company, address1: $address1, address2: $address2, city: $city, state: $state, postcode: $postcode, country: $country)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Shipping &&
        o.firstName == firstName &&
        o.lastName == lastName &&
        o.company == company &&
        o.address1 == address1 &&
        o.address2 == address2 &&
        o.city == city &&
        o.state == state &&
        o.postcode == postcode &&
        o.country == country;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
    lastName.hashCode ^
    company.hashCode ^
    address1.hashCode ^
    address2.hashCode ^
    city.hashCode ^
    state.hashCode ^
    postcode.hashCode ^
    country.hashCode;
  }
}
