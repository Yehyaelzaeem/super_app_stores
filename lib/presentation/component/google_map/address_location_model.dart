class AddressLocationModel{
  final int? id;
  final String? country;
  final String? city;
  final String? locality;
  final String? street;
  final String? bigCity;
  final String? lat;
  final String? long;

  AddressLocationModel(
      {this.country,
      this.city,
      this.id,
      this.locality,
      this.street,
      this.bigCity,
      this.lat,
      this.long});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'country': this.country,
      'city': this.city,
      'locality': this.locality,
      'street': this.street,
      'bigCity': this.bigCity,
      'lat': this.lat,
      'long': this.long,
    };
  }

  factory AddressLocationModel.fromMap(Map<String, dynamic> map) {
    return AddressLocationModel(
      id: map['id'] as int,
      country: map['country'] as String,
      city: map['city'] as String,
      locality: map['locality'] as String,
      street: map['street'] as String,
      bigCity: map['bigCity'] as String,
      lat: map['lat'] as String,
      long: map['long'] as String,
    );
  }
}