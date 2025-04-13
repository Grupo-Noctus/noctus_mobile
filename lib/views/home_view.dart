import 'package:flutter/material.dart';
import 'package:noctus_mobile/utils/app_colors.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: Padding(
      padding: const EdgeInsets.all(13.0),
      child: Material(
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(40),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                indicatorColor: const Color.fromRGBO(70, 28, 220, 0.7),
                indicatorShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                backgroundColor: AppColors.white,
              ),
              child: NavigationBar(
                onDestinationSelected: (int index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                selectedIndex: currentPageIndex,
                destinations: const <Widget>[
                  NavigationDestination(
                    selectedIcon: Icon(Icons.home),
                    icon: Icon(Icons.home_outlined),
                    label: '',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.person),
                    label: '',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),

      body: IndexedStack(
        index: currentPageIndex,
        children: [
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: double.infinity,
                    color: const Color.fromRGBO(70, 28, 220, 1.0),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0, left: 10.0),
                            child: Text(
                              'Instituto Matera',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16, bottom: 12.0),
                            child: Image.asset(
                              'assets/images/M Matera.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Meus Cursos',
                      style: TextStyle(
                        color: AppColors.darkBlack,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Card(
                      shadowColor: Colors.transparent,
                      margin: const EdgeInsets.only(left: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: SizedBox(
                          height: 290,
                          width: 330,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                'assets/images/cursoUX-UI.jpeg',
                                fit: BoxFit.cover,
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  width: double.infinity,
                                  height: 95,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      Text(
                                        'UX/UI Designer',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black,
                                              blurRadius: 6,
                                              offset: Offset(1, 1),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                        'Acessar curso',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black,
                                              blurRadius: 4,
                                              offset: Offset(1, 1),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      'View All',
                      style: TextStyle(
                        color: AppColors.darkBlack,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: customCard(
                            'assets/images/curso-Docker.jpeg',
                            'Introdução ao Docker',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: customCard(
                            'assets/images/curso-Java.jpeg',
                            'Java Avançado',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ],
          ),
          const SizedBox.shrink(),
          const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget customCard(String imagePath, String title) {
    return Card(
      shadowColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: 220,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: double.infinity,
                  height: 95,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 4,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Acessar cursos',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 4,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
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
}
