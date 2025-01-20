import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:praujikom/app/data/event_response.dart';
import 'package:praujikom/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:praujikom/app/modules/dashboard/views/event_detail_view.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class IndexView extends GetView {
  const IndexView({super.key});
  @override
  Widget build(BuildContext context) {
    // Menginisialisasi controller untuk Dashboard menggunakan GetX
    DashboardController controller = Get.put(DashboardController());

    // Membuat ScrollController untuk mengontrol scroll pada ListView
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event List'),
        centerTitle: true, 
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16.0), 
        child: FutureBuilder<EventResponse>(// Mengambil data event melalui fungsi getEvent dari controller
          future: controller.getEvent(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.network(
                  'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
                  repeat: true, 
                  width: MediaQuery.of(context).size.width /
                      1,
                ),
              );
            }
            if (snapshot.data!.events!.isEmpty) {
              return const Center(child: Text("Tidak ada data"));
            }

            return ListView.builder(
              itemCount: snapshot.data!.events!.length,
              controller:
                  scrollController, 
              shrinkWrap:
                  true,
              itemBuilder: (context, index) {
                return ZoomTapAnimation(
                  onTap: () {
                    Get.to(() => EventDetailView(), id: 1);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, 
                    children: [
                      Image.network(
                        'https://picsum.photos/id/${snapshot.data!.events![index].id}/700/300',
                        fit: BoxFit
                            .cover, 
                        height: 200,
                        width: 500,
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox(
                            height: 200,
                            child: Center(
                              child: Text('Image not found'),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16), 
                      Text(
                        'title',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight:
                              FontWeight.bold, // Membuat teks menjadi tebal
                        ),
                      ),
                      const SizedBox(height: 8), 
                      Text(
                        'description',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey, // Warna teks abu-abu
                        ),
                      ),
                      const SizedBox(height: 16), // Jarak antara elemen
                      Row(
                        children: [
                          // Ikon lokasi
                          const Icon(
                            Icons.location_on,
                            color: Colors.red, // Warna ikon merah
                          ),
                          const SizedBox(
                              width: 8), // Jarak antara ikon dan teks
                          Expanded(
                            child: Text(
                              'location', // Lokasi event
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black, // Warna teks hitam
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
              },
            );
          },
        ),
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
