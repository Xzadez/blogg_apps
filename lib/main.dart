import 'package:blogg_apps/app/app_binding.dart';
import 'package:blogg_apps/app/data/controller/notification_controller.dart';
import 'package:blogg_apps/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/modules/edit/controllers/edit_controller.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: 'https://nuvtkfvsbwywnomfuzjd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im51dnRrZnZzYnd5d25vbWZ1empkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjA1ODcxNzUsImV4cCI6MjA3NjE2MzE3NX0.963SeQjxhB8tiZaaJZJRaI0xAWAWAwnthtmJZ4G5Fu4',
  );
  await Get.putAsync(() async => await SharedPreferences.getInstance());
  await NotificationController().initPushNotification();
  await NotificationController().initLocalNotification();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: AppBinding(),
    ),
  );
}

final supabase = Supabase.instance.client;
