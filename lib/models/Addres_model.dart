class AddressModel {
  final String id;
  final String name;
  final String phone;
  final String address;
  final String province;
  final String city;
  final String subdistrict;
  final String district;
  final String postalCode;
  final String note;

  AddressModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.province,
    required this.city,
    required this.subdistrict,
    required this.district,
    required this.postalCode,
    this.note = '',
  });

  String get fullAddress {
    return "$address, Kec. $subdistrict, Kab. $city, Prov. $province, $postalCode";
  }
}
