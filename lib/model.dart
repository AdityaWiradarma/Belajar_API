class Users {
  final String nama;
  final String id;
  final String alamat;

  const Users({
    required this.nama,
    required this.id,
    required this.alamat,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      nama: json['nama'],
      id: json['id'],
      alamat: json['alamat'],
    );
  }
}