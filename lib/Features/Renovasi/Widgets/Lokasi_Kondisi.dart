import 'package:flutter/material.dart';
import 'package:flutter_application_1/Features/Checkout/Widgets/Alamat_Pengiriman.dart';
import 'package:provider/provider.dart';
import '../Providers/Renovasi_Provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LokasiKondisi extends StatefulWidget {
  @override
  State<LokasiKondisi> createState() => _LokasiKondisiState();
}

class _LokasiKondisiState extends State<LokasiKondisi> {
  late TextEditingController deskripsiController;
  late TextEditingController catatanLokasiController;

  final List<String> tips = [
    "Ambil foto area secara menyeluruh",
    "Sertakan close-up kerusakan",
    "Tambahkan video jika perlu penjelasan lebih detai",
  ];

  @override
  void initState() {
    super.initState();
    final prov = Provider.of<RenovasiProvider>(context, listen: false);

    deskripsiController = TextEditingController(
      text: prov.formData.deskripsi ?? "",
    );

    catatanLokasiController = TextEditingController(
      text: prov.formData.catatanLokasi ?? "",
    );
  }

  Future<void> pickMedia(BuildContext context) async {
    await Permission.photos.request();
    await Permission.videos.request();
    final oldFiles = context.read<RenovasiProvider>().formData.media ?? [];

    if (oldFiles.length >= 4) return;

    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'mov'],
    );

    if (result != null) {
      final newFiles = result.paths.whereType<String>().toList();

      final allFile = [...oldFiles, ...newFiles];

      final limitedFiles = allFile.take(4).toList();
      context.read<RenovasiProvider>().setMedia(limitedFiles);
    }
  }

  @override
  void dispose() {
    deskripsiController.dispose();
    catatanLokasiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<RenovasiProvider>();
    final media = prov.formData.media ?? [];

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Lokasi Pengerjaan",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inria Sans",
                ),
              ),
              SizedBox(height: 10),
              AlamatPengiriman(),
              SizedBox(height: 16),
              Text(
                "Catatan Lokasi",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inria Sans",
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),

                decoration: BoxDecoration(
                  color: Color(0xffF7F8FA),

                  borderRadius: BorderRadius.circular(10),

                  border: Border.all(color: Colors.grey.shade200, width: 1),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(6),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),

                child: TextField(
                  controller: catatanLokasiController,

                  onChanged: (value) {
                    context.read<RenovasiProvider>().setCatatanLokasi(value);
                  },

                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: "Inria Sans",
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),

                  decoration: InputDecoration(
                    isCollapsed: true,

                    border: InputBorder.none,

                    hintText:
                        "Contoh: akses gang sempit, pagar warna hitam (optional)",

                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontFamily: "Inria Sans",
                      fontSize: 13,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16),
              Text(
                "Kondisi Lapangan",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inria Sans",
                ),
              ),
              SizedBox(height: 10),
              media.isEmpty
                  ? _buildEmpetyUpload(context)
                  : _buildMediaGrid(media),
              SizedBox(height: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tips :",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontFamily: "Inria Sans",
                    ),
                  ),
                  ...tips.map(
                    (tip) => Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 1,
                      ),
                      child: Text(
                        "󠁯•󠁏 $tip",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontFamily: "Inria Sans",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Deskripsi Tambahan",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inria Sans",
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),

                    decoration: BoxDecoration(
                      color: Color(0xffF7F8FA),

                      borderRadius: BorderRadius.circular(10),

                      border: Border.all(color: Colors.grey.shade200, width: 1),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(8),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),

                    child: TextField(
                      controller: deskripsiController,

                      maxLines: null,
                      minLines: 5,

                      onChanged: (value) {
                        context.read<RenovasiProvider>().setDeskripsi(value);
                      },

                      style: TextStyle(
                        color: Colors.black87,
                        fontFamily: "Inria Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),

                      decoration: InputDecoration(
                        isCollapsed: true,

                        border: InputBorder.none,

                        hintText:
                            "Jelaskan detail masalah, kondisi tambahan, kebutuhan atau pekerjaan yang Anda inginkan.",

                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontFamily: "Inria Sans",
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmpetyUpload(BuildContext context) {
    return InkWell(
      onTap: () {
        pickMedia(context);
      },
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5)],
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: SvgPicture.asset(
                  "assets/icon/cloud_upload_outline.svg",
                  width: 35,
                  height: 35,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Upload Image/Video",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontFamily: "Inria Sans",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaItem(BuildContext context, String path) {
    final isVideo =
        path.toLowerCase().endsWith('.mp4') ||
        path.toLowerCase().endsWith('.mov');

    return InkWell(
      onTap: () {
        if (isVideo) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => videoPreviewpage(videoPath: path),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (_) => Dialog(
              backgroundColor: Colors.black,
              child: Container(
                height: 400,
                child: PhotoView(imageProvider: FileImage(File(path))),
              ),
            ),
          );
        }
      },

      child: isVideo
          ? FutureBuilder<String?>(
              future: VideoThumbnail.thumbnailFile(
                video: path,
                imageFormat: ImageFormat.JPEG,
                quality: 75,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    color: Colors.black12,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (!snapshot.hasData) {
                  return Container(
                    color: Colors.black12,
                    child: Icon(Icons.play_circle_fill, size: 50),
                  );
                }

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    SizedBox.expand(
                      child: Image.file(
                        File(snapshot.data!),
                        fit: BoxFit.cover,
                      ),
                    ),

                    Center(
                      child: Icon(
                        Icons.play_circle_fill,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              },
            )
          : SizedBox.expand(child: Image.file(File(path), fit: BoxFit.cover)),
    );
  }

  Widget _buildMediaGrid(List<String> media) {
    final bool canAdd = media.length < 4;
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: canAdd ? media.length + 1 : media.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        if (canAdd && index == media.length) {
          return InkWell(
            onTap: () {
              pickMedia(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.add, color: Colors.grey),
            ),
          );
        }
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: _buildMediaItem(context, media[index]),
            ),
            Positioned(
              top: 6,
              left: 6,
              child: InkWell(
                onTap: () {
                  context.read<RenovasiProvider>().removeMedia(media[index]);
                },
                child: Icon(Icons.close, size: 20, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}

class videoPreviewpage extends StatefulWidget {
  final String videoPath;
  const videoPreviewpage({super.key, required this.videoPath});
  @override
  State<videoPreviewpage> createState() => _videoPreviewpageState();
}

class _videoPreviewpageState extends State<videoPreviewpage> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {});
        controller.play();
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            controller.value.isPlaying ? controller.pause() : controller.play();
          });
        },
        child: Icon(
          controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
