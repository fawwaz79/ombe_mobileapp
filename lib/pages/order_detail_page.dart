import 'dart:ui'; // Wajib untuk efek blur bayangan
import 'package:flutter/material.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  int qty = 3; 
  double selectedSize = 1; 
  
  // Variabel untuk menyimpan status Bookmark
  bool isSaved = false; 

  final double price = 5.8;
  final Color primaryGreen = const Color(0xFF0B6E4F);

  @override
  Widget build(BuildContext context) {
    final total = qty * price;

    return Scaffold(
      backgroundColor: Colors.white,
      
      // --- TOMBOL BAWAH ---
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: SizedBox(
          height: 55,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              elevation: 0,
            ),
            onPressed: () {
              // Action Order
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "PLACE ORDER",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "\$${total.toStringAsFixed(1)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70, 
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // --- KONTEN UTAMA ---
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // 1. BACKGROUND HIJAU
            Container(
              height: 320,
              color: primaryGreen,
            ),

            // 2. GAMBAR KOPI DENGAN BAYANGAN REALISTIS
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  height: 260,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Layer Bayangan (Drop Shadow)
                      Transform.translate(
                        offset: const Offset(5, 15),
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
                          child: ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                              Color(0x66000000), 
                              BlendMode.srcATop,
                            ),
                            // Pastikan backheader.png Anda sudah PNG Transparan (tanpa background)
                            child: Image.asset(
                              'assets/backheader.png', 
                              height: 260,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      // Layer Gambar Asli
                      Image.asset(
                        'assets/backheader.png',
                        height: 260,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 3. WHITE SHEET (Detail Pesanan)
            Container(
              margin: const EdgeInsets.only(top: 280),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Ice Chocolate Coffee",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  Text(
                    "“Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 35),

                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 8.0,
                      activeTrackColor: primaryGreen,
                      inactiveTrackColor: Colors.grey.shade200,
                      thumbColor: primaryGreen,
                      overlayColor: const Color.fromRGBO(11, 110, 79, 0.2), 
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                      overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
                      tickMarkShape: SliderTickMarkShape.noTickMark,
                    ),
                    child: Slider(
                      value: selectedSize,
                      min: 0,
                      max: 3,
                      divisions: 3,
                      onChanged: (value) {
                        setState(() {
                          selectedSize = value;
                        });
                      },
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSizeLabel("Small", 0),
                        _buildSizeLabel("Medium", 1),
                        _buildSizeLabel("Large", 2),
                        _buildSizeLabel("Xtra Large", 3),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "\$ ",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                price.toString(),
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  height: 1.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 8),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              "\$8.0",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade500,
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (qty > 0) setState(() => qty--);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.remove, color: primaryGreen, size: 20),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "$qty",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                setState(() => qty++);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.add, color: primaryGreen, size: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),

                  Text(
                    "*)Dolor sit amet, consectetur adipiscing elit, sed\ndo eiusmod tempor incididunt ut labore",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20), 
                ],
              ),
            ),

            // 4. APP BAR & BOOKMARK INTERAKTIF
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white24, 
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                    const Text(
                      "Details",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    // TOMBOL BOOKMARK
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSaved = !isSaved; // Toggle status
                        });

                        // Munculkan notifikasi pop-up kecil
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isSaved ? 'Tersimpan ke Favorit!' : 'Dihapus dari Favorit'
                            ),
                            duration: const Duration(seconds: 1),
                            backgroundColor: primaryGreen,
                          ),
                        );
                      },
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_border,
                          key: ValueKey<bool>(isSaved),
                          color: Colors.white, 
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 5. BADGE RATING
            Positioned(
              top: 245, 
              right: 32,
              child: Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  color: Color(0xFFF18A30), 
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(241, 138, 48, 0.4), 
                      blurRadius: 15,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "4.5",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeLabel(String text, int index) {
    bool isActive = selectedSize.round() == index;
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
        color: isActive ? Colors.grey.shade800 : Colors.grey.shade500,
      ),
    );
  }
}