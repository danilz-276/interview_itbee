class ThemeModel {
  final int? id;
  final bool isDarkMode;

  ThemeModel({this.id, required this.isDarkMode});

  factory ThemeModel.fromJson(Map<String, dynamic> json) =>
      ThemeModel(id: json['id'], isDarkMode: json['isDarkMode'] == 1);

  Map<String, dynamic> toJson() => {'id': id, 'isDarkMode': isDarkMode ? 1 : 0};
}
