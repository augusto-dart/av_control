import 'dart:async';

import 'package:av_control/models/cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CardsService {
  CollectionReference coll = FirebaseFirestore.instance.collection('cards');

  Future<String> addCard(Cards card) {
    return coll.add(card.toJson()).then((value) => value.id);
  }

  Future<Cards> getCard(String id) {
    return coll
        .doc(id)
        .get()
        .then((data) => Cards.fromJson(data.data() as Map<String, dynamic>));
  }

  Future<void> updateCard(Cards card) {
    return coll.doc(card.id).set(card.toJson());
  }

  Future<List<Cards>> getCards() {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return coll.where('userId', isEqualTo: userId).get().then(
          (event) => event.docs.map(
            (doc) {
              Cards card = Cards.fromJson(doc.data() as Map<String, dynamic>);
              card.id = doc.id;
              return card;
            },
          ).toList(),
        );
  }
}
