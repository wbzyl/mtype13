#
# TYPE 3 FONTS REPOSITORIUM        Wlodek Bzyl <matwb@univ.gda.pl>
#

# Read in font independent definitions.

include ../make/common.mk

TEXFLAGS = -fmt=mex -translate-file=il2-pl

FONTS = redis-000 redis-a00 redis-b00 redis-c00 redis-d00 redis-e00 

redis-000.t3 : redis-lk.mp

redis-000.dvi : redis-000.t3 redis-000.proof

redis-000.done : redis.mp
	mptot3 -install-font -install-dvips=t3fonts \
            redis-000.mp
	mptot3 -install-font -install-dvips=t3fonts \
	  -change-name=redis-a00 -change-mode=redis,redis_a redis-000.mp
	mptot3 -install-font -install-dvips=t3fonts \
	  -change-name=redis-b00 -change-mode=redis,redis_b redis-000.mp
	mptot3 -install-font -install-dvips=t3fonts \
	  -change-name=redis-c00 -change-mode=redis,redis_c redis-000.mp
	mptot3 -install-font -install-dvips=t3fonts \
	  -change-name=redis-d00 -change-mode=redis,redis_d redis-000.mp
	mptot3 -install-font -install-dvips=t3fonts \
	  -change-name=redis-e00 -change-mode=redis,redis_e redis-000.mp
	touch redis-000.done

fonts : vclean redis-000.done
