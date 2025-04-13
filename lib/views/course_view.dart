import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noctus_mobile/utils/app_colors.dart';
import 'package:video_player/video_player.dart';

class ViewCourse extends StatefulWidget {
  const ViewCourse({Key? key}) : super(key: key);

  @override
  _ViewCourseState createState() => _ViewCourseState();
}

class _ViewCourseState extends State<ViewCourse> with WidgetsBindingObserver {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    );
    _controller.initialize().then((_) {
      setState(() {});
      _controller.play();
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    final orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.landscape) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  // Função para criar cada item de aula
  Widget _buildLessonItem({
    required String title,
    required String duration,
    bool isCurrent = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isCurrent ? AppColors.primaryBlue : Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.play_arrow,
              color: isCurrent ? Colors.white : AppColors.primaryBlue,
              size: 28,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  duration,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: AppColors.accentGreen,
            size: 35,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final screenSize = MediaQuery.of(context).size;

    final videoWidget = Stack(
      children: [
        SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: VideoPlayer(_controller),
            ),
          ),
        ),
        Center(
          child: GestureDetector(
            onTap: _togglePlayPause,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12),
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: AppColors.primaryBlue,
                size: 36,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              left: 16,
              right: 16,
            ),
            height: 56 + MediaQuery.of(context).padding.top,
            color: Colors.black.withOpacity(0.0),
            child: Align(
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
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: _controller.value.isInitialized
          ? orientation == Orientation.landscape
              ? Center(
                  child: SizedBox(
                    width: screenSize.width,
                    height: screenSize.height,
                    child: videoWidget,
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: screenSize.height / 3,
                      width: double.infinity,
                      child: videoWidget,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "UX/UI Designer",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                              children: [
                                Icon(Icons.access_time, size: 16, color: Colors.grey),
                                SizedBox(width: 5),
                                Text(
                                  "6h 30 min",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "28 lessons",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(width: 120),
                                // Removido 'const' para corrigir o erro
                                Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(33, 150, 243, 0.1),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min, // Para garantir que o conteúdo ocupe apenas o espaço necessário
                                  children: [
                                    Icon(Icons.star, size: 18, color: Colors.yellow),
                                    SizedBox(width: 5),
                                    Text(
                                      "4.9",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              ],
                            ),
                              const SizedBox(height: 20),

                              // Adicionando o título "Lessons" com a linha abaixo
                              Padding(
                              padding: const EdgeInsets.only(bottom: 16.0, left: 75.0, right: 20.0), // Adiciona mais espaço nas laterais
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Título "Lessons"
                                  Text(
                                    "Lessons",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.accentGreen,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  
                                  // Linha abaixo do título "Lessons" (ajustando a largura)
                                  Container(
                                    height: 2,
                                    width: 80, // Tamanho ajustado da linha
                                    color: AppColors.accentGreen, // Cor da linha
                                  ),
                                ],
                              ),
                            ),

                              // Aulas:
                              _buildLessonItem(
                                title: "    Introduction to Figma",
                                duration: "04:28 min",
                                isCurrent: true,
                              ),
                              _buildLessonItem(
                                title: "    Understanding Interface",
                                duration: "06:12 min",
                              ),
                              _buildLessonItem(
                                title: "    Create first design project",
                                duration: "43:50 min",
                              ),
                              Opacity(
                                opacity: 0.2, // valor entre 0.0 (invisível) e 1.0 (opaco)
                                child: _buildLessonItem(
                                  title: "    Prototyping the design",
                                  duration: "26:18 min",
                                ),
                              ),

                              const SizedBox(height: 20),

                              Spacer(),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 60, left: 5), // ← ajustado aqui
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _togglePlayPause();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryBlue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                    ),
                                    child: const Text(
                                      "Play",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}