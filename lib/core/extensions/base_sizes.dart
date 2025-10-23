import 'package:tradehub/core/base/base_inherited_widgets.dart';

/// 📏 Extension للمقاسات الديناميكية
extension BaseSizeExtension on BaseInheritedWidget {
  /// نسبة من عرض الشاشة
  double w(double value) => screenWidth * (value / 100);

  /// نسبة من ارتفاع الشاشة
  double h(double value) => screenHeight * (value / 100);

  /// scale بناءً على أقصر بعد في الشاشة (مفيد للنصوص)
  double sp(double value) =>
      (screenWidth < screenHeight ? screenWidth : screenHeight) * (value / 100);
}

extension BasePresetSizes on BaseInheritedWidget {
  // 🟦 Width
  double get w1 => w(1);
  double get w2 => w(2);
  double get w3 => w(3);
  double get w4 => w(4);
  double get w5 => w(5);
  double get w6 => w(6);
  double get w7 => w(7);
  double get w8 => w(8);
  double get w9 => w(9);
  double get w10 => w(10);
  double get w11 => w(11);
  double get w12 => w(12);
  double get w13 => w(13);
  double get w14 => w(14);
  double get w15 => w(15);
  double get w16 => w(16);
  double get w17 => w(17);
  double get w18 => w(18);
  double get w19 => w(19);
  double get w20 => w(20);
  double get w21 => w(21);
  double get w22 => w(22);
  double get w23 => w(23);
  double get w24 => w(24);
  double get w25 => w(25);
  double get w26 => w(26);
  double get w27 => w(27);
  double get w28 => w(28);
  double get w29 => w(29);
  double get w30 => w(30);
  double get w31 => w(31);
  double get w32 => w(32);
  double get w33 => w(33);
  double get w34 => w(34);
  double get w35 => w(35);
  double get w36 => w(36);
  double get w37 => w(37);
  double get w38 => w(38);
  double get w39 => w(39);
  double get w40 => w(40);
  double get w41 => w(41);
  double get w42 => w(42);
  double get w43 => w(43);
  double get w44 => w(44);
  double get w45 => w(45);
  double get w46 => w(46);
  double get w47 => w(47);
  double get w48 => w(48);
  double get w49 => w(49);
  double get w50 => w(50);

  // 🟥 Height
  double get h1 => h(1);
  double get h2 => h(2);
  double get h3 => h(3);
  double get h4 => h(4);
  double get h5 => h(5);
  double get h6 => h(6);
  double get h7 => h(7);
  double get h8 => h(8);
  double get h9 => h(9);
  double get h10 => h(10);
  double get h11 => h(11);
  double get h12 => h(12);
  double get h13 => h(13);
  double get h14 => h(14);
  double get h15 => h(15);
  double get h16 => h(16);
  double get h17 => h(17);
  double get h18 => h(18);
  double get h19 => h(19);
  double get h20 => h(20);
  double get h21 => h(21);
  double get h22 => h(22);
  double get h23 => h(23);
  double get h24 => h(24);
  double get h25 => h(25);
  double get h26 => h(26);
  double get h27 => h(27);
  double get h28 => h(28);
  double get h29 => h(29);
  double get h30 => h(30);
  double get h31 => h(31);
  double get h32 => h(32);
  double get h33 => h(33);
  double get h34 => h(34);
  double get h35 => h(35);
  double get h36 => h(36);
  double get h37 => h(37);
  double get h38 => h(38);
  double get h39 => h(39);
  double get h40 => h(40);
  double get h41 => h(41);
  double get h42 => h(42);
  double get h43 => h(43);
  double get h44 => h(44);
  double get h45 => h(45);
  double get h46 => h(46);
  double get h47 => h(47);
  double get h48 => h(48);
  double get h49 => h(49);
  double get h50 => h(50);

  // 🟩 Scale Pixel
  double get sp1 => sp(1);
  double get sp2 => sp(2);
  double get sp3 => sp(3);
  double get sp4 => sp(4);
  double get sp5 => sp(5);
  double get sp6 => sp(6);
  double get sp7 => sp(7);
  double get sp8 => sp(8);
  double get sp9 => sp(9);
  double get sp10 => sp(10);
  double get sp11 => sp(11);
  double get sp12 => sp(12);
  double get sp13 => sp(13);
  double get sp14 => sp(14);
  double get sp15 => sp(15);
  double get sp16 => sp(16);
  double get sp17 => sp(17);
  double get sp18 => sp(18);
  double get sp19 => sp(19);
  double get sp20 => sp(20);
  double get sp21 => sp(21);
  double get sp22 => sp(22);
  double get sp23 => sp(23);
  double get sp24 => sp(24);
  double get sp25 => sp(25);
  double get sp26 => sp(26);
  double get sp27 => sp(27);
  double get sp28 => sp(28);
  double get sp29 => sp(29);
  double get sp30 => sp(30);
  double get sp31 => sp(31);
  double get sp32 => sp(32);
  double get sp33 => sp(33);
  double get sp34 => sp(34);
  double get sp35 => sp(35);
  double get sp36 => sp(36);
  double get sp37 => sp(37);
  double get sp38 => sp(38);
  double get sp39 => sp(39);
  double get sp40 => sp(40);
  double get sp41 => sp(41);
  double get sp42 => sp(42);
  double get sp43 => sp(43);
  double get sp44 => sp(44);
  double get sp45 => sp(45);
  double get sp46 => sp(46);
  double get sp47 => sp(47);
  double get sp48 => sp(48);
  double get sp49 => sp(49);
  double get sp50 => sp(50);
}
