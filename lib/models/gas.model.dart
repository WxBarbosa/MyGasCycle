class Gas{
  final int id;
  final int kilograms;
  final String buyDate;
  final String createdAt = DateTime.now().toString();

  Gas({this.id,this.kilograms,this.buyDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kilograms': kilograms,
      'buyDate': buyDate,
      'createdAt': createdAt
    };
  }
} 