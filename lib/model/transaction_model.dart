class TransactionModel {
  int id;
  String name;
  String description;
  String price;
  String date;
  String total;
  bool isIncome;

  TransactionModel({
    this.id,
    this.name,
    this.description,
    this.date,
    this.price,
    this.total,
    this.isIncome = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'date': date,
      'total': total,
      'isIncome': isIncome ? true : false, // 'checked': checked
    };
  }

  static TransactionModel fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      date: map['date'],
      total: map['total'],
      isIncome: map['isIncome'] == 1 ? true : false,

      // checked: map['checked'],
    );
  }
}
