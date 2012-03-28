%
% TYPE 3 FONTS REPOSITORIUM            Wlodek Bzyl <matwb@univ.gda.pl>
%

% Type 3 fonts used by redis-000.tex (compare `knots.mp')

mode_def redis_a =
  final_;
  font_name "Redis-a00";
  font_version "1.0a";
  font_identifier:="REDIS A00";
  vardef color_vowels(expr code) =
    if (code=65) or (code=69) or (code=73) or (code=79)
      or (code=85) or (code=89) or (code=129)
      or (code=134) or (code=211): (1,0,.35)
    else: 1/3(0,1,1)
    fi
  enddef;
  glyph.set_encoded.defaultcolor(color_vowels);
enddef;

mode_def redis_b =
  final_;
  font_name "Redis-b00";
  font_version "1.0b";
  font_identifier:="REDIS B00";
  sidebearings:=3u;
  def shipit =
    currentpicture:=currentpicture rotated ((uniformdeviate 20)-10)
       shifted (uniformdeviate 4u,uniformdeviate 4u);
    shipout currentpicture
  enddef;
  vardef peturbate(expr code) =
    (uniformdeviate u, 0, uniformdeviate u)
  enddef;
  glyph.set_encoded.defaultcolor(peturbate);
enddef;

mode_def redis_c =
  final_;
  font_name "Redis-c00";
  font_version "1.0c";
  font_identifier:="REDIS C00";
  px:=4u;
  sidebearings:=3u;
  accent_length:=accent_length+u;
enddef;

mode_def redis_d =
  final_;
  font_name "Redis-d00";
  font_version "1.0d";
  font_identifier:="REDIS D00";
  def shipit =
    currentpicture:=currentpicture rotatedaround(r5,180);
    shipout currentpicture
  enddef;
  vardef one_color(expr code) =
    (uniformdeviate 1)*red
  enddef;
  glyph.set_encoded.defaultcolor(one_color);
enddef;

mode_def redis_e =
  final_;
  font_name "Redis-e00";
  font_version "1.0e";
  font_identifier:="REDIS E00";
  sidebearings:=4u;
  def shipit =
    if ((uniformdeviate 1)<.5):
      currentpicture:=currentpicture rotatedaround(r5,-90);
    else:
      currentpicture:=currentpicture rotatedaround(r5,90);
    fi
    shipout currentpicture
  enddef;
  vardef one_undecided_color(expr code) =
    (uniformdeviate 1)*(0,1,1)
  enddef;
  glyph.set_encoded.defaultcolor(one_undecided_color);
enddef;

%% \end
