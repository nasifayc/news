import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_app/config/login_manager.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/models/user_model.dart';
import 'package:news_app/utils/static_utils.dart';
import 'package:news_app/widgets/discover/publisher_card.dart';

class Publishers extends StatefulWidget {
  const Publishers({super.key});

  @override
  State<Publishers> createState() => _PublishersState();
}

class _PublishersState extends State<Publishers> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getPublishers() async {
    final String? userId = await LoginManager.getUser();
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .collection('users')
        .where('id', isNotEqualTo: userId)
        .get();

    return querySnapshot.docs
        .map((doc) => UserModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
        future: getPublishers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return StaticUtils.getShimmerEffect(theme);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: theme.typography.titleSmall,
              ),
            );
          } else if (snapshot.hasData) {
            List<UserModel> publishers = snapshot.data!;
            if (publishers.isEmpty) {
              return Center(
                child: Text(
                  "No publishers found",
                  style: theme.typography.titleSmall,
                ),
              );
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: publishers.length,
              itemBuilder: (context, index) {
                UserModel publisher = publishers[index];
                return Row(
                  children: [
                    PublisherCard(publisher: publisher),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
