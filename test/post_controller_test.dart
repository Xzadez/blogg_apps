// test/post_controller_test.dart

import 'package:blogg_apps/app/data/controller/post_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
// Pastikan path ini benar!

// Mock Dependencies (Seperti di Langkah 1)
class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late PostController postController;
  late MockSharedPreferences mockPrefs;
  late FakeFirebaseFirestore mockFirestore;

  // Siapkan GetIt untuk meniru Get.find()
  final GetIt getIt = GetIt.instance;

  setUp(() async {
    // 1. Inisialisasi Mocks
    mockPrefs = MockSharedPreferences();
    mockFirestore = FakeFirebaseFirestore();

    // 2. Daftarkan mock ke GetIt agar bisa diakses oleh PostController
    // Kita harus menghapus instance jika sudah ada
    if (getIt.isRegistered<SharedPreferences>()) {
      getIt.unregister<SharedPreferences>();
    }
    getIt.registerSingleton<SharedPreferences>(mockPrefs);

    // 3. Daftarkan kembali dependensi GetX
    Get.reset(); // Reset binding GetX
    Get.put<SharedPreferences>(mockPrefs); // Daftarkan Mock SharedPreferences

    // 4. Inisialisasi Controller dengan Mock Firestore
    postController = PostController(firestoreInstance: mockFirestore);
  });

  // Hapus semua binding dan registrasi setelah setiap tes
  tearDown(() {
    Get.reset();
  });

  group('PostController - Update Post', () {
    const testArticleId = 'ART12345';
    const testDocId = 'firestoreDocID1';

    // TEST CASE 1: Dokumen ditemukan, update berhasil
    test('should update document if articleId exists', () async {
      // 1. Setup Awal: Tambahkan dokumen ke Mock Firestore
      await mockFirestore.collection('articles').doc(testDocId).set({
        'uid': 'userToken',
        'article_id': testArticleId,
        'header': 'Old Header',
        'content': 'Old Content',
        'imgUrl': 'oldUrl.jpg',
      });

      await postController.updatePost(
        testArticleId,
        'New Header',
        'New Content',
        'newUrl.png',
      );

      // 2. Verifikasi: Cek apakah data di Mock Firestore sudah ter-update
      final doc =
          await mockFirestore.collection('articles').doc(testDocId).get();

      expect(doc.exists, isTrue);
      expect(doc.data()?['header'], 'New Header');
      expect(doc.data()?['content'], 'New Content');
      expect(doc.data()?['imgUrl'], 'newUrl.png');
    });

    // TEST CASE 2: Dokumen tidak ditemukan, harus melempar Exception
    test('should throw Exception if articleId does not exist', () async {
      expect(
        () => postController.updatePost(
          'NON_EXISTENT_ID',
          'Header',
          'Content',
          'url',
        ),
        throwsA(isA<Exception>()),
      );
    });
  });
}
