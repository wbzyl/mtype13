%%%%
%%%% This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
%%%%

%%% addto iching initialize

%% \font\ICF=iching-d00 at 25pt
  
%% \setfontname iching-000 %%%% required by the |\glyph| macro


%% \title{\titleF I\raise1.5pt\hbox{-}CHING FONT}
%%
%% \centerline{\ICF\char11\char6\char10}
%% \bigskip
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


%% \section{THE YIN \& YANG DESIGN}

%% The golden proportion is approximated by $F_{12}/F_{13}$, where
%% $F_n$ is the $n$-th Fibonacci number.

%%%%hexagram_width=144; % $F_{12}=144$
hexagram_width=144;
hexagram_height=233; % $F_{13}=233$

%% Below we define standard hexagram shapes.

yang_width:=hexagram_width; yin_width:=hexagram_width/3;

vardef yin_rule = unitsquare xscaled yin_width yscaled element_height
enddef;
vardef yang_rule = unitsquare xscaled yang_width yscaled element_height
enddef;

vardef yin_color = (uniformdeviate 1,uniformdeviate 1,uniformdeviate 1)
enddef;
vardef yang_color = (uniformdeviate 1,uniformdeviate 1,uniformdeviate 1)
enddef;

def initialize(suffix p) = save p; picture p; p:=nullpicture enddef;

vardef yin = initialize(yin_pic);
  addto yin_pic contour yin_rule
    withcolor yin_color;
  addto yin_pic contour yin_rule
    shifted (2yin_width*right) withcolor yin_color;
  yin_pic
enddef;
vardef yang = initialize(yang_pic);
  addto yang_pic contour yang_rule
      withcolor yang_color;
  yang_pic
enddef;

newinternal position;
def set_initial_position = position:=0 enddef;
def incr_position = position:=position+1 enddef;

def hexagram(text arg_list) = set_initial_position;
    for $=arg_list:
      draw $ shifted (position*element_shift*up);
      incr_position;
    endfor
enddef;


%% \section{FONT ADMINISTRATION}

family_name "I-Ching";
font_name "I-Ching-000";
font_version "0.0final";

grid_size:=hexagram_height;
font_matrix(1/grid_size,0,0,1/grid_size,0,0);

font_identifier:="ICHING 000";
font_quad:=hexagram_width;
font_normal_space:=hexagram_width/3;
font_normal_stretch:=hexagram_width/6;
font_normal_shrink:=hexagram_width/9;
font_x_height:=hexagram_height;
font_coding_scheme:="FONT SPECIFIC";
is_fixed_pitch true;

newinternal leftsidebearing, rightsidebearing;
leftsidebearing:=hexagram_width/8; rightsidebearing:=leftsidebearing;

%% The macros above could be redefined by the $\2{mode\_setup}$ macro.
%% Several examples of such changes are contained in the file
%% {\tt redis.mp} and are typeset at the end of this program.

mode_setup;

if unknown interelement_gap: interelement_gap:=10; fi
element_shift=element_height+interelement_gap;
6element_height+5interelement_gap=hexagram_height;

def iching(text arg_list)(expr code) = begingroup
    charcode:=code; w:=hexagram_width; h:=hexagram_height; d:=0;
    clearxy; clearit; clearpen; drawoptions();
    hexagram(arg_list);
    w:=leftsidebearing+w+rightsidebearing;
    interim xoffset:=leftsidebearing;
    write decimal charcode & ":" & decimal w to pcw_file;
    charwd:=w#; charht:=h#; chardp:=d#;
    if charic<>0: charic:=charic#; fi
    shipit;
  endgroup
enddef;


%% \eject
%% \section{TRIGRAMS}

%% Each trigram represents, so called, {\it Eight Pre-causes of
%% The Real World\/}:
%% Cosmos, Thunder, Water, Mountain, Earth, Wind, Fire and Lake.

def ch_ien = yang,yang,yang enddef; % Cosmos
def chen = yang,yin,yin enddef; % Thunder
def k_an = yin,yang,yin enddef; % Water
def ken = yin,yin,yang enddef; % Mountain
def k_un = yin,yin,yin enddef; % Earth
def sun = yin,yang,yang enddef; % Wind
def li = yang,yin,yang enddef; % Fire
def tui = yang,yang,yin enddef; % Lake

iching(ch_ien)(65); "cosmos"; 
iching(chen)(66); "thunder";
iching(k_an)(67); "water";
iching(ken)(68); "mountain";
iching(k_un)(69); "earth";
iching(sun)(70); "wind";
iching(li)(71); "fire";
iching(tui)(72); "lake";


%% \section{HEXAGRAMS}

%% Each hexagram is build from two trigrams.

iching(ch_ien,ch_ien)(1); "ch'ien";
iching(k_un,k_un)(2); "k'un";
iching(chen,k_an)(3); "chun";
iching(k_an,ken)(4); "meng";
iching(ch_ien,k_an)(5); "hsu";
iching(k_an,ch_ien)(6); "sung";
iching(k_an,k_un)(7); "shih";
iching(k_un,k_an)(8); "pi";
iching(ch_ien,sun)(9); "hsiao ch'u";
iching(tui,ch_ien)(10); "lu";

iching(ch_ien,k_un)(11); "t'ai";
iching(k_un,ch_ien)(12); "p'i";
iching(li,ch_ien)(13); "t'ung jen";
iching(ch_ien,li)(14); "ta yu";
iching(ken,k_un)(15); "ch'ien";
iching(k_un,chen)(16); "yu";
iching(chen,tui)(17); "sui";
iching(sun,ken)(18); "ku";
iching(tui,k_un)(19); "lin";
iching(k_un,sun)(20); "kuan";

iching(chen,li)(21); "shih ho";
iching(li,ken)(22); "pi";
iching(k_un,ken)(23); "po";
iching(chen,k_un)(24); "fu";
iching(chen,ch_ien)(25); "wu wang";
iching(ch_ien,ken)(26); "ta ch'u";
iching(chen,ken)(27); "i";
iching(sun,tui)(28); "ta kuo";
iching(k_an,k_an)(29); "k'an";
iching(li,li)(30); "li";

iching(ken,tui)(31); "hsien";
iching(sun,chen)(32); "heng";
iching(ken,ch_ien)(33); "tun";
iching(ch_ien,chen)(34); "ta chuang";
iching(k_un,li)(35); "chin";
iching(li,k_un)(36); "ming";
iching(li,sun)(37); "chia jen";
iching(tui,li)(38); "k'uei";
iching(ken,k_an)(39); "chien";
iching(k_an,chen)(40); "hsien";

iching(tui,ken)(41); "sun";
iching(chen,sun)(42); "i";
iching(ch_ien,tui)(43); "kuai";
iching(sun,ch_ien)(44); "kou";
iching(k_un,tui)(45); "ts'ui";
iching(sun,k_un)(46); "sheng";
iching(k_an,tui)(47); "k'un";
iching(sun,k_an)(48); "ching";
iching(li,tui)(49); "ko";
iching(sun,li)(50); "ting";

iching(chen,chen)(51); "chen";
iching(ken,ken)(52); "ken";
iching(ken,sun)(53); "chien";
iching(tui,chen)(54); "kuei mei";
iching(li,chen)(55); "feng";
iching(ken,li)(56); "lu";
iching(sun,sun)(57); "sun";
iching(tui,tui)(58); "tui";
iching(k_an,sun)(59); "huan";
iching(tui,k_an)(60); "chien";

iching(tui,sun)(61); "chung fu";
iching(ken,chen)(62); "hsiao kuo";
iching(li,k_an)(63); "chi chi";
iching(k_an,li)(64); "wei chi";

endfont


%% \input iching.sty
%% \hfuzz=5bp
%% \vfil\eject
%% \title{VARYING FONT PARAMETERS}
%% 
%% \ichingFontTable{iching-000 at 27bp}
%% \eject
%% \ichingFontTable{iching-a00 at 27bp}
%% \eject
%% \ichingFontTable{iching-b00 at 27bp}
%% \eject
%% \font\titleF=cmssbx10 at 21pt
%% \centerline{{\ICF\iching{i1}}\quad{\titleF HEXAGONAL}
%%    \enspace{\ICF\iching{k'an}}\enspace
%%    {\titleF HEXAGRAMS}\quad{\ICF\iching{hsiao kuo}}}
%% \bigskip
%% \ichingFontTable{iching-d00 at 27bp}

%%\end
