%%% beginglyph beginlogoglyph
%%% endglyph endlogoglyph
%% \maybeinput jnsredef
%% \--------------------------------------------------------------------
%% \bf Routines for the \MF{} logo, as found in ``The~\MF{\/}book'';
%% letters A, E, F, M, O, P, S, and T (P and S for John D.~Hobby's \MP{}).
%% \-
%% \bf Programy do logo \MF{}-a, wed/lug podr/ecznika
%% ,,The~\MF{\/}book''; litery A, E, F, M, O, P, S oraz T
%% (P i S do logo \MP{}-a Johna D.~Hobby'ego).
%% \--------------------------------------------------------------------

def tfm_units = old_tfm_units enddef; % old formulas are usually less exact
def ps_units = old_ps_units enddef;   % but avoiding incompatibility is
                                      % more important in this case

if unknown slant: slant:=0 fi;

ygap#:=(ht#/13.5u#)*xgap#; % vertical adjustment
ho#:=o#;                   % horizontal overshoot
leftstemloc#:=2.5u#+s#;    % position of left stem
barheight#:=.45ht#;        % height of bar lines
py#:=.9px#;                % vertical pen thickness

space#:=6u#+2s#;
space_stretch#:=3u#;
space_shrink#:=2u#;
quad#:=18u#+2s#;

define_ps_units(ht, s, u, o, ho, space, space_stretch, space_shrink, quad);
define_whole_ps_units(xgap, ygap, leftstemloc, barheight);
define_even_ps_units(px, py);

% Complying with the Knuthian canon:
def font_extra_space expr x = enddef;
def font_math_rule expr x = enddef;
def font_math_axis expr x = enddef;
italic_shift=0;
if known generating: if generating<>0: mark_name_used("space"); fi fi

% Complying with the Adobian canon:
pf_info_quad quad;
pf_info_space space, space_stretch, space_shrink;
pf_info_encoding "AEFMNOPST only";
pf_info_familyname "MFMPlogo";
pf_info_version "1.00";
pf_info_author "Author: Donald E. Knuth; MP version by JNS team";
pf_info_italicangle slang;
pf_info_underline -3px, px;
pf_info_fixedpitch false;
pf_info_capheight ht;
pf_info_xheight 0;
pf_info_adl 750, 250, 0;
pf_info_ascender 750;
pf_info_descender -250;
pf_info_overshoots (0, -o), (ht,o);
pf_info_creationdate "20.02.2004";

%%% addto beginlogoglyph
def beginlogoglyph(expr code, unit_width) =
 encode(code) (ASCII(code)); standard_introduce(code);
 beginglyph(code); numeric w,h,d;
  glyph_width#:=wd.glyph_name#=unit_width*u#+2s#; ht.glyph_name#=ht#;
  wd.glyph_name=ps_units(glyph_width#); ht.glyph_name=ps_units(ht#);
  d=dp.glyph_name=0;
  ic.glyph_name=0; % no ``automagical'' italic corrections
  w=2round(1/2wd.glyph_name); h=round(ht.glyph_name);
  fix_exact_hsbw(wd.glyph_name,0,0);
  pickup pencircle xscaled px yscaled py;
enddef;

%%% end endlogoglyph
def endlogoglyph =
  pickup pencircle scaled .5bp; % restore ``normal'' pen for proofing
 endglyph
enddef;

%% \--------------------------------------------------------------------
%% The following macros approximate the envelope of an elliptical pen.
%% \-
%% Poni/zsze makra przybli/zaj/a brzeg /scie/zki kre/slonej
%% eliptycznym pi/orkiem.
%% \--------------------------------------------------------------------
slant_stroke_val:=slant;
ignore_nib_limit:=10;
default_nib:=fix_nib(px,py,0);

def butt_end(text nodes) = cut(rel 90)(nodes) enddef;

%%% addto expand_logo_stroke
vardef expand_logo_stroke@#(text opts) (expr p)=
 if str @#="": save r_; fi
 pen_stroke(opts;)(p)(if str @#="": r_ else: @# fi);
 if str @#="": r_ fi
enddef;

%% \--------------------------------------------------------------------
%% D. E. Knuth's macros return paths rather than draw them.
%% \-
%% Knuthowe makra zwracaj/a /scie/zki zamiast je rysowa/c.
%% \--------------------------------------------------------------------
vardef super_half(suffix i,j,k) =
 z.i{0,y.j-y.i}
 ... (.8[x.j,x.i],.8[y.i,y.j]){z.j-z.i}
 ... z.j{x.k-x.i,0}
 ... (.8[x.j,x.k],.8[y.k,y.j]){z.k-z.j}
 ... z.k{0,y.k-y.j}
enddef;

vardef super_crescent(suffix i,j,k) =
 z.i{x.j-x.i,0}
 ... (.8[x.i,x.j],.8[y.j,y.i]){z.j-z.i}
 ... z.j{0,y.k-y.i}
 ... (.8[x.k,x.j],.8[y.j,y.k]){z.k-z.j}
 ... z.k{x.k-x.j,0}
enddef;

%% \bigskip
beginfont
%% \vfill\eject

%% \--------------------------------------------------------------------
%% The construction of the letter A:
%% \-
%% Konstrukcja litery A:
%% %
%% \PICT{A}
%% \--------------------------------------------------------------------
beginlogoglyph("A",15);
x1=.5w; x2=x4=leftstemloc; x3=x5=w-x2;
top y1=h+o; y2=y3=barheight;
bot y4=bot y5=-o;
find_outlines(expand_logo_stroke(butt_end(0, last))(z2--z3),
 expand_logo_stroke()(z4--z2 & super_half(2,1,3) & z3--z5))
 (glyph);
Fill glyph1; unFill glyph2;
just_labels(1,2,3,4,5);
fix_vstem(px)(glyph1);
fix_hstem(py)(glyph1, glyph2);
endlogoglyph;

%% \vfill\eject
%% \--------------------------------------------------------------------
%% The construction of the letter E:
%% \-
%% Konstrukcja litery E:
%% %
%% \PICT{E}
%% \--------------------------------------------------------------------
beginlogoglyph("E",14);
x1=x2=x3=leftstemloc;
x4=x6=w-x1+ho; x5=x4-xgap;
y1=y6; y2=y5; y3=y4;
bot y1=0; top y3=h; y2=barheight;
find_outlines(expand_logo_stroke()(z6--z1--z3--z4),
 expand_logo_stroke(butt_end(0))(z2--z5)) (glyph);
Fill glyph1;
just_labels(1,2,3,4,5,6);
fix_vstem(px)(glyph1);
fix_hstem(py)(glyph1);
endlogoglyph;

%% \vfill\eject
%% \--------------------------------------------------------------------
%% The construction of the letter F:
%% \-
%% Konstrukcja litery F:
%% %
%% \PICT{F}
%% \--------------------------------------------------------------------
beginlogoglyph("F",14);
x1=x2=x3=leftstemloc;
x4=w-x1+ho; x5=x4-xgap;
y2=y5; y3=y4; bot y1=-o;
top y3=h; y2=barheight;
find_outlines(expand_logo_stroke()(z1--z3--z4),
 expand_logo_stroke(butt_end(0))(z2--z5)) (glyph);
Fill glyph1;
just_labels(1,2,3,4,5);
fix_vstem(px)(glyph1);
fix_hstem(py)(glyph1);
endlogoglyph;

%% \vfill\eject
%% \--------------------------------------------------------------------
%% The construction of the letter M:
%% \-
%% Konstrukcja litery M:
%% %
%% \PICT{M}
%% \--------------------------------------------------------------------
beginlogoglyph("M",18);
x1=x2=leftstemloc; x4=x5=w-x1; x3=w-x3;
y1=y5; y2=y4; bot y1=-o;
top y2=h+o; y3=y1+ygap;
expand_logo_stroke.glyph()(z1--z2--z3--z4--z5);
Fill glyph;
just_labels(1,2,3,4,5);
fix_vstem(px)(glyph);
endlogoglyph;

%% \vfill\eject
%% \--------------------------------------------------------------------
%% The construction of the letter N:
%% \-
%% Konstrukcja litery N:
%% %
%% \PICT{N}
%% \--------------------------------------------------------------------
beginlogoglyph("N",15);
x1=x2=leftstemloc; x3=x4=x5=w-x1;
bot y1=bot y4=-o;
top y2=top y5=h+o; y3=y4+ygap;
find_outlines(expand_logo_stroke(butt_end(last))(z1--z2--z3),
 expand_logo_stroke()(z4--z5)) (glyph);
Fill glyph1;
just_labels(1,2,3,4,5);
fix_vstem(px)(glyph1);
endlogoglyph;

%% \vfill\eject
%% \--------------------------------------------------------------------
%% The construction of the letter O (slightly different, because the path is
%% cyclic):
%% \-
%% Konstrukcja litery O (nieco inna, bo /scie/zka jest cykliczna):
%% %
%% \PICT{O}
%% \--------------------------------------------------------------------
beginlogoglyph("O",15);
x1=x4=.5w; top y1=h+o; bot y4=-o;
x2=w-x3=round(1.5u+s); y2=y3=barheight;
expand_logo_stroke.glyph()(super_half(3,1,2) & super_half(2,4,3) & cycle);
Fill glyph.r; unFill glyph.l;
just_labels(1,2,3,4);
fix_vstem(px)(glyph.l, glyph.r);
fix_hstem(py)(glyph.l, glyph.r);
endlogoglyph;

%% \vfill\eject
%% \--------------------------------------------------------------------
%% The construction of the letter P (again slightly different, because
%% the expanded stroke has self-intersections; the code, however,
%% is surprisingly simple):
%% \-
%% Konstrukcja litery P (zn/ow nieco inna, bo obrys ma samoprzeci/ecia;
%% kod jednak/ze jest zaskakuj/aco prosty):
%% %
%% \PICT{P}
%% \--------------------------------------------------------------------
beginlogoglyph("P",14);
x1=x2=x3=leftstemloc;
x4=x5=.618[x1,w-x1];
y2=y5; y3=y4; bot y1=-o;
top y3=h; y2=barheight;
x6=.5[w-x1,lft w]; y6=.5[y4,y5];
find_outlines(expand_logo_stroke
 (butt_end(last); if unknown don't_ignore_directions: ignore_directions(3r,5r) fi)
 (z1--z3--super_crescent(4,6,5)--z2))(glyph);
Fill glyph1; unFill glyph2;
just_labels(1,2,3,4,5,6);
fix_vstem(px)(glyph1, glyph2);
fix_hstem(py)(glyph1, glyph2);
endlogoglyph;

%% \vfill\eject
%% \--------------------------------------------------------------------
%% The construction of the letter S:
%% \-
%% Konstrukcja litery S:
%% %
%% \PICT{S}
%% \--------------------------------------------------------------------
beginlogoglyph("S",14);
x3=x8=leftstemloc;
x2=x4=.382[x3,w-x3];
x1=w-x3;
x5=x7=.618[x3,w-x3];
x6=.5[w-x3,lft w];
top y1=h; y4=barheight; bot y8=0;
y1=y2; y3=.5[y2,y4]; y4=y5; y6=.5[y5,y7]; y7=y8;
expand_logo_stroke.glyph
 (if unknown don't_ignore_directions: ignore_directions(2l,4l,7r,9r) fi)
 (z1--z2 & super_crescent(2,3,4) & z4--z5 & super_crescent(5,6,7) & z7--z8);
Fill glyph;
just_labels(1,2,3,4,5,6,7,8);
fix_vstem(px)(glyph);
fix_hstem(py)(glyph);
endlogoglyph;

%% \vfill\eject
%% \--------------------------------------------------------------------
%% The construction of the letter T:
%% \-
%% Konstrukcja litery T:
%% %
%% \PICT{T}
%% \--------------------------------------------------------------------
beginlogoglyph("T",13);
% |slant_val|, although in general recommendable, here could spoil tfm
ic._T#:=ht#*slant + .5u#; if ic._T#<0: ic._T#:=0; fi
ic._T:=ps_units(ic._T#);
lft x1=0; x2=w-x1; x3=x4=.5w;
y1=y2=y3; top y1=h; bot y4=-o;
find_outlines(expand_logo_stroke()(z1--z2),
 expand_logo_stroke(butt_end(0))(z3--z4)) (glyph);
Fill glyph1;
just_labels(1,2,3,4);
fix_vstem(px)(glyph1);
fix_hstem(py)(glyph1);
endlogoglyph;

LK("T") KP("A")(-.5u); KL;
LK("F") KP("O")(-u); KL;
LK("P") KP("O")(u); KL;

endinput


