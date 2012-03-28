%%%%
%%%% This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
%%%%

%%% addto beginhex endhex hexagram iching
%%% good rule

%% \voffset=-.25in
%% \input iching.sty
%% \raggedbottom
%% \font\titlef=plssbx10 at 17pt
%% \font\sectionf=plssbx10 at 13pt
%% \font\ichingf=ichings at 48pt
%% \def\title#1#2{\centerline{\titlef #1}\vskip2\baselineskip
%%   \centerline{\ichingf#2}\vskip2\baselineskip}
%% \def\section#1{\centerline{\sectionf #1}\vskip\baselineskip}


%% \title{I CHING STARS}
%%     {\iching{meng}\enspace\iching{hsu}}

input type1;


%% \section{YIN TRIANGLE \& YANG RHOMBUS} 

golden_proportion:=144/233; % an approximation of

hexagram_height:=750;
hexagram_width:=golden_proportion*hexagram_height;
depth:=0;

hexagram_height=6element_height+5element_gap;

hexagram_width=3rhombus_size;

yin_gap=1/3hexagram_width;
hexagram_width=2yin_width+yin_gap;
hexagram_width=yang_width;

vardef yin_rule =
 (right--(right+right rotated 60)--(right+left rotated -60)--cycle) 
    scaled rhombus_size
enddef;
vardef yang_rule =
 (origin--right--(right+right rotated 60)--(right+left rotated -60)--cycle)
    scaled rhombus_size
enddef;

def yin_element(expr n) =
  yin_rule rotated 60n shifted (3/2rhombus_size,3/2rhombus_size)
enddef;

def yang_element(expr n) =
  yang_rule rotated 60n shifted (3/2rhombus_size,3/2rhombus_size)
enddef;

newinternal element_position;
def set_initial_position = hide(element_position:=-1) enddef;
def incr_position = hide(element_position:=element_position+1) enddef;

vardef yin = incr_position;
  Fill yin_element(element_position);
enddef;

vardef yang = incr_position;
  Fill yang_element(element_position);
enddef;


%% \section{FONT ADMINISTRATION}

math_axis:=1/2hexagram_height;
%%%%sidebearing:=hexagram_width/8;
sidebearing:=0;

pf_info_familyname "I-Ching";
pf_info_fontname "I-Ching-Star";
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

%% \section{FONT TABLE}
%%
%% \ichingFontTable{ichings at 27bp}
%%
%%\end
