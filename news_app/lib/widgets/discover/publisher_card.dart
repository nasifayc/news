import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/models/user_model.dart';
import 'package:news_app/screens/layouts/profiles_detail_screen.dart';
import 'package:news_app/utils/static_utils.dart';

class PublisherCard extends StatefulWidget {
  final UserModel publisher;
  const PublisherCard({super.key, required this.publisher});

  @override
  State<PublisherCard> createState() => _PublisherCardState();
}

class _PublisherCardState extends State<PublisherCard> {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
          color: theme.inputFieldBackground,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ProfilesDetailScreen(user: widget.publisher),
              ));
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    image: widget.publisher.photo == null
                        ? const AssetImage('assets/images/megaphone.png')
                        : CachedNetworkImageProvider(widget.publisher.photo!),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Text(
            '${StaticUtils.capitalize(widget.publisher.username)} News',
            style: theme.typography.titleMedium2,
            maxLines: 3,
          ),
          Container(
            height: 41,
            width: 115,
            decoration: BoxDecoration(
                color: theme.primary, borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text(
                'Follow',
                style: theme.typography.titleMedium2,
              ),
            ),
          )
        ],
      ),
    );
  }
}
