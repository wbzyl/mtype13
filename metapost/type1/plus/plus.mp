%%%%
%%%% This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
%%%%
%%%% \def\PICT#1{\LINE{\SETPICT{\jobname}{#1}{\hsize}{150mm}}}

%%% addto fill_outline dotlabels

%% \raggedbottom
%% \font\titlef=plssbx10 at 17pt
%% \font\sectionf=plssbx10 at 13pt
%% \def\title#1#2{\eject
%%   \centerline{\titlef #1}\vskip2\baselineskip}
%% \def\section#1{\bigskip
%%   \centerline{\sectionf #1}\vskip\baselineskip}


%% \title{PLUS FONT}

input type1;

%% \section{FONT ADMINISTRATION}

pf_info_designsize 10pt#; % the "design size" of this font
pf_info_familyname "Plus";
pf_info_fontname "Plus-Regular";
pf_info_weight "Normal";
pf_info_version "1.0";
pf_info_author "Anonymous 2002";
pf_info_creationdate;
pf_info_fixedpitch true;

pf_info_quad 760;
pf_info_capheight 760;
pf_info_xheight 760;
pf_info_space 333;
pf_info_adl 750, 250, 0;

%% \section{BASE MACROS}

def fill_outline suffix s =
  for i:=1 upto s.num:
   if turningnumber s[i] > 0: Fill else: unFill fi \\ s[i];
  endfor
enddef;

def butt_end(text nodes) = cut(rel 90)(nodes) enddef;

numeric px; px:=100;
numeric py; py:=90;
default_nib:=fix_nib(px,py,0);

path vertical_stem, horizontal_stem, glyph;


beginfont

%% \-----------
%% \PICT{plus}
%% \-----------

%%%% beginpic("plus",43,760,760,0);

encode("plus")(43);
standard_introduce("plus");

beginglyph("plus");

  w:=760; h:=760; d:=0;
  z0=(w/2,d); z1=(w/2,h);
  z2=(0,(h-d)/2); z3=(w,(h-d)/2);

  pen_stroke(butt_end(0,1))(z0--z1)(vertical_stem);
  pen_stroke(butt_end(0,1))(z2--z3)(horizontal_stem);
  find_outlines(vertical_stem,horizontal_stem)(glyph);

  fill_outline glyph;

  fix_hsbw(w,0,0);

  fix_hstem(py)(horizontal_stem);
  fix_vstem(px)(vertical_stem);
  
  dotlabels(0,1,2,3);

endglyph;

endfont;
