class MonthlyBudget {
  int id;
  String budget;

  MonthlyBudget({this.id, this.budget});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'budget': budget,

    };
  }

  static MonthlyBudget fromMap(Map<String, dynamic> map) {
    return MonthlyBudget(
      id: map['id'],
      budget: map['budget'],

    );
  }
}
