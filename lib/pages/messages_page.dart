import 'package:chatter_app/helpers.dart';
import 'package:chatter_app/models/models.dart';
import 'package:chatter_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import '../models/story_data.dart';
import '../widgets/avatar.dart';
import 'package:faker/faker.dart';
import 'package:chatter_app/screens/screen.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _stories()),
            SliverList(
              delegate: SliverChildBuilderDelegate(_delegate),
            ),
          ],
        ));
  }

  Widget _delegate(BuildContext contex, int index) {
    var faker = Faker();
    final date = Helpers.randomDate();

    return _MessageTile(
        messageData: MessageData(
            senderName: faker.person.name(),
            message: faker.lorem.sentence(),
            messageDate: date,
            dateMessage: Jiffy.parse('2023/03/10').fromNow(),
            profilePciture: Helpers.randomPictureUrl()));
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({required this.messageData, super.key});
  final MessageData messageData;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(ChatScreen.route(messageData));
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.2,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              //user picture
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Avatar.medium(
                  url: messageData.profilePciture,
                ),
              ),
              //user name and recive message
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        messageData.senderName,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.2,
                            wordSpacing: 1.5),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                          height: 25,
                          child: Text(
                            messageData.message,
                            style: TextStyle(
                                color: AppColors.secondary,
                                overflow: TextOverflow.ellipsis),
                          )),
                    ],
                  ),
                ),
              ),

              //time and message send number
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(messageData.dateMessage.toUpperCase()),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.secondary,
                      ),
                      child: Center(
                        child: Text(
                          "1",
                          style: TextStyle(fontSize: 11, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _stories extends StatelessWidget {
  const _stories({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 134,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 14, bottom: 16),
              child: Text(
                "Stories",
                style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textFaded,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  var faker = Faker();
                  return SizedBox(
                    width: 60,
                    child: _StoryCard(
                      storyData: StoryData(
                        name: faker.person.name(),
                        url: Helpers.randomPictureUrl(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({
    Key? key,
    required this.storyData,
  }) : super(key: key);

  final StoryData storyData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Avatar.medium(url: storyData.url),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              storyData.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                letterSpacing: 0.3,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
