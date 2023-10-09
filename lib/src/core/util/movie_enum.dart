enum MovieEndpoint {
  popular(
    'Popular',
    'PopularDrawer',
  ),
  topRated(
    'Top Rated',
    'TopRatedDrawer',
  ),
  nowPlaying(
    'Now Playing',
    'NowPlayingDrawer',
  ),
  upComing(
    'Up Coming',
    'UpComingDrawer',
  );

  const MovieEndpoint(
    this.title,
    this.key,
  );

  final String title;
  final String key;
}
