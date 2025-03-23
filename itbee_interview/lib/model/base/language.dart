class Language {
  final String code;
  final String name;

  Language({required this.code, required this.name});

  factory Language.fromJson(Map<String, dynamic> json) =>
      Language(code: json['code'], name: json['name']);

  Map<String, dynamic> toJson() => {'code': code, 'name': name};
}
