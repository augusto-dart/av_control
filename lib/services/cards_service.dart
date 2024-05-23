import 'dart:async';

import 'package:av_control/models/cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CardsService {
  CollectionReference coll = FirebaseFirestore.instance.collection('cards');

  Future<void> addCard(Cards card) {
    return coll.add(card.toJson());
  }

  Stream<List<Cards>> getCards() {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return coll.where('userId', isEqualTo: userId).snapshots().map(
          (event) => event.docs
              .map(
                (doc) => Cards.fromJson(
                  doc.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }
}
