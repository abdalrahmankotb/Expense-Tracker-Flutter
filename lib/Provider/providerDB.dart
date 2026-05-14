import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/Models/AddModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExpenseProvider extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  num _budget = 0;
  List<Addmodel> _expenses = [];

  bool _isLoadingBudget = true;
  bool _isLoadingExpenses = true;

  num get budget => _budget;
  List<Addmodel> get expenses => _expenses;

  bool get isLoadingBudget => _isLoadingBudget;
  bool get isLoadingExpenses => _isLoadingExpenses;

  Map<String, num> placeprices = {
    'Supermarket': 0,
    'Online Shop': 0,
    'Restaurant': 0,
    'Cafe': 0,
    'Gas Station': 0,
    'Pharmacy': 0,
    'Gym': 0,
  };
  Map<String, num> placelen = {
    'Supermarket': 0,
    'Online Shop': 0,
    'Restaurant': 0,
    'Cafe': 0,
    'Gas Station': 0,
    'Pharmacy': 0,
    'Gym': 0,
  };

  void listenToBudget() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;
    _db.collection("users").doc(userId).snapshots().listen((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data();
        final rawBudget = data?["budgit"] ?? 0;
        _budget = rawBudget;
      }
      _isLoadingBudget = false;
      notifyListeners();
    });
  }

  void listenToExpenses() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;
    _db
        .collection("users")
        .doc(userId)
        .collection("Expense")
        .snapshots()
        .listen((snapshot) {
          _expenses = snapshot.docs
              .map((doc) => Addmodel.fromMap(doc.data(), id: doc.id))
              .toList();
          _isLoadingExpenses = false;
          notifyListeners();
        });
  }

  Future<void> addBudget(num amount) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final userDoc = _db.collection("users").doc(userId);
    final snapshot = await userDoc.get();
    final rawBudget = snapshot.data()?["budgit"] ?? 0;
    final newBudget = rawBudget + amount;

    await userDoc.set({"budgit": newBudget}, SetOptions(merge: true));
  }

  Future<void> addExpense(Addmodel expense) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;
    final userDoc = _db.collection("users").doc(userId);

    final snapshot = await userDoc.get();
    final rawBudget = snapshot.data()?["budgit"] ?? 0;
    final newBudget = rawBudget - expense.price;
    await userDoc.set({"budgit": newBudget}, SetOptions(merge: true));

    final expenseCollection = userDoc.collection("Expense");
    final docRef = expenseCollection.doc();
    expense.id = docRef.id;
    await docRef.set(expense.toMap());
  }

Future<void> updateExpense(Addmodel expense) async {
  final userId = _auth.currentUser?.uid;
  if (userId == null) return;

  final userDoc = _db.collection("users").doc(userId);
  final expenseDoc = userDoc.collection("Expense").doc(expense.id);

  final oldSnapshot = await expenseDoc.get();
  if (!oldSnapshot.exists) return;

  final oldExpense = Addmodel.fromMap(oldSnapshot.data()!, id: oldSnapshot.id);

  final snapshot = await userDoc.get();
  final rawBudget = snapshot.data()?["budgit"] ?? 0;
  final difference = expense.price - oldExpense.price;
  final newBudget = rawBudget - difference;

  await userDoc.set({"budgit": newBudget}, SetOptions(merge: true));

  await expenseDoc.update(expense.toMap());
}



 Future<void> deleteExpense(Addmodel expense) async {
  final userId = _auth.currentUser?.uid;
  if (userId == null) return;

  final userDoc = _db.collection("users").doc(userId);

  final snapshot = await userDoc.get();
  final rawBudget = snapshot.data()?["budgit"] ?? 0;

  final newBudget = rawBudget + expense.price;

  await userDoc.set({"budgit": newBudget}, SetOptions(merge: true));

  await userDoc.collection("Expense").doc(expense.id).delete();
}


  Future<List<Addmodel>> getCategoriesweeklyDetails() async {
    final now = DateTime.now();
    final lastWeek = now.subtract(Duration(days: 7));
    return _expenses
        .where((e) => e.date.isAfter(lastWeek) && e.date.isBefore(now))
        .toList();
  }

  Future<List<Addmodel>> getCategoriesMonthlyDetails() async {
    final now = DateTime.now();
    final lastMonth = now.subtract(Duration(days: 30));
    return _expenses
        .where((e) => e.date.isAfter(lastMonth) && e.date.isBefore(now))
        .toList();
  }

  num getCategoriesWeeklyPrices(String category) {
    final now = DateTime.now();
    final lastWeek = now.subtract(Duration(days: 7));
    final list = _expenses
        .where((e) => e.date.isAfter(lastWeek) && e.date.isBefore(now))
        .toList();
    num total = 0;
    for (var e in list) {
      if (e.place == category) total += e.price;
    }
    return total;
  }

  num getCategoriesWekklylytotals(String category) {
    final now = DateTime.now();
    final lastWeek = now.subtract(Duration(days: 7));
    final list = _expenses
        .where((e) => e.date.isAfter(lastWeek) && e.date.isBefore(now))
        .toList();
    int count = 0;
    for (var e in list) {
      if (e.place == category) count++;
    }
    return count;
  }

  num getCategoriesMonthlyPrices(String category) {
    final now = DateTime.now();
    final lastMonth = now.subtract(Duration(days: 30));
    final list = _expenses
        .where((e) => e.date.isAfter(lastMonth) && e.date.isBefore(now))
        .toList();
    num total = 0;
    for (var e in list) {
      if (e.place == category) total += e.price;
    }
    return total;
  }

  num getCategoriesMonthlyTotals(String category) {
    final now = DateTime.now();
    final lastMonth = now.subtract(Duration(days: 30));
    final list = _expenses
        .where((e) => e.date.isAfter(lastMonth) && e.date.isBefore(now))
        .toList();
    int count = 0;
    for (var e in list) {
      if (e.place == category) count++;
    }
    return count;
  }

  num GetAvrageWeekly() {
    final now = DateTime.now();
    final lastWeek = now.subtract(Duration(days: 7));
    final list = _expenses
        .where((e) => e.date.isAfter(lastWeek) && e.date.isBefore(now))
        .toList();
    if (list.isEmpty) return 0;
    double total = 0;
    for (var e in list) total += e.price;
    return total / list.length;
  }

  num GetAvrageMonthly() {
    final now = DateTime.now();
    final lastMonth = now.subtract(Duration(days: 30));
    final list = _expenses
        .where((e) => e.date.isAfter(lastMonth) && e.date.isBefore(now))
        .toList();
    if (list.isEmpty) return 0;
    double total = 0;
    for (var e in list) total += e.price;
    return total / list.length;
  }

  Map<String, num> calculateWeeklyExpenses() {
    final now = DateTime.now();
    Map<String, num> weekly = {
      'Mon': 0,
      'Tue': 0,
      'Wed': 0,
      'Thu': 0,
      'Fri': 0,
      'Sat': 0,
      'Sun': 0,
    };
    for (var expense in _expenses) {
      final date = expense.date;
      final difference = now.difference(date).inDays;
      if (difference <= 6 && difference >= 0) {
        final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        weekly[dayNames[date.weekday - 1]] =
            (weekly[dayNames[date.weekday - 1]] ?? 0) + expense.price;
      }
    }
    return weekly;
  }

  Map<String, num> calculateMonthlyExpenses() {
    final now = DateTime.now();
    Map<String, num> monthly = {
      'Week 1': 0,
      'Week 2': 0,
      'Week 3': 0,
      'Week 4': 0,
    };
    for (var expense in _expenses) {
      final date = expense.date;
      if (date.month == now.month && date.year == now.year) {
        final weekOfMonth = ((date.day - 1) ~/ 7) + 1;
        final key = 'Week $weekOfMonth';
        monthly[key] = (monthly[key] ?? 0) + expense.price;
      }
    }
    return monthly;
  }
}
