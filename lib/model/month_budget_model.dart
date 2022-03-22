class MonthlyBudget {
  int id;
  String budget;
  String date;

  MonthlyBudget({this.id, this.budget, this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'budget': budget,
      'date': date,
    };
  }

  static MonthlyBudget fromMap(Map<String, dynamic> map) {
    return MonthlyBudget(
      id: map['id'],
      budget: map['budget'],
      date: map['date'],
    );
  }
}
