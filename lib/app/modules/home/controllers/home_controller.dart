import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:praujikom/app/modules/dashboard/views/dashboard_view.dart';
import 'package:praujikom/app/modules/login/views/login_view.dart';

class HomeController extends GetxController {
  late Timer _pindah; // Deklarasi Timer sebagai variabel kelas
  final authToken = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // Membuat timer untuk memindahkan layar ke LoginView
    _pindah = Timer.periodic(
      const Duration(seconds: 4),
      (timer) => authToken.read('token') == null
          ? Get.off(
              () => const LoginView(),
              transition: Transition.leftToRight,
            )
          : Get.off(() => const DashboardView()),
    );
  }

  @override
  void onClose() {
    // Hentikan timer saat controller tidak digunakan lagi
    _pindah.cancel();
    super.onClose();
  }
}
