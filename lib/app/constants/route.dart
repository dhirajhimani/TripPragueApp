enum RouteName {
  initial('/'),
  login('/login'),
  home('/home'),
  error('/error'),
  profile('/profile'),
  day1('/day1'),
  day2('/day2'),
  day3('/day3'),
  postDetails(':postId');

  const RouteName(this.path);
  final String path;
}
