import 'package:flutter/material.dart';
import 'package:heal_lo/screens/records/condition_diary.dart';
import 'package:heal_lo/screens/records/medicatioin_check.dart';
import 'package:heal_lo/widgets/commons/app_bar.dart';
import 'package:heal_lo/widgets/commons/input_dialog.dart';
import 'package:heal_lo/widgets/commons/section_header.dart';
import 'package:heal_lo/widgets/features/records/vital_check_section.dart';
import 'package:intl/intl.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class DailyRecordsScreen extends StatefulWidget {
  final DateTime date;

  const DailyRecordsScreen({super.key, required this.date});

  @override
  State<DailyRecordsScreen> createState() => _DailyRecordsScreenState();
}

class _DailyRecordsScreenState extends State<DailyRecordsScreen> {
  Map<String, String> vitals = {
    '혈당': '90',
    '혈압': '125/85',
    '체중': '76',
    '체온': '36.7°C',
  };

  List<Map<String, dynamic>> medications = [];

  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _fetchMedications();
    _speech = stt.SpeechToText();
  }

  Future<void> _fetchMedications() async {
    // TODO: 실제 API 요청으로 변경
    setState(() {
      medications = [
        {'name': '타이레놀 500mg', 'checked': false},
        {'name': '오메프라졸', 'checked': false},
      ];
    });
  }

  void _showAddMedicationDialog() {
    showDialog(
      context: context,
      builder: (context) => CommonInputDialog(
        title: '복약 항목 추가',
        hintText: '예: 타이레놀 500mg',
        onSubmit: (text) {
          setState(() {
            medications.add({'name': text, 'checked': false});
          });
        },
      ),
    );
  }

  final _diaryController = TextEditingController();

  void _handleVoiceInput() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) => print('Status: $status'),
        onError: (error) => print('Error: $error'),
      );

      String _lastRecognized = '';

      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          localeId: 'ko_KR',
          onResult: (result) {
            if (result.finalResult) {
              if (result.recognizedWords != _lastRecognized) {
                setState(() {
                  _diaryController.text += result.recognizedWords + ' ';
                  _lastRecognized = result.recognizedWords;
                });
              }
            }
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBarWidget(showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                DateFormat('yyyy년 MM월 dd일').format(widget.date) + '의 기록',
                style: const TextStyle(
                  fontFamily: 'PretendardBlack',
                  fontSize: 25,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  VitalsSection(initialVitals: vitals),
                  CommonSectionHeader(
                    title: 'Medication Check',
                    onAddPressed: _showAddMedicationDialog,
                  ),
                  MedicationCheck(
                    medications: medications,
                    onCheckChanged: (index, value) {
                      setState(() {
                        medications[index]['checked'] = value;
                      });
                      // TODO: API 요청으로 체크 처리
                    },
                    onDelete: (index) {
                      setState(() {
                        medications.removeAt(index);
                        // TODO: API 요청으로 삭제 처리
                      });
                    },
                  ),

                  CommonSectionHeader(title: 'Condition Log'),
                  ConditionDiary(controller: _diaryController),
                  const SizedBox(height: 16),
                  RawMaterialButton(
                    onPressed: _handleVoiceInput,
                    shape: const CircleBorder(),
                    fillColor: _isListening ? Colors.red : Colors.black,
                    constraints: const BoxConstraints.tightFor(width: 48, height: 48),
                    child: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}