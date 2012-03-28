%%%%
%%%% This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
%%%%

%% \setfontname plus-000 %%%% required by the |\glyph| macro


%% \title{\titleF PLUS FONT}

%% This simple font is taken from the article
%% {\it Re-introducing Type~3 fonts to the world of {\TeX}\/}
%% published in the Euro{\TeX} 2001 proceedings.
%% The PDF file with the article is stored in
%% {\tt doc/metapost/type3/eurotex2001} directory.


%% \section{FONT ADMINISTRATION}

family_name "Plus";
font_name "Plus-000";
font_version "0.0final";

grid_size:=100;
font_matrix(1/grid_size,0,0,1/grid_size,0,0);

font_identifier:="PLUS 000";
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
plus_color:=red;

mode_setup;


%% \section{GLYPHS}

%% \glyph 43

beginpic("+",100u,100,0); "+  plus";
  interim linecap:=butt;
  drawoptions(withcolor plus_color);
  pickup pencircle scaled stem_width;
  draw (0,(h-d)/2)--(w,(h-d)/2);
  draw (w/2,-d)--(w/2,h);
endpic;

endfont

%% \vfil\eject
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
%% \font\X=plus-000 at 43.2bp
%% \vskip 43.2bp
%% \begingroup \obeylines \X 
%% ++++
%% ++++
%% ++++
%% ++++
%% \endgroup

%%\end
