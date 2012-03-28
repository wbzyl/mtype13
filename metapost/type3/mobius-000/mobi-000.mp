%%%%
%%%% This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
%%%%

%% \setfontname mobi-000


%% \title{M\"OBIUS BAND FONT}

%% The m\"obius band was taken from the {\it The METAFONTbook\/}
%% by D.~E. Knuth, Excercise 13.11.

family_name:="Math";
font_name:="Mobius-000";
font_version:="1.0";
font_identifier:="MOBIUS 500";
is_fixed_pitch:=true;
font_coding_scheme:="FONT SPECIFIC";

font_quad:=60;
font_normal_space:=60;
font_normal_stretch:=0;
font_normal_shrink:=0;
font_x_height:=14;

grid_size:=14;
font_matrix(1/grid_size, 0, 0, 1/grid_size, 0, 0);


%% \section{FONT PARAMETERS}

numeric border_width;
color default_border_color, border_color[], strip_color[];

border_width:=1.6;
default_border_color:=black;

mode_setup;

for i=0 upto 1:
  if unknown border_color[i]: border_color[i]=default_border_color; fi
endfor

for i=0 upto 24:
  if unknown strip_color[i]: strip_color[i]:=i/24*white; fi
endfor

%%%% for i=0 upto 24: strip_color[i]:=(i/24,0,0); endfor
%%%% for i=0 upto 24:
%%%%   strip_color[i]:= (0,1/2+uniformdeviate 0.5,1/2+uniformdeviate 0.5);
%%%% endfor


%% \section{LABELS}

dotlabeldiam:=1;
defaultscale:=0.25;
defaultfont:="cmss10";
defaultrulethickness:=0.25;
labeloffset:=1;
proofscale:=3;
dotcolor:=red; labelcolor:=red;

%% \section{M\"OBIUS PATH}
%%
%% The numbers below are taken from the solution
%% to the Exercise 13.11 from {\it The METAFONTbook}.

vardef mobius_path =
  z1=(20,-13); z2=(30,-6);
  z3=(20,1); z4=(4,-7);
  z5=(-12,-13); z6=(-24,-4);
  z7=(-15,6);
  origin..z1..z2..z3..z4..z5..z6..z7..
    origin..-z7..-z6..-z5..-z4..-z3..-z2..-z1..cycle
enddef;

vardef link(expr n, p) =
  subpath 1/3(n,n+1) of p -- subpath 1/3(n+25,n+24) of p -- cycle
enddef;


%% \section{GLYPHS}

%% \glyph 48

beginpic("0",60,14,14); "0 -- The Mobius Watchband Corporation logo";
  drawoptions(withpen pencircle scaled border_width withcolor border_color[0]);
  path M; M=mobius_path shifted (30,0);
  for k=1 upto 12:
    unfill link(k+11,M); draw link(k+11,M);
    unfill link(12-k,M); draw link(12-k,M);
  endfor
  piclabels.bot((30,0),1)(range 0 thru 7);
  for i=1 upto 7: makepiclabel.top(decimal -i,-z[i],(30,0),1); endfor
endpic;

%% \glyph 49

beginpic("1",60,14,14); "1 -- user colored band";
  drawoptions(withpen pencircle scaled border_width withcolor border_color[1]);
  path M; M=mobius_path shifted (30,0);
  for k=1 upto 12:
    fill link(k+11,M) withcolor strip_color[k+11]; draw link(k+11,M);
    fill link(12-k,M) withcolor strip_color[k+11]; draw link(12-k,M);
  endfor
endpic;

bye

%% \vfil\eject
%% \font\eightssi=cmssqi8
%% \font\eightss=cmssq8
%% \def\author#1(#2){\begingroup
%%   \parfillskip 0pt
%%   \interlinepenalty 10000
%%   \leftskip 0pt plus 40pc
%%   \let\rm=\eightss \let\sl=\eightssi
%%   \bigskip\noindent\rm--- #1\unskip\enspace(#2)\par\endgroup}
%% \font\manual=manfnt % font used for the METAFONT logo, etc.
%% \def\MF{{\manual META}\-{\manual FONT}}%
%% \def\ldots{\mathinner{\ldotp\kern-.2em\ldotp\kern-.2em\ldotp}}
%% \def\!{\kern-.03em\relax}
%% \font\mF=mobi-000 at 8pt
%% \def\divider #1{$$\vcenter{\halign{\hss\mF##\hss\cr#1\cr}}$$}
%%
%% \title{M\"OBIUS FONT TEST}
%%
%% Generation  of letterforms by mathematical means
%% was first tried in the fifteenth century; it became popular in the
%% sixteenth and seventeenth centuries; and it was abandoned (for good
%% reasons) during the eighteenth century. Perhaps the twentieth century
%% will turn out to be the right time for this idea to make a comeback,
%% now that mathematics has advanced and computers are able to
%% do the calculations.
%% \divider 0
%% A top-notch designer of typefaces needs to have an unusually good eye
%% and a highly developed sensitivity to the nuances of shapes.
%% A top-notch user of computer languages needs to have an unusual
%% talent for abstract reasoning and a highly developed ability to
%% express intuitive ideas in formal terms. Very few people have both
%% of these unusual combinations of skills; hence the best products of
%% \MF\ will probably be collaborative efforts between two
%% people who complement each other's abilities. Indeed, this situation
%% isn't very different from the way types have been created for many
%% generations, except that the r\^ole of ``punch-cutter'' is now being
%% played by skilled computer specialists instead of by skilled
%% metalworkers. $[\ldots]$
%% \divider 1
%% Although there is no royal road to type design, there are some things that
%% can, in fact, be done well with \MF\ in an afternoon. Geometric designs
%% are rather easy; and it doesn't take long to make modifications to letters
%% or symbols that have previously been expressed in \MF\ form. Thus,
%% although comparatively few users of \MF\ will have the courage to do an
%% entire alphabet from scratch, there will be many who will enjoy
%% customizing someone else's design.  $[\ldots]$
%%
%% \author DONALD E. KNUTH, {\sl The METAFONTbook} (1986)

%%\end
