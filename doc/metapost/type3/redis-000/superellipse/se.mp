u=1cm;

% superellipse(expr r,t,l,b,s)

newinternal superness; superness:=.707;

def superellipse(expr r,t,l,b)=
 r{up}...(superness[xpart t,xpart r],superness[ypart r,ypart t]){t-r}...
 t{left}...(superness[xpart t,xpart l],superness[ypart l,ypart t]){l-t}...
 l{down}...(superness[xpart b,xpart l],superness[ypart l,ypart b]){b-l}...
 b{right}...(superness[xpart b,xpart r],superness[ypart r,ypart b]){r-b}...
 cycle
enddef;

beginfig(200);
  pickup pencircle scaled 4;
%   z1=3u*right; z2=3u*up;
%   z3=3u*left; z4=3u*down;
%   z1=3u*right rotated 30; z2=3u*up rotated 30;
%   z3=3u*left rotated 30; z4=3u*down rotated 30;
  z1=3u*right rotated 45; z2=3u*up rotated 45;
  z3=3u*left rotated 45; z4=3u*down rotated 45;
  draw superellipse(z1,z2,z3,z4);
endfig;

def ellipse_set(suffix $,@,@@,$$) = % given |z$,x@,z$$|, find |y@| and |z@@|
% such that the path |z${x@-x$,0}..z@{0,y@-y$}..{z$$-z@@}z@@|
% is consistent with an ellipse
% and such that the line |z@@--z$$| has a given |slope|
 alpha_:=slope*(x@-x$); beta_:=y$$-y$-slope*(x$$-x$);
 gamma_:=alpha_/beta_;
 y@-y$=.5(beta_-alpha_*gamma_);
 x@@-x$=-2gamma_*(x@-x$)/(1+gamma_*gamma_);
 y@@-y$$=slope*(x@@-x$$) enddef;

%% Returns a counterclockwise arc of superellipse.
%% The arc has $\\{center}$ as center, $\\{hradius}$ a horizontal
%% radius, $\\{vradius}$ as vertical radius, $\\{startangle}$ the angle
%% of a vector from the center to the first point of the arc,
%% and $\\{endangle}$ the angle of a vector from the center to the
%% last point of the the arc.

%% x center
%% reflectedabout reflectedin

% Draw an arc of superellipse from $\alpha$ to $\beta$.

vardef superarc(expr r,t,l,alpha,beta) = 
  save p,b,rt,tl,lb,br,center,superellipse,tm,startangle;
  pair b,rt,tl,lb,br,center; path superellipse,p.a,p.b;
  numeric tm.a,tm.b,tm',tm'',startangle;
  center=1/2[r,l]; 
  b=t reflectedin(center);
  rt=center reflectedin(1/2[r,t]);
  tl=center reflectedin(1/2[t,l]);
  lb=center reflectedin(1/2[l,b]);
  br=center reflectedin(1/2[b,r]);
  superellipse=r{rt-r}...(superness[center,rt]){t-r}
      ...t{tl-t}...(superness[center,tl]){l-t}
      ...l{lb-l}...(superness[center,lb]){b-l}
      ...b{br-b}...(superness[center,br]){r-b}
      ...cycle;
  startangle=angle(r-center);
  p.a=(origin--((4cm*right) rotated (startangle+alpha))) shifted center;
  p.b=(origin--((4cm*right) rotated (startangle+beta))) shifted center;
%%%%  draw p.a withpen pencircle scaled 1;
%%%%  draw p.b withpen pencircle scaled 1;

%%%%  dotlabel.bot("center",center);
%%%%  dotlabel.top("t",t); %dotlabel.top("(rt)",rt);
%%%%  dotlabel.bot("(b)",b); %dotlabel.bot("(lb)",lb);
%%%%  dotlabel.rt("r",r); %dotlabel.rt("(br)",br);
%%%%  dotlabel.lft("l",l); %dotlabel.lft("(tl)",tl);
%%%%  message "startangle: " & decimal startangle;
%%%%  message "alpha: " & decimal alpha;  
%%%%  message "beta: " & decimal beta;  

  if (alpha=0): tm.a=0;      
  else: (tm.a,tm')=superellipse intersectiontimes p.a;
  fi
  if (beta=360): tm.b=8;
  else: (tm.b,tm'')=superellipse intersectiontimes p.b;
  fi

%%%%  message "tm.a: " & decimal tm.a & " tm.b: " & decimal tm.b;
  
  if (tm.a=0) and (tm.b=8): superellipse
  else: subpath (tm.a,tm.b) of superellipse
  fi
enddef;


def reflectedin(expr z) = % reflects about the point z
  rotatedaround(z,180) enddef;

defaultfont:="cmtt10";

dotlabeldiam:=4;
labeloffset:=8;
color dotcolor; dotcolor:=black;

vardef dotlabel@#(expr s,z) =
  label@#(s,z);
  interim linecap:=rounded;
  draw z withpen pencircle scaled dotlabeldiam withcolor dotcolor;
enddef;

pair zz[];
zz1=u*right; zz2=3/2u*up; zz3=-zz1;

vardef term(suffix $,$$)(expr d,t,s) =
  save p_,d_; path p_,d_;
  p_=${d}..tension t..$$;
  d_=(xpart $$-xpart $,s*(ypart $$-ypart $));
  if (abs angle direction 1 of p_ < abs angle d_)<>(xpart $<xpart $$):
    p_:=${d}..tension atleast t..{d_}$$; fi
  p_
enddef;

u:=1.5cm;

slope:=-1/4;  % angle at middle

def ellipse_set(suffix $,@,@@,$$) = % given |z$,x@,z$$|, find |y@| and |z@@|
% such that the path |z${x@-x$,0}..z@{0,y@-y$}..{z$$-z@@}z@@|
% is consistent with an ellipse
% and such that the line |z@@--z$$| has a given |slope|
  alpha_:=slope*(xpart @-xpart $);
  beta_:=ypart $$-ypart $-slope*(xpart $$-xpart $);
  gamma_:=alpha_/beta_;
  ypart @-ypart $=.5(beta_-alpha_*gamma_);
  xpart @@-xpart $=-2gamma_*(xpart @-xpart $)/(1+gamma_*gamma_);
  ypart @@-ypart $$=slope*(xpart @@-xpart $$)
enddef;

beginfig(105);
  z5=3/2u*right; z6=u*up; z7=-z5; z8=1/2u*(3/2right+7/4down);
  interim superness:=.707;
  path p[];
  x7'=x7;
  p1=superarc(z5,z6,z7,90,180);

  ellipse_set(z6,z7',z10,z8);

  p5=p1..{1,slope}z8;
  draw p5 withpen pencircle scaled 10 withcolor (1,0,1);
  
  p3=superarc(z5,z6,z7',90,180)..z10..z8;
  draw p3 withpen pencircle scaled 7 withcolor (0,1,1);
  p2=z8--z10;
  draw p2 withpen pencircle scaled 2 withcolor 1/3(0,1,1);
  p4=superarc(z7' reflectedabout(origin,up),z6,z7',0,360);
  draw p4 withpen pencircle scaled 2 withcolor 1/3(0,1,1);

  draw p3 shifted (3.9u,0) withpen pencircle scaled 10 withcolor (0,1,1);
  draw p5 shifted (-3u,0) withpen pencircle scaled 10 withcolor (1,0,1);
  dotlabel.rt(btex $z_@$ etex,z7 shifted (-3u,0));
  
  label.bot(btex nachylenie {\it slope} etex,point .95 of p2 shifted (0,-u/5));
  dotlabel.lft(btex $(x_{@},y_{@})$ etex,z7');
  dotlabel.top(btex $z_{@@}$ etex,z10);
  dotlabel.top(btex $z_\$$ etex,z6);
  dotlabel.rt(btex $z_{\$\$}$ etex,z8);
endfig;


beginfig(100);
  interim superness:=.65;
  pickup pencircle scaled 4;
  draw superarc(zz1,zz2,zz3,0,360) withcolor .65red;
  label(".65",origin);
endfig;

beginfig(101);
  interim superness:=.707;
  pickup pencircle scaled 4;
  linecap:=butt;
  draw superarc(zz1,zz2,zz3,0,360) withcolor .707red;
  label(".707",origin);
endfig;

beginfig(102);
  interim superness:=.75;
  pickup pencircle scaled 4;
  draw superarc(zz1,zz2,zz3,0,360) withcolor .75red;
  label(".75",origin);
endfig;

beginfig(103);
  interim superness:=.80;
  pickup pencircle scaled 4;
  draw superarc(zz1,zz2,zz3,0,360) withcolor .80red;
  label(".80",origin);
endfig;

defaultfont:="pltt8";
u:=1.5cm;
zz4=2u*right rotated 30; zz5=3/2u*up rotated 30;
zz6=zz4 reflectedin(origin);

beginfig(104);
  interim superness:=.75;
  pickup pencircle scaled 4;
  draw superarc(zz4,zz5,zz6,0,360) withcolor (1,1,0);
  path p[];
  linecap:=butt;
  p0=superarc(zz4,zz5,zz6,60,160);
  draw p0 withcolor .75red;
  pickup pencircle scaled 1;
  draw origin--zz4 dashed evenly scaled 1;
  draw origin--point 0 of p0 dashed evenly scaled 1 withcolor blue;
  draw origin--point infinity of p0 dashed evenly scaled 1 withcolor blue;
  p1=superarc(zz4,zz5,zz6,0,60) scaled .7;
  p2=superarc(zz4,zz5,zz6,0,160) scaled .5;
  drawarrow p1 withcolor blue;
  drawarrow p2 withcolor blue;
  z1=point 1 of p1;
  z2=point 2.5 of p2;
  label.urt("k±t_pocz±tkowy" ,z1);
  label.top("k±t_koñcowy",z2);
  dotlabel.rt("r",zz4);
  dotlabel.top("t",zz5);
  dotlabel.lft("l",zz6);
endfig; linecap:=rounded;

end
