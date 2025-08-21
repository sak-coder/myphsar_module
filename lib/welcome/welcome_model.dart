class WelcomeModel {
  final String _image;
  final String _title;
  final String _description;

  get imageUrl => _image;

  get title => _title;

  get description => _description;

  WelcomeModel(this._image, this._title, this._description);
}
