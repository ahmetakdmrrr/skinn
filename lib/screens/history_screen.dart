import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

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
                child: Row(
                  children: [
                    Text(
                      'Diagnosis History',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF007D41),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Spacer(),
                    // Filter butonu
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(Icons.filter_list, color: Color(0xFF007D41)),
                        onPressed: () {
                          // Filtreleme işlevi
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // İstatistikler
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    _buildStatCard('Total\nDiagnoses', '24'),
                    SizedBox(width: 15),
                    _buildStatCard('This\nMonth', '5'),
                    SizedBox(width: 15),
                    _buildStatCard('Pending\nReviews', '2'),
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
                  child: ListView(
                    padding: EdgeInsets.all(20),
                    children: [
                      _buildMonthHeader('March 2024'),
                      _buildHistoryItem(
                        'Eczema',
                        'assets/images/eczamaHand.jpg',
                        'March 15, 2024',
                        'Mild condition',
                        'Dr. Smith reviewed',
                      ),
                      _buildHistoryItem(
                        'Acne',
                        'assets/images/acneFace.jpg',
                        'March 10, 2024',
                        'Moderate condition',
                        'Pending review',
                        isPending: true,
                      ),
                      _buildMonthHeader('February 2024'),
                      _buildHistoryItem(
                        'Psoriasis',
                        'assets/images/psoriasiArm.jpg',
                        'February 28, 2024',
                        'Severe condition',
                        'Dr. Johnson reviewed',
                      ),
                    ],
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

  Widget _buildMonthHeader(String month) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        month,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  Widget _buildHistoryItem(
    String condition,
    String imagePath,
    String date,
    String severity,
    String status, {
    bool isPending = false,
  }) {
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
              imagePath,
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
                  condition,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  date,
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
                        severity,
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
                        color: isPending
                            ? Colors.orange.withOpacity(0.1)
                            : Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: isPending ? Colors.orange : Colors.green,
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
          SizedBox(width: 4),
          Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}