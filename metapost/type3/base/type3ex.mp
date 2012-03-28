%%%%
%%%% This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
%%%%

%% \title{UTILITY FUNCTIONS}

%% These functions did not found their way into the plain format.

vardef tand primary a = sind(a)/cosd(a) enddef;

vardef cotd primary a = cosd(a)/sind(a) enddef;

vardef signum primary x = if x>0: 1 elseif x<0: -1 else: 0 fi enddef;

def xyscaled primary p = xscaled xpart(p) yscaled ypart(p) enddef;

def yxscaled primary p = yscaled xpart(p) xscaled ypart(p) enddef;

vardef udir expr t of p = unitvector(direction t of p) enddef;

vardef predir expr t of p = (point t of p)-(precontrol t of p) enddef;
vardef postdir expr t of p = (postcontrol t of p)-(point t of p) enddef;

%% Allow scaling $\2{nullpicture}$.

primarydef a yxscaledto b =
  hide(numeric x_;
    x_:=xpart(urcorner(a))-xpart(llcorner(a));
    if x_<=0: x_:=1; else: x_:=b/(ypart(urcorner(a))-ypart(llcorner(a))); fi)
  a scaled x_
enddef;

primarydef a xyscaledto b =
  hide(numeric x_;
    x_:=xpart(urcorner(a))-xpart(llcorner(a));
    if x_<=0: x_:=1; else: x_:=b/(xpart(urcorner(a))-xpart(llcorner(a))); fi)
  a scaled x_
enddef;

%% To be used within a group; eg. in $\2{vardef}$.

def local_drawoptions (text t) =
  save _op_; drawoptions(t);
enddef;

def local suffix s =
 begingroup
  save local_stack_value_, local_stack_name_;
  if pair s: pair local_stack_value_; fi
  if path s: path local_stack_value_; fi
  if picture s: picture local_stack_value_; fi
  if string s: string local_stack_value_; fi
  if color s: color local_stack_value_; fi
  local_stack_value_ = s; def local_stack_name_ = s enddef;
  local_
enddef;
def local_ expr x = local_stack_name_:=x enddef;
def endlocal = local_stack_name_:=local_stack_value_; endgroup; enddef;


tertiarydef m thru n = hide(m_:=byte m; n_:=byte n)
  m_ for x=m_+1 step 1 until n_: , numtok[x] endfor enddef;

%% Odbicie wzglêdem punktu $z$.

def reflectedin(expr z) = rotatedaround(z,180) enddef;


%% Add equilateral triangles to circles and squares.

vardef triangle = \\ % |1/2sqrt(3)| $\approx$ |0.866025...|
  (0,-1/2)--(0.866,0)--(0,1/2)--cycle
enddef;

%% The `pi'. Actually an approximation.

pi=3.141593;

endinput

%%\end
