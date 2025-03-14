import 'package:flutter/material.dart';
import 'package:skinn/utils/shared_preferences_helper.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> _diagnosisHistory = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final history = await SharedPreferencesHelper.getDiagnosisHistory();
    setState(() {
      _diagnosisHistory = history;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF99C8D8), Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Başlık
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Diagnosis History',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF007D41),
                    fontFamily: 'Poppins',
                  ),
                ),
              ),

              // İstatistikler
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    _buildStatCard('Total\nDiagnoses', _diagnosisHistory.length.toString()),
                    SizedBox(width: 15),
                    _buildStatCard('This\nMonth', _getThisMonthCount().toString()),
                    SizedBox(width: 15),
                    _buildStatCard('Pending\nReviews', _getPendingCount().toString()),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Geçmiş listesi
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.all(20),
                    itemCount: _diagnosisHistory.length,
                    itemBuilder: (context, index) {
                      final diagnosis = _diagnosisHistory[index];
                      return _buildHistoryItem(diagnosis);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF007D41),
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> diagnosis) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              _getImageForCondition(diagnosis['condition'] ?? ''),
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  diagnosis['condition'] ?? 'Unknown Condition',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  diagnosis['date'] != null 
                      ? _formatDate(diagnosis['date'])
                      : 'Date not available',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                ),
                Wrap(
                  spacing: 8,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Color(0xFF007D41).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        diagnosis['severity'] ?? 'Unknown Severity',
                        style: TextStyle(
                          color: Color(0xFF007D41),
                          fontSize: 11,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: (diagnosis['isPending'] ?? true)
                            ? Colors.orange.withOpacity(0.1)
                            : Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        diagnosis['status'] ?? 'Pending review',
                        style: TextStyle(
                          color: (diagnosis['isPending'] ?? true) 
                              ? Colors.orange 
                              : Colors.green,
                          fontSize: 11,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        ],
      ),
    );
  }

  int _getThisMonthCount() {
    final now = DateTime.now();
    return _diagnosisHistory.where((diagnosis) {
      final date = DateTime.parse(diagnosis['date']);
      return date.month == now.month && date.year == now.year;
    }).length;
  }

  int _getPendingCount() {
    return _diagnosisHistory.where((diagnosis) => diagnosis['isPending'] == true).length;
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day} ${_getMonth(date.month)} ${date.year}';
    } catch (e) {
      return 'Invalid date';
    }
  }

  String _getMonth(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  String _getImageForCondition(String condition) {
    if (condition.isEmpty) return 'assets/images/default_skin.jpg';
    
    final Map<String, String> conditionImages = {
      'Acne': 'assets/images/acneFace.jpg',
      'Eczema': 'assets/images/eczamaHand.jpg',
      'Psoriasis': 'assets/images/psoriasiArm.jpg',
    };
    return conditionImages[condition] ?? 'assets/images/default_skin.jpg';
  }
}