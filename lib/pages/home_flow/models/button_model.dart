class ButtonModel {
  const ButtonModel({
    this.id = '',
    this.title = '',
    this.icon = '',
    this.iconColor = ''
  });
  final String id;
  final String title;
  final String icon;
  final String iconColor;

  ButtonModel copyWith({
    String? id,
    String? title,
    String? icon,
    String? iconColor,
  }) {
    return ButtonModel(
      id: id ?? this.id,
      title: title ?? this.id,
      icon: icon ?? this.icon,
      iconColor: iconColor ?? this.iconColor
    );
  }

  static const empty = ButtonModel(id: '', title: '', icon: '', iconColor: '');
}