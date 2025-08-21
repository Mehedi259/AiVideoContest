import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import '../../../app/routes/app_routes.dart';
import '../../../gen/assets.gen.dart';
import '../../widgets/navigation_bar.dart';

class VideoDetailScreen extends StatefulWidget {
  const VideoDetailScreen({super.key});

  @override
  State<VideoDetailScreen> createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;

  bool isLiked = false;
  bool isDisliked = false;
  bool isVoted = false;
  bool _isVideoReady = false;

  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.asset(
      "assets/videos/video2.mp4",
    );

    _videoController.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _videoController,
        autoPlay: true,
        looping: false,
        allowFullScreen: true,
        allowMuting: false,
        allowPlaybackSpeedChanging: false,
        aspectRatio: _videoController.value.aspectRatio,
      );

      setState(() {
        _isVideoReady = true;
      });
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void _onLikePressed() {
    setState(() {
      isLiked = true;
      isDisliked = false;
    });
  }

  void _onDislikePressed() {
    setState(() {
      isDisliked = true;
      isLiked = false;
    });
  }

  void _onVotePressed() {
    setState(() {
      isVoted = !isVoted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Bar (no margin)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.go(Routes.home),
                      child: Assets.icons.backButton.image(width: 30, height: 30),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Center(
                        child: Text(
                          "Halloween Dinner",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 46),
                  ],
                ),
              ),

              // Content with 20px margin
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    AspectRatio(
                      aspectRatio:
                      _isVideoReady ? _videoController.value.aspectRatio : 16 / 9,
                      child: _isVideoReady
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Chewie(controller: _chewieController!),
                      )
                          : const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Halloween Dinner",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "@zarif143",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: Color(0xFFB0B3B8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: _onLikePressed,
                              child: Column(
                                children: [
                                  isLiked
                                      ? Assets.icons.like.image(width: 24, height: 24)
                                      : Assets.icons.likeWhite.image(width: 24, height: 24),
                                  const SizedBox(height: 2),
                                  const Text(
                                    "Like",
                                    style: TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: _onDislikePressed,
                              child: Column(
                                children: [
                                  isDisliked
                                      ? Assets.icons.dislikeBlue.image(width: 24, height: 24)
                                      : Assets.icons.dislike.image(width: 24, height: 24),
                                  const SizedBox(height: 2),
                                  const Text(
                                    "Dislike",
                                    style: TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              children: [
                                Assets.icons.flag.image(width: 24, height: 24),
                                const SizedBox(height: 2),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    "Report",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: GestureDetector(
                        onTap: _onVotePressed,
                        child: Container(
                          width: 167,
                          height: 134,
                          decoration: BoxDecoration(
                            color: const Color(0xFF004AAD),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Assets.images.vote.image(width: 60, height: 60),
                              const SizedBox(height: 8),
                              Text(
                                isVoted ? "Voted" : "Vote",
                                style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
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
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              GoRouter.of(context).go(Routes.home);
              break;
            case 1:
              GoRouter.of(context).go(Routes.likedVideos);
              break;
            case 2:
              GoRouter.of(context).go(Routes.uploadVideos);
              break;
            case 3:
              GoRouter.of(context).go(Routes.winner);
              break;
            case 4:
              GoRouter.of(context).go(Routes.profile);
              break;
          }
        },
      ),
    );
  }
}
