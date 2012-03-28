%%%%
%%%% This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
%%%%

%% \setfontname plus-000 %%%% required by the |\glyph| macro

%% \input plus-001.lst
%% \proofvsize=75mm

%% \title{\titleF PLUS FONT}

input glyph;

%%%%tracingglyph:=2;


%% \section{FONT ADMINISTRATION}

family_name "Plus";
font_name "Plus-001";
font_version "0.0final";

grid_size:=100;
font_matrix(1/grid_size,0,0,1/grid_size,0,0);

font_identifier:="PLUS 001";
font_quad:=100;
font_normal_space:=33;
font_normal_stretch:=17;
font_normal_shrink:=11;
font_x_height:=100;
font_coding_scheme:="FONT SPECIFIC";
is_fixed_pitch true;


%% \section{FONT PARAMETERS}

color plus_color;

u:=1; % unit width
stem_width:=10;

mode_setup;

glyph.set.defaultcolor(blue,"plus");
glyph.set.defaultcolor(red,"minus");

input encqxtex;

reencode("minus", 45);

glyph.new(100,100,0, 0,0,0, "plus", "minus");

%%%%glyph.reset.defaultcolor(green,"plus","minus");


%% \vfill\eject
%% \section{GLYPHS}

%% \PICT{plus}

glyph_begin("plus"); "PLUS";
  interim linecap:=butt;
  pickup pencircle scaled stem_width;
  draw (w/2,-d)--(w/2,h);
  draw (0,(h-d)/2)--(w,(h-d)/2);
glyph_end;

%% \PICT{minus}

glyph_begin("minus"); "MINUS";
  interim linecap:=butt;
  pickup pencircle scaled stem_width;
  draw (0,(h-d)/2)--(w,(h-d)/2);
glyph_end;

endfont

%% \vfill\eject
%% \section{SIMPLE TEST}
%% 
%% \parskip=0pt
%% Whenever a line of text is added to a page being constructed,
%% {\TeX} inserts ``interline glue'' intended to make the distance
%% between baseline of the new line and the baseline of the
%% previous line exactly equal to the value of baselineskip
%% unless that would bring the lines too close together.
%% For examples below the baseline is fixed
%% (see, The {\TeX}book, p.~80). 
%%
%% Below 10 characters per line scaled to $43.2\,$bp are typeset.
%%
%% \lineskiplimit=-\maxdepth
%%
%% \baselineskip=43.2bp
%% \font\X=plus-001 at 43.2bp
%% \vskip 43.2bp
%% \begingroup \obeylines \X 
%% ++++
%% ----
%% ++++
%% ++++
%% ----
%% ++++
%% \endgroup

%% \section{GLYPH LIST}
%% \endproof

%%\end
