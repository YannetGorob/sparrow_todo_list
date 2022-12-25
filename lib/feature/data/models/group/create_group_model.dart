class CreateUpdateGroupModel {
  String name;
  String description;
  CreateUpdateGroupModel({required this.name, required this.description});

  factory CreateUpdateGroupModel.fromJson(Map<String, dynamic> json) {
    return CreateUpdateGroupModel(
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
}
