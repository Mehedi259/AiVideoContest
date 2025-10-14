class ThemeModel {
  final int id;
  final String themeName;
  final String themeCoverImageUrl;
  final String rules;
  final bool isActive;

  ThemeModel({
    required this.id,
    required this.themeName,
    required this.themeCoverImageUrl,
    required this.rules,
    required this.isActive,
  });

  factory ThemeModel.fromJson(Map<String, dynamic> json) {
    return ThemeModel(
      id: json['id'] ?? 0,
      themeName: json['theme_name'] ?? '',
      themeCoverImageUrl: json['theme_cover_image_url'] ?? '',
      rules: json['rules'] ?? '',
      isActive: json['is_active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'theme_name': themeName,
      'theme_cover_image_url': themeCoverImageUrl,
      'rules': rules,
      'is_active': isActive,
    };
  }
}