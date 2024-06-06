import 'package:airpollution/models/entities/feedback_entity.dart';
import 'package:airpollution/services/fire_store_service.dart';
import 'package:flutter/foundation.dart';

class FeedbackService {
  final FireStoreService _fireStoreService = FireStoreService();

  Future createFeedBack({
    required FeedbackEntity feedback,
  }) async {
    try {
      await _fireStoreService.createFeedback(feedback);
      return true;
    } catch (e) {
      debugPrint("$e");
      return false;
    }
  }
}
