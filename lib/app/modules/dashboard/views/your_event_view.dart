import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:praujikom/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:praujikom/app/modules/dashboard/views/add_view.dart';
import 'package:praujikom/app/modules/dashboard/views/edit_view.dart';
import 'package:praujikom/app/modules/dashboard/views/event_detail_view.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class YourEventView extends GetView {
  const YourEventView({super.key});
  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());

    final ScrollController scrollController = ScrollController();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddView())?.then((_) {
            controller.getYourEvent();
          });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Your Event'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.yourEvents.isEmpty) {
            return const Center(child: Text("Tidak ada data"));
          }
          return ListView.builder(
            itemCount: controller.yourEvents.length,
            controller: scrollController,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final event = controller.yourEvents[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    'https://picsum.photos/id/${event.id}/700/300',
                    fit: BoxFit.cover,
                    height: 200,
                    width: 500,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        height: 200,
                        child: Center(child: Text('Image not found')),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    event.name!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event.description!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          event.location!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.end, // Posisi item di ujung kanan
                    children: [
                      // Tombol Edit buat ngedit event
                      TextButton.icon(
                        icon: const Icon(Icons.edit,
                            color: Colors.blue), // Ikon edit dengan warna biru
                        label: const Text('Edit',
                            style: TextStyle(
                                color: Colors.blue)), // Teks "Edit" warna biru
                        onPressed: () {
                          // Aksi kalau tombol Edit diklik
                          Get.to(
                            () => EditView(
                              id: event.id!, // Bawa ID event ke halaman Edit
                              title: event
                                  .name!, // Bawa nama event ke halaman Edit
                            ),
                          );
                        },
                      ),
                      // Tombol Delete buat hapus event
                      TextButton.icon(
                        icon: const Icon(Icons.delete,
                            color:
                                Colors.red), // Ikon delete dengan warna merah
                        label: const Text('Delete',
                            style: TextStyle(
                                color:
                                    Colors.red)), // Teks "Delete" warna merah
                        onPressed: () {
                          controller.deleteEvent(id: event.id!);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
          );
        }),
      ),
    );
  }

  ZoomTapAnimation eventList() {
    return ZoomTapAnimation(
      onTap: () {
        Get.to(() => EventDetailView(), id: 1);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            'https://picsum.photos/seed/picsum/200/300',
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
          const SizedBox(height: 16),
          Text(
            'title',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'description',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.red,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'location',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            height: 10,
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
