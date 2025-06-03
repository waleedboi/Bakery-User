import 'package:completefoodorderingappui/bakeryadminapp/Auth/signup.dart';
import 'package:completefoodorderingappui/view/auth/onboardings/signup.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  final int initialPage;
  const OnboardingScreen({super.key, this.initialPage = 0});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
    _pageController = PageController(initialPage: widget.initialPage);
  }

  // NEW: track selected role and menu state
  String? _selectedRole;
  bool _menuOpen = false;

  final List<OnboardingData> onboardingData = [
    OnboardingData(
      image: 'images/boarding1.png',
      title: 'Save Food',
      description: 'Explore a world of fresh food\noptions with BakeMe',
      showButton: false,
    ),
    OnboardingData(
      image: 'images/boarding2.png',
      title: 'Save Money',
      description: 'Savor your favorites at unbeatable\nprices with BakeMe',
      showButton: false,
    ),
    OnboardingData(
      image: 'images/boarding3.png',
      title: 'Save Planet',
      description:
          'Make a sustainable difference with\nevery meal you choose with BakeMe',
      showButton: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(onboardingData.length, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? const Color(0xFF2D5016)
                          : const Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                    // reset menu when leaving last page
                    if (!_currentPage.isEven &&
                        onboardingData[_currentPage].showButton == false) {
                      _menuOpen = false;
                    }
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  final item = onboardingData[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          margin: const EdgeInsets.only(bottom: 40),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              item.image,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2D5016),
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          item.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF666666),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 60),
                        if (item.showButton)
                          Column(
                            children: [
                              // Continue As dropdown button
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        color: Color(0xFF2D5016)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() => _menuOpen = !_menuOpen);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _selectedRole == null
                                            ? "Continue as"
                                            : "Continue as $_selectedRole",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFF2D5016),
                                        ),
                                      ),
                                      Icon(
                                        _menuOpen
                                            ? Icons.arrow_drop_up
                                            : Icons.arrow_drop_down,
                                        color: const Color(0xFF2D5016),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Dropdown menu
                              if (_menuOpen)
                                Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFF2D5016)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    children: [
                                      _buildRoleOption("Customer"),
                                      const Divider(),
                                      _buildRoleOption("Bakery Owner"),
                                    ],
                                  ),
                                ),

                              const SizedBox(height: 16),

                              // Get Started button
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                  onPressed: _selectedRole == null
                                      ? () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "Please select an option from list",
                                              ),
                                            ),
                                          );
                                        }
                                      : () {
                                          if (_selectedRole == "Customer") {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    const SignUpScreen(),
                                              ),
                                            );
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    const AdminSignUpScreen(),
                                              ),
                                            );
                                          }
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _selectedRole == null
                                        ? Colors.grey
                                        : const Color(0xFF2D5016),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    elevation: 2,
                                  ),
                                  child: const Text(
                                    'Get Started',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        else
                          GestureDetector(
                            onTap: () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Container(
                              width: 56,
                              height: 56,
                              decoration: const BoxDecoration(
                                color: Color(0xFF2D5016),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleOption(String role) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedRole = role;
          _menuOpen = false;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          role,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class OnboardingData {
  final String image;
  final String title;
  final String description;
  final bool showButton;

  OnboardingData({
    required this.image,
    required this.title,
    required this.description,
    required this.showButton,
  });
}
