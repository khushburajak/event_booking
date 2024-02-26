import 'dart:io';

import 'package:event_booking/api/story_api.dart';
import 'package:event_booking/models/story.dart';
import 'package:event_booking/response/story_response.dart';

class StoryRepository {
  // Story Repository to Add Story
  Future<bool> addStory(File? file, Story story) async {
    return StoryAPI().addStory(file, story);
  }

  // Story Repository to Get All Stories
  Future<StoryResponse?> getAllStories() async {
    return StoryAPI().getAllStories();
  }
}
