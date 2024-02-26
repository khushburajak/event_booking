import 'package:event_booking/models/story.dart';
import 'package:event_booking/repository/story_repository.dart';
import 'package:event_booking/response/story_response.dart';
import 'package:flutter/material.dart';
import 'package:story/story_page_view.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;

  @override
  void initState() {
    super.initState();
    indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(
        IndicatorAnimationCommand.resume);
  }

  @override
  void dispose() {
    indicatorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<StoryResponse?>(
        future: StoryRepository().getAllStories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              List<Story> lstStory = snapshot.data!.stories!;
              return StoryPageView(
                itemBuilder: (context, pageIndex, storyIndex) {
                  final story = lstStory[pageIndex];
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: Container(color: Colors.black),
                      ),
                      Positioned.fill(
                        child: Image.network(
                          story.image!.replaceAll('127.0.0.0', '192.168.1.101'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 44, left: 8),
                        child: Row(
                          children: [
                            Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(story.image!),
                                  fit: BoxFit.cover,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              story.title!,
                              style: const TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                gestureItemBuilder: (context, pageIndex, storyIndex) {
                  return Stack(children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          color: Colors.white,
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    if (pageIndex == 0)
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/addStory');
                        },
                        splashColor: const Color.fromARGB(234, 223, 210, 210),
                        child: const SizedBox(
                          height: 200,
                          width: 150,
                          child: Card(
                            elevation: 10,
                            color: Colors.blueAccent,
                            child: Icon(Icons.add_a_photo),
                          ),
                        ),
                      ),
                  ]);
                },
                indicatorAnimationController: indicatorAnimationController,
                initialStoryIndex: (pageIndex) {
                  if (pageIndex == 0) {
                    return 1;
                  }
                  return 0;
                },
                pageLength: lstStory.length,
                storyLength: (int pageIndex) {
                  return lstStory[pageIndex].title!.length;
                },
                onPageLimitReached: () {
                  Navigator.pop(context);
                },
                onPageChanged: (pageIndex) {
                  print('pageIndex: $pageIndex');
                },
              );
            } else {
              return const Center(
                child: Text("No data"),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            );
          }
        },
      ),
    );
  }
}
