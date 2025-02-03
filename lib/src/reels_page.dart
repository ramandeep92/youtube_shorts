import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:reels_viewer/src/models/reel_model.dart';
import 'package:reels_viewer/src/utils/url_checker.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ReelsPage extends StatefulWidget {
  final Reel item;
  final bool showVerifiedTick;
  final Function(String)? onShare;
  final Function(String)? onLike;
  final Function(String)? onComment;
  final Function()? onClickMoreBtn;
  final Function()? onFollow;
  final SwiperController swiperController;
  final bool showProgressIndicator;
  const ReelsPage({
    Key? key,
    required this.item,
    this.showVerifiedTick = true,
    this.onClickMoreBtn,
    this.onComment,
    this.onFollow,
    this.onLike,
    this.onShare,
    this.showProgressIndicator = true,
    required this.swiperController,
  }) : super(key: key);

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  YoutubePlayerController? _activeController;
  @override
  void initState() {
    super.initState();
    if (!UrlChecker.isImageUrl(widget.item.thumbnailUrl) &&
        UrlChecker.isValid(widget.item.thumbnailUrl)) {
      initializePlayer();
    }
  }

  Future initializePlayer() async {
    // await Future.wait([_activeController?.dispose()] as Iterable<Future>);
    _activeController = YoutubePlayerController(
      initialVideoId: widget.item.reelId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        controlsVisibleAtStart: false,
        hideControls: false,
        disableDragSeek: false,
        enableCaption: false,
        forceHD: false,
        loop: true,
      ),
    )..addListener(_videoListener);
  }

  void _videoListener() {
    if (_activeController == null) return;
    if (_activeController!.value.hasError) {
      _activeController?.reload();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _activeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getVideoView();
  }

  Widget getVideoView() {
    return Stack(
      fit: StackFit.expand,
      children: [
        _activeController != null && _activeController!.value.isReady
            ? FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: YoutubePlayer(
                    actionsPadding: EdgeInsets.zero,
                    controller: _activeController!,
                    showVideoProgressIndicator: false,
                    controlsTimeOut: Duration(microseconds: 10),
                    progressIndicatorColor: Colors.transparent,
                    progressColors: const ProgressBarColors(
                      playedColor: Colors.transparent,
                      handleColor: Colors.transparent,
                    ),
                    onReady: () {
                      _activeController?.play();
                      setState(() {});
                    },
                    onEnded: (metaData) {
                      _activeController?.reload();
                      setState(() {});
                    },
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Loading...')
                ],
              ),
        _buildVideoDetails(MediaQuery.of(context).size),
      ],
    );
  }

  Widget _buildVideoDetails(Size size) {
    final reel = widget.item;
    return Padding(
      padding: EdgeInsets.all(size.width * 0.04),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              widget.item.thumbnailUrl,
              width: size.width * 0.15,
              height: size.width * 0.15,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: size.width * 0.04),
          Expanded(
            child: Text(
              widget.item.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
