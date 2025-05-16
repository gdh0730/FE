import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:heal_lo/widgets/commons/app_bar.dart';
import 'package:heal_lo/widgets/features/weekly_reports/gemini_summary.dart';
import 'package:heal_lo/widgets/features/weekly_reports/weekly_details_header.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class WeeklyDetailsScreen extends StatefulWidget {
  const WeeklyDetailsScreen({super.key});

  @override
  State<WeeklyDetailsScreen> createState() => _WeeklyDetailsScreenState();
}

class _WeeklyDetailsScreenState extends State<WeeklyDetailsScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final GlobalKey _captureKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<Uint8List?> _captureWidgetToImage() async {
    try {
      RenderRepaintBoundary? boundary =
      _captureKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return null;

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      print('화면 캡처 중 오류 발생: $e');
      return null;
    }
  }

  Future<void> _captureAndShareAsPdf() async {
    try {
      final imageBytes = await _captureWidgetToImage();
      if (imageBytes == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('화면 캡처에 실패했습니다.')),
        );
        return;
      }

      final pdf = pw.Document();
      final image = pw.MemoryImage(imageBytes);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) => pw.Center(child: pw.Image(image)),
        ),
      );

      final output = await getTemporaryDirectory();
      final filePath = '${output.path}/weekly_report_capture.pdf';
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      await Share.shareXFiles(
        [XFile(filePath)],
        text: '주간 리포트를 PDF로 공유합니다!',
        subject: '주간 리포트',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('공유 중 오류 발생: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBarWidget(showBackButton: true),
      backgroundColor: const Color(0xFFCAE296),
      body: SafeArea(
        child: RepaintBoundary(
          key: _captureKey,
          child: Column(
            children: [
              WeeklyDetailsHeader(tabController: _tabController),
              const SizedBox(height: 20),
              const GeminiSummarySection(
                summaryText: '',
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _captureAndShareAsPdf,
                        icon: const Icon(Icons.picture_as_pdf, size: 20, color: Colors.white),
                        label: const Text(
                          'PDF로 공유하기',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'PretendardSemibold',
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
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