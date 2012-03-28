%%%%
%%%% This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
%%%%

%% \setfontname sign-000

%% \font\signF=sign-000 at 11pt
%% \font\signFF=sign-000 at 18pt
%% \font\X=sign-000 at 10pt
%% \font\ttt=cmtt10
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
%% \def\bs{\char 92 }
%% \def\lb{\char 123 } \def\rb{\char 125 }
%%
%% \catcode`\@=11
%% \def\dbend{{\signF\char127}} % dangerous bend sign
%% \def\stop{{\signF S}} % stop sign
%% \def\warn{{\signF W}} % holes sign
%% \def\limited{{\signF N}} % narrow sign
%% \def\exclamation{{\signF !}}
%% \def\d@nger#1{\medbreak\begingroup\clubpenalty=10000 \parindent=3pc
%%  \def\par{\endgraf\endgroup\medbreak} \noindent\hang\hangafter=-2
%%  \hbox to0pt{\hskip-\hangindent#1\hfill}}
%% \outer\def\danger#1{\d@nger#1}
%% \outer\def\ddanger#1{\d@nger{#1\kern.1pc#1}}
%% \catcode`\@=12


%% \title{SIGNPOST FONT}
%% 
%% \noindent In order to make it possible for many types of users to read this
%% manual effectively, a special sign is used to designate material that
%% is for wizards only: When the symbol
%% $$\vbox{\hbox{\signF\char127}\vskip 11pt}$$
%% appears at the beginning of a paragraph, it warns of a ``dangerous bend''
%% in the train of thought; don't read the paragraph unless you need to.
%% Brave and experienced drivers at the controls of \TeX\ will gradually enter
%% more and more of these hazardous areas, but for most applications the
%% details won't matter.
%%
%% \author DONALD E. KNUTH, {\sl The {\TeX}book} (1994)
%%
%% \section{ATTENTION$\,$! ATTENTION$\,$!}
%%
%% \ddanger\stop This font uses a {\TeX} font metric file {\tt phvb8rn.tfm}
%% which contains character dimensions for Type~1 font named
%% {\bf Helvetica-Narrow-Bold}.
%% So, to use the {\bf Signpost-000} font in a {\TeX} manuscript,
%% it does not suffice to associate it with a control sequence, e.g.
%% \begindisplay
%%   {\ttt \bs font\bs signF = sign-000 at 11pt}
%% \enddisplay
%% You must explicitly tell the {\tt dvips} program to record the use of
%% {\bf Helvetica} in the {\TeX} document. This could be achieved by including 
%% the following two lines in the document:
%% \begindisplay
%%   {\ttt \bs input type3}& include Type 3 macros\cr
%%   {\ttt \bs includefonts\lb sign-000.t1\rb}\cr
%% \enddisplay

input colors

family_name "Signpost";
font_name "Signpost-000";
font_version "1.0";
is_fixed_pitch false;

font_identifier:="SIGNPOST 000";
font_quad:=250;
font_normal_space:=250;
font_normal_stretch:=0;
font_normal_shrink:=0;
font_x_height:=125;
font_coding_scheme:="FONT SPECIFIC";

grid_size:=180;
font_matrix(1/grid_size, 0, 0, 1/grid_size, 0, 0);


%% \section{FONT PARAMETERS}

newinternal post_width, border_width;
newinternal ground_distance;

color c.Post;
color c.Info.Background, c.Info.Border;
color c.Stop.Background, c.Stop.Border, c.Stop.Margin;
color c.Exclamation.Text;
color c.Warning.Background, c.Warning.Border;
color c.Dangerous.Bend;
color c.Stop.Text;
color c[]Warning;

%% Parameters used to draw posts.

post_width:=10; % width of post parts
ground_distance:=200; % post height

%% Colors used to draw various parts of signposts.

c.Post:=Brown;
c.Info.Border:=Black;
c.Info.Background:=Yellow;
c.Stop.Border:=Red;
c.Stop.Background:=Red;
c.Stop.Margin:=White;
c.Warning.Background:=Yellow;
c.Warning.Border:=Red;

border_width:=10; % width of pen used to paint stripe around board

%% Colors used for drawing on boards.

c.Dangerous.Bend:=Black;
c.Stop.Text:=White;
c.Exclamation.Text:=Black;
c1Warning:=Black;
c2Warning:=Black;

mode_setup;


%% \section{BASE MACROS}

pen post_pen, border_pen;
post_pen=pencircle scaled post_width;
border_pen=pencircle scaled border_width;

newinternal short_post; short_post:=0;

vardef post =
  save post, ground, pic;
  clearxy;
  path post, ground;
  picture pic; pic:=nullpicture;
  pickup post_pen;
  x2p=x1p=115; x3p=x4p=250-x2p;
  y2p=y3p=if short_post=0: 140; else: 0; fi
  bot y1p=-ground_distance;
  y4p=y5p=y6p=y1p;
  post=z1p--z2p--z3p--z4p;
  x5p=250-x6p; x6p-x5p=160;
  ground=z5p--z6p;
  addto pic doublepath post withpen post_pen withcolor c.Post;
  addto pic doublepath ground withpen post_pen withcolor c.Post;
  pic
enddef;

vardef info_signboard =
  save signboard, pic;
  clearxy;
  path signboard; picture pic; pic:=nullpicture;
  pickup border_pen;
  top y1=125; lft x4=0;
  x1+x1=x1a+x1b=x4b+x2a=x4+x2=x4a+x2b
    =x3b+x3a=x3+x3=250;
  x4a=x4b=x4+10; x3b=x1a=x1-20;
  y4+y4=y4a+y4b=y3b+y1a=y3+y1=y3a+y1b
    =y2b+y2a=y2+y2=0;
  y1a=y1b=y1-10;
  y4b=y2a=y4+20;
  signboard=z1a..z1..z1b---z2a..z2..z2b---
    z3a..z3..z3b---z4a..z4..z4b---cycle;
  addto pic contour signboard
    withcolor c.Info.Background;
  addto pic doublepath signboard withpen border_pen
    withcolor c.Info.Border;
  pic
enddef;

vardef stop_signboard =
  save signboard_o, signboard_i, pic, r;
  clearxy;
  path signboard_o, signboard_i;
  picture pic; pic:=nullpicture;
  numeric r;
  pickup border_pen;
  r=(250-(pen_rt-pen_lft))/(2cosd(45/2));
  z0=r*dir(45/2);
  for i=1 upto 8: z[i]=z0 rotated 45i; endfor
  signboard_o=z1---z2---z3---z4---z5---z6---z7---z8---cycle;
  signboard_i=signboard_o scaled 8/9;
  addto pic contour signboard_o shifted (250/2,0)
      withcolor c.Stop.Margin;
  addto pic doublepath signboard_o shifted (250/2,0)
      withpen border_pen withcolor c.Stop.Border;
  addto pic contour signboard_i shifted (250/2,0)
      withcolor c.Stop.Background;
  pic
enddef;

vardef warning_signboard =
  save signboard, pic, r;
  clearxy;
  path signboard;
  picture pic; pic:=nullpicture;
  numeric r;
  pickup border_pen;
  r=1/2(250-(pen_rt-pen_lft))/cosd 30;
  z0=r*dir(30);
  for i=1 upto 6: z[i]=z0 rotated 60i; endfor
  z1r=1/9[z1,z6]; z1l=1/9[z1,z2];
  z3r=1/9[z3,z2]; z3l=1/9[z3,z4];
  z5r=1/9[z5,z4]; z5l=1/9[z5,z6];
  signboard=z1r..z1..z1l---z3r..z3..z3l---z5r..z5..z5l---cycle;
  addto pic contour signboard shifted (250/2,0)
      withcolor c.Warning.Background;
  addto pic doublepath signboard shifted (250/2,0)
      withpen border_pen withcolor c.Warning.Border;
  pic
enddef;


%% \section{SETTING UP LABELS}

defaultfont:="cmssbx10";
dotlabeldiam:=3;
defaultscale:=0.9;
defaultrulethickness:=0.2;
labeloffset:=5;
proofscale:=1;

%% Use the label macro for text positioning.

def label = draw thelabel enddef;

%% Use {\bf Helvetica Narrow Bold} for typesetting text on signboards.

verbatimtex
    \font\signF=cmssbx10 \signF
etex

%% \vfil\eject
%% \section{GLYPHS}
%% \bigskip

%% \glyph 127

beginpic(127,250,125,0); "Dangerous bend";
  draw post; draw info_signboard;
  clearxy;
  % the dangerous bend
  numeric heavyline; heavyline:=27;
  x5=w-x0; x5-x0=80; x1=x2=x5; x0=x3=x4;
  y0=-y5=1/2h; y1=-y4=1/3h; y2=-y3=1/11h;
  pickup pencircle scaled heavyline;
  interim linecap:=butt;
  draw z0--z1{z1-z0}..z2---z3..z4{z5-z4}--z5
    withcolor c.Dangerous.Bend;
  labelcolor:=white; dotcolor:=white;
  labels.lft(1,2,3,4,5); labels.rt(0);
endpic;

%% \glyph 83

beginpic("S",250,125,0); "Stop";
  draw post;
  draw stop_signboard;
  label(btex STOP etex \\ scaled 7, (w/2,0)) withcolor c.Stop.Text;
endpic;

%% \glyph 84

beginpic("T",250,125,0); "Type";
  draw post;
  draw stop_signboard;
  label(btex TYPE etex \\ scaled 7, (w/2,0)) withcolor c.Stop.Text;
endpic;

%%%% English names of these signs?

%% \glyph 33

beginpic("!",250,125,0); "Warning";
  interim short_post:=1;
  draw post; draw warning_signboard;
  label(btex ! etex
    scaled 20, (w/2,15)) withcolor c.Exclamation.Text;
endpic;

%% \glyph 87

beginpic("W",250,125,0); "Holes";
  interim short_post:=1;
  draw post; draw warning_signboard;
  fill (45,-25)--(45,-50)--(205,-50)--(205,-25){left}..
      (165,0){left}..(125,-23){left}..(85,0){left}..{left}cycle
    withcolor c1Warning;
endpic;

%% \glyph 78

beginpic("N",250,125,0); "Narrow";
  path road; numeric road_width;
  interim short_post:=1;
  road_width=20;
  draw post;
  draw warning_signboard;
  interim linecap:=butt;
  road=(90,-55)--(90,0)--(108,25)--(108,70);
  pickup pencircle scaled road_width;
  draw road withcolor c2Warning;
  draw road reflectedabout((250/2,0),(250/2,1)) withcolor c2Warning;
endpic;

bye

%% \vfil\eject
%% \section{TEST OF SIGNPOST FONT}
%% \smallskip 
%% \centerline{\signFF W\quad\char127\quad S\quad W\quad !} 
%% \bigskip\bigskip
%%
%% \ddanger\dbend Generation of letterforms by mathematical means was
%% first tried in the fifteenth century; it became popular in the
%% sixteenth and seventeenth centuries; and it was abandoned (for good
%% reasons) during the eighteenth century. Perhaps the twentieth
%% century will turn out to be the right time for this idea to make a
%% comeback, now that mathematics has advanced and computers are able
%% to do the calculations.
%%
%% \ddanger\limited A top-notch designer of typefaces needs to have an
%% unusually good eye and a highly developed sensitivity to the nuances
%% of shapes. A top-notch user of computer languages needs to have an
%% unusual talent for abstract reasoning and a highly developed ability
%% to express intuitive ideas in formal terms. Very few people have
%% both of these unusual combinations of skills; hence the best
%% products of \MF\ will probably be collaborative efforts between two
%% people who complement each other's abilities. Indeed, this situation
%% isn't very different from the way types have been created for many
%% generations, except that the r\^ole of ``punch-cutter'' is now being
%% played by skilled computer specialists instead of by skilled
%% metalworkers. $[\ldots]$
%%
%% \ddanger\warn Although there is no royal road to type design, there
%% are some things that can, in fact, be done well with \MF\ in an
%% afternoon. Geometric designs are rather easy; and it doesn't take
%% long to make modifications to letters or symbols that have
%% previously been expressed in \MF\ form. Thus, although comparatively
%% few users of \MF\ will have the courage to do an entire alphabet
%% from scratch, there will be many who will enjoy customizing someone
%% else's design. $[\ldots]$
%%
%% \ddanger\exclamation The reason for such different levels of complexity is
%% that people change as they grow accustomed to any powerful tool.
%% When you first try to use \MF\!, you'll find that some parts of it
%% are very easy, while other things will take some getting used to. At
%% first you'll probably try to control the shapes too rigidly, by
%% overspecifying data that has been copied from some other medium. But
%% later, after you have begun to get a feeling for what the machine
%% can do well, you'll be a different person, and you'll be willing to
%% let \MF\ help contribute to your designs as they are being
%% developed. As you gain more and more experience working with this
%% unusual apprentice, your perspective will continue to change and you
%% will run into different sorts of challenges. $[\ldots]$
%%
%% \ddanger\stop Type design can be hazardous to your other
%% interests.  Once you get hooked, you will develop intense feelings about
%% letterforms; the medium will intrude on the messages that you read. And you
%% will perpetually be thinking of improvements to the fonts that you see
%% everywhere, especially those of your own design.
%%
%% \author DONALD E. KNUTH, {\sl The METAFONTbook} (1986)

%%\end

%%\end
