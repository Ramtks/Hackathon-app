// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';



class Party {
  final String name;
  final String webSocketUrl;
  Party({
    required this.name,
    required this.webSocketUrl,
  });

  Party copyWith({
    String? name,
    String? webSocketUrl,
  }) {
    return Party(
      name: name ?? this.name,
      webSocketUrl: webSocketUrl ?? this.webSocketUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'webSocketUrl': webSocketUrl,
    };
  }

  factory Party.fromMap(Map<String, dynamic> map) {
    return Party(
      name: map['name'] as String,
      webSocketUrl: map['webSocketUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Party.fromJson(String source) => Party.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Streamer(name: $name, webSocketUrl: $webSocketUrl)';

  @override
  bool operator ==(covariant Party other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.webSocketUrl == webSocketUrl;
  }

  @override
  int get hashCode => name.hashCode ^ webSocketUrl.hashCode;
}
