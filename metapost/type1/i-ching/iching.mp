%%%%
%%%% This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
%%%%

%%% addto hexagram iching

%% \voffset=-.25in
%% \raggedbottom
%% \font\sectionf=plssbx10 at 13pt
%% \def\section#1{\centerline{\sectionf #1}\vskip\baselineskip}


%% \section{ICHING BASE MACROS}

def chi_en = yang,yang,yang enddef; % cosmos
def chen = yang,yin,yin enddef; % thunder
def k_an = yin,yang,yin enddef; % water
def ken = yin,yin,yang enddef; % mountain
def k_un = yin,yin,yin enddef; % earth
def sun = yin,yang,yang enddef; % wind
def li = yang,yin,yang enddef; % fire
def tui = yang,yang,yin enddef; % lake

def hexagram(text elements_list) = set_initial_position;
  for $:=elements_list: endfor
enddef;

def iching(expr name,code)(text elements_list) =
  encode(name)(code); introduce.name(utilize)(0)();
  beginglyph(name);
    hexagram(elements_list);
%%%%    fix_hstem(hexagram_width)(yang_element(0));
    fix_hsbw(hexagram_width,sidebearing,sidebearing);
  endglyph
enddef;


%% \section{HEXAGRAMS}

beginfont

%% \-----------
%% \PICT{ch'ien1}
%% \-----------

iching("ch'ien1",1)(chi_en,chi_en);

%% \-----------
%% \PICT{ch'ien2}
%% \-----------

iching("ch'ien2",15)(ken,k_un);

%% \-----------
%% \PICT{chien1}
%% \-----------

iching("chien1",39)(ken,k_an);

iching("chien2",53)(ken,sun);

iching("chien3",60)(tui,k_an);

%% \-----------
%% \PICT{k'un1}
%% \-----------

iching("k'un1",2)(k_un,k_un);

iching("k'un2",47)(k_an,tui);

%% \-----------
%% \PICT{chun}
%% \-----------

iching("chun",3)(chen,k_an);

iching("meng",4)(k_an,ken);

iching("hsu",5)(chi_en,k_an);

iching("sung",6)(k_an,chi_en);

iching("shih",7)(k_an,k_un);

iching("pi1",8)(k_un,k_an);

iching("pi2",22)(li,ken);

iching("p'i",12)(k_un,chi_en);

iching("hsiaoch'u",9)(chi_en,sun);

iching("lu1",10)(tui,chi_en);

iching("lu2",56)(ken,li);

iching("t'ai",11)(chi_en,k_un);

iching("t'ungjen",13)(li,chi_en);

iching("tayu",14)(chi_en,li);

iching("yu",16)(k_un,chen);

iching("sui",17)(chen,tui);

iching("ku",18)(sun,ken);

iching("lin",19)(tui,k_un);

iching("kuan",20)(k_un,sun);

iching("shihho",21)(chen,li);

iching("po",23)(k_un,ken);

iching("fu",24)(chen,k_un);

iching("wuwang",25)(chen,chi_en);

iching("atch'u",26)(chi_en,ken);

iching("i1",27)(chen,ken);

iching("i2",42)(chen,sun);

iching("takuo",28)(sun,tui);

iching("k'an",29)(k_an,k_an);

iching("li",30)(li,li);

iching("hsien1",31)(ken,tui);

iching("hsien2",40)(k_an,chen);

iching("heng",32)(sun,chen);

iching("tun",33)(ken,chi_en);

iching("tachuang",34)(chi_en,chen);

iching("chin",35)(k_un,li);

iching("ming",36)(li,k_un);

iching("chiajen",37)(li,sun);

iching("k'uei",38)(tui,li);

iching("sun1",41)(tui,ken);

iching("sun2",57)(sun,sun);

iching("kuai",43)(chi_en,tui);

iching("kou",44)(sun,chi_en);

iching("ts'ui",45)(k_un,tui);

iching("sheng",46)(sun,k_un);

iching("ching",48)(sun,k_an);

iching("ko",49)(li,tui);

iching("ting",50)(sun,li);

iching("chen",51)(chen,chen);

iching("ken",52)(ken,ken);

iching("kueimei",54)(tui,chen);

iching("feng",55)(li,chen);

iching("tui",58)(tui,tui);

iching("huan",59)(k_an,sun);

iching("chungfu",61)(tui,sun);

iching("hsiaokuo",62)(ken,chen);

iching("chichi",63)(li,k_an);

iching("weichi",64)(k_an,li);


%% \vfil\eject
%% \section{TRIGRAMS}

%% Hexagrams are build from the following trigrams.

%% \-----------
%% \PICT{cosmos}
%% \-----------

iching("cosmos",65)(chi_en);
  
%% \-----------
%% \PICT{thunder}
%% \-----------

iching("thunder",66)(chen);
  
%% \-----------
%% \PICT{water}
%% \-----------

iching("water",67)(k_an);

%% \-----------
%% \PICT{mountain}
%% \-----------

iching("mountain",68)(ken);

%% \-----------
%% \PICT{earth}
%% \-----------

iching("earth",69)(k_un);

%% \-----------
%% \PICT{wind}
%% \-----------

iching("wind",70)(sun);

%% \-----------
%% \PICT{fire}
%% \-----------

iching("fire",71)(li);

%% \-----------
%% \PICT{lake}
%% \-----------

iching("lake",72)(tui);

%% \end
