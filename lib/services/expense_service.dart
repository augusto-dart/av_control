import 'dart:async';

import 'package:av_control/models/expense.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExpenseService {
  CollectionReference coll = FirebaseFirestore.instance.collection('expenses');

  Future<void> addExpense(Expense expense) {
    return coll.add(expense.toJson());
  }

  Stream<List<Expense>> getExpenses() {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return coll
        .where('userId', isEqualTo: userId)
        .orderBy('data', descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (doc) => Expense.fromJson(
                  doc.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }
}
