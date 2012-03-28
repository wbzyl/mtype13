%%%%
%%%% This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
%%%%

%%% addto beginhex endhex hexagram iching
%%% good rule

%% \voffset=-.25in
%% \input iching.sty
%% \raggedbottom
%% \font\titleF=plssbx10 at 17pt
%% \font\sectionF=plssbx10 at 13pt
%% \font\ichingF=ichingr at 48pt
%% \def\title#1#2{\centerline{\titleF #1}\vskip2\baselineskip
%%   \centerline{\ichingF#2}\vskip2\baselineskip}
%% \def\section#1{\centerline{\sectionF #1}\vskip\baselineskip}


%% \title{\titleF I\raise1.5pt\hbox{-}CHING FONT}
%%     {\iching{meng}\enspace\iching{hsu}}
%% \smash{\lower 133pt\hbox{\epsfbox{eps/confucius.eps}}}
%% \hangindent=150pt \hangafter=-11
%% The ``I Ching'' is an acient Chinese oracle that contains
%% one of the first descriptions of relationship of humans to
%% nature and society.
%% The {\it I Ching\/} translates to {\it The Book of Changes}.
%% It is the oldest book which survived to our times
%% and possible one of the most valued treasures of the world
%% literature. Its origins date back about 5000 years.
%% The ``I Ching'' evolved over the centuries.\hfil\break
%% The basic elements of {\it I Ching\/} oracle are hexagrams.
%% Each inquiry to the oracle will result in a hexagram reading
%% and possibly additional line readings.
%% Confucius, shown on the picture, wrote commentaries to
%% the these readings.\hfil\break
%% Hexagram is made up of two trigrams. There are eight trigrams:
%% Ch'ien (Cosmos), Chen (Thunder), K'an (Water), Ken (Mountain),
%% K'un (Earth), Sun (Wind/Wood), Li (Fire), Tui (Lake).
%% Each trigram is made up of three rules. Each rule is broken or
%% solid. A broken rule stands for {\it yin\/} -- the female force and
%% solid line for {\it yang} -- the male force.

input type1;


%% \section{YIN \& YANG}

%% The golden proportion is approximated by $F_{12}/F_{13}$, where
%% $F_n$ is the $n$-th Fibonacci number.

golden_proportion:=144/233; % an approximation of

hexagram_height:=750;
hexagram_width:=golden_proportion*hexagram_height;
depth:=0;

element_gap:=31;
hexagram_height=6element_height+5element_gap;

yin_gap=1/3hexagram_width;
hexagram_width=2yin_width+yin_gap;
hexagram_width=yang_width;

vardef yin_rule = unitsquare xscaled yin_width yscaled element_height enddef;
vardef yang_rule = unitsquare xscaled yang_width yscaled element_height enddef;

element_shift=round(element_height+element_gap);
yin_shift=round(yin_width+yin_gap);
def yin_element(expr n) =
 yin_rule shifted (n*element_shift*up),
 yin_rule shifted (n*element_shift*up+yin_shift*right)
enddef;
def yang_element(expr n) =
  yang_rule shifted (n*element_shift*up)
enddef;

newinternal element_position;
def set_initial_position = hide(element_position:=-1) enddef;
def incr_position = hide(element_position:=element_position+1) enddef;

vardef yin = incr_position;
  Fill yin_element(element_position);
  fix_vstem(yin_width)(yin_element(element_position));
  fix_vstem(yin_width)(yin_element(element_position));
  fix_hstem(element_height)(yin_element(element_position));
enddef;

vardef yang = incr_position;
  Fill yang_element(element_position);
  fix_hstem(element_height)(yin_element(element_position));
enddef;


%% \section{FONT ADMINISTRATION}

math_axis:=1/2hexagram_height;
sidebearing:=hexagram_width/8;

pf_info_designsize 10pt#; % the "design size" of this font
pf_info_familyname "I-Ching";
pf_info_fontname "I-Ching-Regular";
pf_info_weight "Normal";
pf_info_version "1.0";
pf_info_capheight hexagram_height;
pf_info_xheight hexagram_height;
pf_info_space hexagram_width/3;
pf_info_adl hexagram_height, 0, 0;
pf_info_author "Wlodek Bzyl 2002";
pf_info_encoding "FONT SPECIFIC";
pf_info_creationdate;

input iching;

endfont.

%% \eject
%% \section{FONT TABLE}
%%
%% \ichingFontTable{ichingr at 27bp}
%%
%%\end
