%%%%
%%%%  $Revison:$
%%%%  $Date: 2004/08/24 23:40:18 $
%%%%

%% \input xanthi-format
%% \title{Parameters of Xanthi font}

numeric px, py;

px:=100; py:=90; % pen width and height

%%%%px:=80; py:=72; 

default_nib:=fix_nib(px,py,0);

path snail, snake;
pair snail_offset; snail_offset:=0*up;
pair square_offset; square_offset:=py*up;
pair rule_offset; rule_offset:=u*up;

path plug.l, plug.r, plug.u, plug.d;

vardef center = (w/2,h/2) enddef;

endinput
