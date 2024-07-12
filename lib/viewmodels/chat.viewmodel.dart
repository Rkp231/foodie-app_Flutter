import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/data/models/message.dart';
import 'package:foodie/data/models/order.dart';
import 'package:foodie/data/models/user.dart';
import 'package:foodie/services/firebase_messaging.dart';
import 'package:foodie/viewmodels/viewmodel.dart';

class ChatViewModel extends ViewModel {
  //
  ChatViewModel(BuildContext context, this.order, this.withVendor) {
    this.viewContext = context;
  }

  //
  final Order order;
  final bool withVendor;
  TextEditingController messageTEC = new TextEditingController();
  List<Message> messages = [];
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  DatabaseReference firebaseDatabaseRef;
  DatabaseReference chatDatabaseRef;

  //
  User currentUser;
  AppNotification mFirebaseService = AppNotification();

  //
  initialise() async {
    currentUser = await appDatabase.userDao.findCurrent();
    await fetchChat();
  }

  //
  void fetchChat() async {
    firebaseDatabaseRef = firebaseDatabase.reference();
    //PLS DO NOT CHANE THE TEXT HERE
    chatDatabaseRef = firebaseDatabaseRef
        .child("orders")
        .child(order.code)
        .child("chat")
        .child(withVendor ? "customerVendor" : "customerDriver");

    //
    chatDatabaseRef.onChildAdded.listen((event) {
      //
      final chatMessage = event.snapshot.value;
      //
      messages.insert(
        0,
        Message(
          text: chatMessage["message"],
          customer: chatMessage["customer"] ?? false,
        ),
      );
      //
      notifyListeners();
    });
  }

  //
  sendMessage() async {
    //
    final message = messageTEC.text;
    //
    if (message.trim().isNotEmpty) {
      //
      setBusy(true);
      await chatDatabaseRef.push().set({
        "message": messageTEC.text,
        "customer": true,
      }).whenComplete(() {
        messageTEC.text = "";
        notifyListeners();

        //send notification to user
        mFirebaseService.sendNotificationToTopic(
          title: "New Message from ${currentUser.name}",
          body: message,
          topic: withVendor
              ? "vendor_${order.vendor.id}"
              : "${order.delveryBoyId}",
        );
      });

      //
      setBusy(false);
    }
  }
}
