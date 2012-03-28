%%%%
%%%% This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
%%%%

%% \title{PROOF LABELS AND RULES}

%% The next main section of {\tt type3.mp} is devoted to macros for the
%% annotations on proofsheets.

newinternal proofing; % $<0$ to supress output; $>1$ to do labels
color proofcolor; % color for output when $\\{proofing}>0$
proofcolor=.3[white,black];
color rulecolor; % color for output when $\\{proofing}>0$
rulecolor=.5[white,black];
color background; background=white;
color dotcolor, labelcolor; dotcolor=black; labelcolor=black;

%%%%newinternal defaultdotsize; defaultdotsize:=3;
newinternal defaultrulethickness; defaultrulethickness:=1;

%% Labels are generated at the lowest level by $\2{makelabel}$ and
%% $\2{makepiclabel}$:

%% Labels and grids are drawn just before the picture is shipped.

picture picproof_; picproof_:=nullpicture;

def drawproof expr p =
  addto picproof_
  if picture p:
    also p
  else:
    doublepath p withpen currentpen
  fi
  _op_
enddef;

def fillproof expr c = addto picproof_ contour c _op_ enddef;

%% Put string \\{s} near point \\{z}.

vardef makelabel@#(expr s,z) = picture p;
  if proofing>1: if known z:
      p = s infont defaultfont scaled defaultscale;
      drawproof p \\ shifted
	(z + labeloffset*laboff@# -
	(labxf@#*lrcorner p + labyf@#*ulcorner p
	    + (1-labxf@#-labyf@#)*llcorner p))
      withcolor labelcolor;
      interim linecap:=rounded;
      drawproof z withpen pencircle scaled dotlabeldiam withcolor dotcolor;
    fi
  fi
enddef;

%% Put string \\{s} near point \\{z} shifted by \\{shift} and scaled by \\{scale}.

vardef makepiclabel@#(expr s,z,shift,scale) =
  save zz; pair zz; zz=z shifted shift scaled scale;
  makelabel@#(s,zz);
enddef;

%%%% {\it Note\/}: there could be fancy code to keep labels from overlapping!

%% Users generally don't invoke $\2{makelabel}$ directly, because
%% there's a convenient shorthand. For example, `$\2{labels}(1,2,3)$'
%% expands into `$\2{makelabel}(${\tt"1"}$,z_1)$;
%% $\2{makelabel}(${\tt"2"}$,z_2)$; `$\2{makelabel}(${\tt"3"}$,z_3)$'
%% \ (But nothing happens if $\\{proofing}\null\le1$.)

vardef label@#(expr s,z) = makelabel@#(s,z) enddef;

vardef labels@#(text t) = forsuffixes $=t: makelabel@#(str$,z$); endfor
enddef;

vardef piclabels@#(expr shift,scale)(text t) =
  forsuffixes $=t: makepiclabel@#(str$,z$,shift,scale); endfor
enddef;

vardef penlabels@#(text t) = forsuffixes $$=l,,r: forsuffixes $=t:
      makelabel@#(str$.$$,z$.$$); endfor endfor
enddef;

vardef picpenlabels@#(expr shift, scale)(text t) =
  forsuffixes $$=l,,r: forsuffixes $=t:
      makepiclabel@#(str$.$$,z$.$$,shift,scale); endfor endfor
enddef;

%% Showing control points on paths.

newinternal defaultnodesize, defaultstretchwidth, dashfrequency;
defaultnodesize:=grid_size/50;
defaultstretchwidth:=grid_size/100;
dashfrequency:=grid_size/100;

color firstnodecolor, nodecolor, controlscolor, directioncolor, stretchcolor;

nodecolor=(1,0,1);
firstnodecolor=.8nodecolor;
directioncolor=.5white;
stretchcolor=.77white;
controlscolor=(0,1,1);

picture defaultdashpattern, stretchdashpattern;
defaultdashpattern=
  dashpattern(on dashfrequency off dashfrequency on dashfrequency);
stretchdashpattern:=defaultdashpattern;

vardef show_control_points(expr p) =
  save c_,d_,e_,f_; path c_,d_,e_,f_;
  pickup pencircle scaled defaultstretchwidth;
  c_=unitsquare shifted (-1/2,-1/2)
         rotated 45 scaled (sqrt(pi/4)*defaultnodesize); % control point
  d_=fullcircle scaled defaultnodesize; % node
  e_=triangle shifted (-1/6sqrt(3),0)
         yscaled 1/2 scaled (sqrt(pi)*defaultnodesize);
  f_=triangle scaled (sqrt(4/sqrt(3))*defaultnodesize); % first node

  for t_=0 upto length(p) if cycle p: -1 fi:
    if arclength(subpath (t_,t_+1) of p)>5xpart((point 1 of e_)-(point 0 of e_)):
      fillproof e_ rotated angle(direction t_+1/2 of p)
          shifted point t_+1/2 of p withcolor directioncolor;
    fi
    if t_>0: fillproof d_ shifted point t_ of p withcolor nodecolor; fi
    if (point t_ of p)<>(precontrol t_ of p):
      drawproof (point t_ of p) -- (precontrol t_ of p)
          dashed stretchdashpattern withcolor stretchcolor;
      fillproof c_ rotated angle(predir t_ of p) shifted precontrol t_ of p
          withcolor white;
      drawproof c_ rotated angle(predir t_ of p) shifted precontrol t_ of p
          withpen pencircle scaled .1defaultnodesize
          withcolor controlscolor;
    fi
    if (postcontrol t_ of p)<>(point t_ of p):
      drawproof (postcontrol t_ of p) -- (point t_ of p)
          dashed stretchdashpattern withcolor stretchcolor;
      fillproof c_ rotated angle(postdir t_ of p) shifted postcontrol t_ of p
          withcolor white;
      drawproof c_ rotated angle(postdir t_ of p) shifted postcontrol t_ of p
          withpen pencircle scaled .1defaultnodesize
          withcolor controlscolor;
    fi
  endfor
  fillproof f_ rotated
      if (point 0 of p)<>(postcontrol 0 of p): angle(postdir 0 of p)
      else: angle((point 1 of p)-(point 0 of p)) fi
      shifted point 0 of p withcolor firstnodecolor;
enddef;

vardef makecontrollabel(expr $) =
  if (proofing>0) and (known $): show_control_points($) fi
enddef;

vardef controllabel(expr t) = makecontrollabel(t) enddef;

vardef controllabels(text t) =
  forsuffixes $=t: makecontrollabel($); endfor
enddef;

%% When there are lots of purely numeric labels, you can say, e.g.,
%% \begindisplay
%%   $\2{labels}(1, \2{range} 5 \2{thru} 9, \2{range} 100 \2{thru} 124, 223)$
%% \enddisplay
%% which is equivalent to `$\2{labels}(1,5,6,7,8,9,100,101,\ldots,124,223)$'.
%% Labels are omitted from the proofsheets if the corresponding $z$ value
%% isn't known, so it doesn't hurt (much) to include unused subscript numbers
%% in a range.

def range expr x = numtok[x] enddef;
def numtok suffix x = x enddef;
tertiarydef m thru n = m for x=m+1 step 1 until n: , numtok[x] endfor
enddef;

%% A straight line will be drawn on the proofsheet by $\2{proofrule}$.

def proofrule(expr w,z) =
  begingroup interim linecap:=squared;
    drawproof w..z withpen pencircle scaled defaultrulethickness
      withcolor rulecolor
  endgroup
enddef;

%% You can produce lots of proof rules with $\2{makegrid}$, which connects
%% an arbitrary list of $x$~coordinates with an arbitrary list
%% of $y$~coordinates:

def makegrid(text xlist,ylist) =
  xmin_ := min(xlist); xmax_ := max(xlist);
  ymin_ := min(ylist); ymax_ := max(ylist);
  for x=xlist: proofrule((x,ymin_), (x,ymax_)); endfor
  for y=ylist: proofrule((xmin_,y), (xmax_,y)); endfor
enddef;

vardef labelfont suffix $ = defaultfont:=str$ enddef;

def makebox(text r) =
  for y=0,h,-d: r((-sidebearing,y),(w+sidebearing,y)); endfor
  for x=-sidebearing,0,w,w+sidebearing: r((x,-d),(x,h)); endfor
enddef;

def maketicks(text r) =
  for y=0,h,-d: r((0,y),(w/10,y)); r((w-w/10,y),(w,y)); endfor
  for x=0,w: r((x,h/10-d),(x,-d)); r((x,h-h/10),(x,h)); endfor
enddef;


%% \section{MACROS FOR FILLING AND ERASING}

def pc_ = hide(if grayproofing>0:
      def pc_ = do_pc_ enddef;
    else: def pc_= enddef; fi) \\ pc_
enddef;

def do_pc_ = withcolor proofcolor enddef;

def fill expr c = addto currentpicture
  contour c \\ t_ \\ _op_ \\ pc_
enddef;

def draw expr p = addto currentpicture
  if picture p: also p
  else: doublepath p \\ t_ withpen currentpen
  fi _op_ \\ pc_
enddef;

def filldraw expr c = addto currentpicture
  contour c \\ t_ withpen currentpen _op_ \\ pc_
enddef;

def drawdot expr z = addto currentpicture
  contour makepath currentpen shifted z \\ t_ \\ _op_ \\ pc_
enddef;

endinput

%% \end
