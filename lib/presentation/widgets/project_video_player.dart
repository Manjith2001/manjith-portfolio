import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class ProjectVideoPlayer extends StatefulWidget {
  final String videoAsset;
  final String? posterAsset;
  final Color accentColor;
  final String title;

  const ProjectVideoPlayer({
    super.key,
    required this.videoAsset,
    this.posterAsset,
    this.accentColor = AppColors.primary,
    this.title = 'Project Video Demo',
  });

  @override
  State<ProjectVideoPlayer> createState() => _ProjectVideoPlayerState();
}

class _ProjectVideoPlayerState extends State<ProjectVideoPlayer> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _hasError = false;
  bool _showControls = true;
  bool _isMuted = true;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    try {
      final controller = VideoPlayerController.asset(widget.videoAsset);
      _controller = controller;

      await controller.initialize();
      await controller.setLooping(true);
      await controller.setVolume(0.0);
      await controller.play();

      if (mounted) {
        setState(() {
          _isInitialized = true;
          _hasError = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _isInitialized = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_controller == null || !_isInitialized) return;
    setState(() {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
      } else {
        _controller!.play();
      }
    });
  }

  void _toggleMute() {
    if (_controller == null || !_isInitialized) return;
    setState(() {
      _isMuted = !_isMuted;
      _controller!.setVolume(_isMuted ? 0.0 : 1.0);
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError || _controller == null) {
      return _buildFallbackPoster();
    }

    if (!_isInitialized) {
      return Container(
        height: 600,
        decoration: BoxDecoration(
          color: const Color(0xFF0A0D16),
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: AppColors.border, width: 2),
        ),
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(widget.accentColor),
          ),
        ),
      );
    }

    final isPlaying = _controller!.value.isPlaying;
    final position = _controller!.value.position;
    final duration = _controller!.value.duration;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 320), // Phone width
        child: AspectRatio(
          aspectRatio: 9 / 19.5, // Phone aspect ratio
          child: MouseRegion(
            onEnter: (_) => setState(() => _showControls = true),
            onExit: (_) => setState(() => _showControls = false),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(40), // Device border radius
                border: Border.all(color: AppColors.borderLight, width: 8), // Bezel
                boxShadow: [
                  BoxShadow(
                    color: widget.accentColor.withValues(alpha: 0.2),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32), // Inner border radius
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Video Canvas
                    FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller!.value.size.width,
                        height: _controller!.value.size.height,
                        child: VideoPlayer(_controller!),
                      ),
                    ),

                    // Device Notch
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 120,
                          height: 24,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Tap to play/pause
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: _togglePlayPause,
                        behavior: HitTestBehavior.translucent,
                        child: AnimatedOpacity(
                          opacity: _showControls || !isPlaying ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 200),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withValues(alpha: 0.5),
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.8),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    if (!isPlaying)
                      Center(
                        child: GestureDetector(
                          onTap: _togglePlayPause,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: widget.accentColor.withValues(alpha: 0.9),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              size: 32,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                    // Controls
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 32,
                      child: AnimatedOpacity(
                        opacity: _showControls ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: widget.accentColor.withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'DEMO RECORDING',
                                style: AppTypography.mono(
                                  size: 9,
                                  weight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: VideoProgressIndicator(
                                _controller!,
                                allowScrubbing: true,
                                colors: VideoProgressColors(
                                  playedColor: widget.accentColor,
                                  bufferedColor: Colors.white24,
                                  backgroundColor: Colors.white10,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    isPlaying
                                        ? Icons.pause_rounded
                                        : Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  onPressed: _togglePlayPause,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  icon: Icon(
                                    _isMuted
                                        ? Icons.volume_off_rounded
                                        : Icons.volume_up_rounded,
                                    color: Colors.white70,
                                    size: 18,
                                  ),
                                  onPressed: _toggleMute,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                                const Spacer(),
                                Text(
                                  '${_formatDuration(position)} / ${_formatDuration(duration)}',
                                  style: AppTypography.mono(
                                    size: 10,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Home Indicator
                    Positioned(
                      bottom: 8,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 100,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackPoster() {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: AppColors.borderLight, width: 2),
      ),
      child: Center(
        child: Icon(Icons.videocam_rounded, size: 48, color: widget.accentColor),
      ),
    );
  }
}
