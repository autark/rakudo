# This script generates the logic for doing adverbed slices, usually part of
# the core settings as "src/core/SLICE.pm".  When run, it will generate the
# source code on STDOUT.

use v6;

say qq:to/HEADER/;
#===============================================================================
#
# This file has been generated by $*PROGRAM_NAME
# on {DateTime.new(now)}.
#
# Please do *NOT* make changes to this file, as they will be lost
# whenever this file is generated again.
#
#===============================================================================
HEADER

for 1, 0 -> $array {  # 1 = [], 0 = {}

# Fill in these settings.  The ( is included here to prevent the interpolating
# logic to get confused by seeing [](...) .

    my @TYPE   = $array ?? <LIST(>       !! <HASH(>;
    my @AT     = $array ?? <at_pos(>     !! <at_key(>;
    my @DELETE = $array ?? <delete_pos(> !! <delete_key(>;
    my @EXISTS = $array ?? <exists_pos(> !! <exists_key(>;

# Below here is the actual source code template that is generated.  By only
# interpolating arrays (:a), we can put the right strings in the right place
# by using the zen slice ([]).  Any other occurrences of @ will *not* be
# interpolated because they lack the zen slice.

    say Q:a:to/SOURCE/;
# internal 1 element @TYPE[].chop.lc() access with adverbs
sub SLICE_ONE_@TYPE[]\SELF,$one,*%adv) is hidden_from_backtrace {
    my $d := CLONE-HASH-DECONTAINERIZED(%adv);

    my @nogo;
    my \result = do {

        if DELETEKEY($d,'delete') {            # :delete:*
            if DELETEKEY($d,'SINK') {            # :delete:SINK
                SELF.@DELETE[]$one,:SINK);
            }
            elsif nqp::elems($d) == 0 {       # :delete
                SELF.@DELETE[]$one);
            }
            elsif nqp::existskey($d,'exists') { # :delete:exists(0|1):*
                my $exists   := DELETEKEY($d,'exists');
                my $wasthere := SELF.@EXISTS[]$one);
                SELF.@DELETE[]$one);
                if nqp::elems($d) == 0 {          # :delete:exists(0|1)
                    !( $wasthere ?^ $exists )
                }
                elsif nqp::existskey($d,'kv') {   # :delete:exists(0|1):kv(0|1)
                    my $kv := DELETEKEY($d,'kv');
                    if nqp::elems($d) == 0 {
                        !$kv || $wasthere
                          ?? ( $one, !( $wasthere ?^ $exists ) )
                          !! ();
                    }
                    else {
                        @nogo = <delete exists kv>;
                    }
                }
                elsif nqp::existskey($d,'p') {    # :delete:exists(0|1):p(0|1)
                    my $p := DELETEKEY($d,'p');
                    if nqp::elems($d) == 0 {
                        !$p || $wasthere
                          ?? RWPAIR($one, !($wasthere ?^ $exists) )
                          !! ();
                    }
                    else {
                        @nogo = <delete exists p>;
                    }
                }
                else {
                    @nogo = <delete exists>;
                }
            }
            elsif nqp::existskey($d,'kv') {    # :delete:kv(0|1)
                my $kv := DELETEKEY($d,'kv');
                if nqp::elems($d) == 0 {
                    !$kv || SELF.@EXISTS[]$one)
                      ?? ( $one, SELF.@DELETE[]$one) )
                      !! ();
                }
                else {
                    @nogo = <delete kv>;
                }
            }
            elsif nqp::existskey($d,'p') {     # :delete:p(0|1)
                my $p := DELETEKEY($d,'p');
                if nqp::elems($d) == 0 {
                    !$p || SELF.@EXISTS[]$one)
                      ?? RWPAIR($one, SELF.@DELETE[]$one))
                      !! ();
                }
                else {
                    @nogo = <delete p>;
                }
            }
            elsif nqp::existskey($d,'k') {     # :delete:k(0|1)
                my $k := DELETEKEY($d,'k');
                if nqp::elems($d) == 0 {
                    !$k || SELF.@EXISTS[]$one)
                      ?? do { SELF.@DELETE[]$one); $one }
                      !! ();
                }
                else {
                    @nogo = <delete k>;
                }
            }
            elsif nqp::existskey($d,'v') {     # :delete:v(0|1)
                my $v := DELETEKEY($d,'v');
                if nqp::elems($d) == 0 {
                    !$v || SELF.@EXISTS[]$one)
                      ?? SELF.@DELETE[]$one)
                      !! ();
                }
                else {
                    @nogo = <delete v>;
                }
            }
            else {
                @nogo = <delete>;
            }
        }
        elsif nqp::existskey($d,'exists') {  # :!delete?:exists(0|1):*
            my $exists  := DELETEKEY($d,'exists');
            my $wasthere = SELF.@EXISTS[]$one);
            if nqp::elems($d) == 0 {           # :!delete?:exists(0|1)
                !( $wasthere ?^ $exists )
            }
            elsif nqp::existskey($d,'kv') {    # :!delete?:exists(0|1):kv(0|1)
                my $kv := DELETEKEY($d,'kv');
                if nqp::elems($d) == 0 {
                    !$kv || $wasthere
                      ?? ( $one, !( $wasthere ?^ $exists ) )
                      !! ();
                }
                else {
                    @nogo = <exists kv>;
                }
            }
            elsif nqp::existskey($d,'p') {     # :!delete?:exists(0|1):p(0|1)
                my $p := DELETEKEY($d,'p');
                if nqp::elems($d) == 0 {
                    !$p || $wasthere
                      ?? RWPAIR($one, !( $wasthere ?^ $exists ))
                      !! ();
                }
                else {
                    @nogo = <exists p>;
                }
            }
            else {
                @nogo = <exists>;
            }
        }
        elsif nqp::existskey($d,'kv') {      # :!delete?:kv(0|1):*
            my $kv := DELETEKEY($d,'kv');
            if nqp::elems($d) == 0 {           # :!delete?:kv(0|1)
                !$kv || SELF.@EXISTS[]$one)
                  ?? ($one, SELF.@AT[]$one))
                  !! ();
            }
            else {
                @nogo = <kv>;
            }
        }
        elsif nqp::existskey($d,'p') {       # :!delete?:p(0|1):*
            my $p := DELETEKEY($d,'p');
            if nqp::elems($d) == 0 {           # :!delete?:p(0|1)
                !$p || SELF.@EXISTS[]$one)
                  ?? RWPAIR($one, SELF.@AT[]$one))
                  !! ();
            }
            else {
                @nogo = <p>;
            }
        }
        elsif nqp::existskey($d,'k') {       # :!delete?:k(0|1):*
            my $k := DELETEKEY($d,'k');
            if nqp::elems($d) == 0 {           # :!delete?:k(0|1)
                !$k || SELF.@EXISTS[]$one)
                  ?? $one
                  !! ();
            }
            else {
                @nogo = <k>;
            }
        }
        elsif nqp::existskey($d,'v') {       # :!delete?:v(0|1):*
            my $v := DELETEKEY($d,'v');           # :!delete?:v(0|1)
            if nqp::elems($d) == 0 {
                !$v || SELF.@EXISTS[]$one)
                  ?? SELF.@AT[]$one)
                  !! ();
            }
            else {
                @nogo = <v>;
            }
        }
        elsif nqp::elems($d) == 0 {           # :!delete
            SELF.@AT[]$one);
        }
    }

    @nogo || nqp::elems($d)
      ?? SLICE_HUH( SELF, @nogo, $d, %adv )
      !! result;
} #SLICE_ONE_@TYPE[].chop()

# internal >1 element @TYPE[].chop.lc() access with adverbs
sub SLICE_MORE_@TYPE[]\SELF,$more,*%adv) is hidden_from_backtrace {
    my $d := CLONE-HASH-DECONTAINERIZED(%adv);
    my @nogo;

    my \result = do {

        if DELETEKEY($d,'delete') {            # :delete:*
            if DELETEKEY($d,'SINK') {            # :delete:SINK
                SELF.@DELETE[]$_,:SINK) for $more;
                Nil;
            }
            elsif nqp::elems($d) == 0 {       # :delete
                $more.list.map( { SELF.@DELETE[]$_) } ).eager.Parcel;
            }
            elsif nqp::existskey($d,'exists') { # :delete:exists(0|1):*
                my $exists := DELETEKEY($d,'exists');
                my $wasthere; # no need to initialize every iteration of map
                if nqp::elems($d) == 0 {          # :delete:exists(0|1)
                    $more.list.map( {
                        SELF.@DELETE[]$_) if $wasthere = SELF.@EXISTS[]$_);
                        !( $wasthere ?^ $exists );
                    } ).eager.Parcel;
                }
                elsif nqp::existskey($d,'kv') { # :delete:exists(0|1):kv(0|1):*
                    my $kv := DELETEKEY($d,'kv');
                    if nqp::elems($d) == 0 {      # :delete:exists(0|1):kv(0|1)
                        $more.list.map( {
                            SELF.@DELETE[]$_) if $wasthere = SELF.@EXISTS[]$_);
                            next unless !$kv || $wasthere;
                            ($_, !( $wasthere ?^ $exists ));
                        } ).flat.eager.Parcel;
                    }
                    else {
                        @nogo = <delete exists kv>;
                    }
                }
                elsif nqp::existskey($d,'p') {  # :delete:exists(0|1):p(0|1):*
                    my $p := DELETEKEY($d,'p');
                    if nqp::elems($d) == 0 {      # :delete:exists(0|1):p(0|1)
                        $more.list.map( {
                            SELF.@DELETE[]$_) if $wasthere = SELF.@EXISTS[]$_);
                            next unless !$p || $wasthere;
                            RWPAIR($_,!($wasthere ?^ $exists));
                        } ).eager.Parcel;
                    }
                    else {
                        @nogo = <delete exists p>;
                    }
                }
                else {
                    @nogo = <delete exists>;
                }
            }
            elsif nqp::existskey($d,'kv') {     # :delete:kv(0|1):*
                my $kv := DELETEKEY($d,'kv');
                if nqp::elems($d) == 0 {          # :delete:kv(0|1)
                    $kv
                      ?? $more.list.map( {
                             next unless SELF.@EXISTS[]$_);
                             ( $_, SELF.@DELETE[]$_) );
                         } ).flat.eager.Parcel
                      !! $more.list.map( {
                             ( $_, SELF.@DELETE[]$_) )
                         } ).flat.eager.Parcel;
                }
                else {
                    @nogo = <delete kv>;
                }
            }
            elsif nqp::existskey($d,'p') {      # :delete:p(0|1):*
                my $p := DELETEKEY($d,'p');
                if nqp::elems($d) == 0 {          # :delete:p(0|1)
                    $p
                      ?? $more.list.map( {
                             next unless SELF.@EXISTS[]$_);
                             RWPAIR($_, SELF.@DELETE[]$_));
                         } ).eager.Parcel
                      !! $more.list.map( {
                             RWPAIR($_, SELF.@DELETE[]$_))
                         } ).eager.Parcel;
                }
                else {
                    @nogo = <delete p>;
                }
            }
            elsif nqp::existskey($d,'k') {     # :delete:k(0|1):*
                my $k := DELETEKEY($d,'k');
                if nqp::elems($d) == 0 {          # :delete:k(0|1)
                    $k
                      ?? $more.list.map( {
                             next unless SELF.@EXISTS[]$_);
                             SEQ( SELF.@DELETE[]$_); $_ );
                         } ).eager.Parcel
                      !! $more.list.map( {
                             SELF.@DELETE[]$_); $_
                         } ).eager.Parcel;
                }
                else {
                    @nogo = <delete k>;
                }
            }
            elsif nqp::existskey($d,'v') {      # :delete:v(0|1):*
                my $v := DELETEKEY($d,'v');
                if nqp::elems($d) == 0 {          # :delete:v(0|1)
                    $v
                      ?? $more.list.map( {
                             next unless SELF.@EXISTS[]$_);
                             SELF.@DELETE[]$_);
                     } ).eager.Parcel
                      !! $more.list.map( {
                             SELF.@DELETE[]$_)
                     } ).eager.Parcel;
                }
                else {
                    @nogo = <delete v>;
                }
            }
            else {
                @nogo = <delete>;
            }
        }
        elsif nqp::existskey($d,'exists') { # :!delete?:exists(0|1):*
            my $exists := DELETEKEY($d,'exists');
            if nqp::elems($d) == 0 {          # :!delete?:exists(0|1)
                $more.list.map({ !( SELF.@EXISTS[]$_) ?^ $exists ) }).eager.Parcel;
            }
            elsif nqp::existskey($d,'kv') {   # :!delete?:exists(0|1):kv(0|1):*
                my $kv := DELETEKEY($d,'kv');
                if nqp::elems($d) == 0 {        # :!delete?:exists(0|1):kv(0|1)
                    $kv
                      ?? $more.list.map( {
                             next unless SELF.@EXISTS[]$_);
                             ( $_, $exists );
                         } ).flat.eager.Parcel
                      !! $more.list.map( {
                             ( $_, !( SELF.@EXISTS[]$_) ?^ $exists ) )
                         } ).flat.eager.Parcel;
                }
                else {
                    @nogo = <exists kv>;
                }
            }
            elsif nqp::existskey($d,'p') {  # :!delete?:exists(0|1):p(0|1):*
                my $p := DELETEKEY($d,'p');
                if nqp::elems($d) == 0 {      # :!delete?:exists(0|1):p(0|1)
                    $p
                      ?? $more.list.map( {
                             next unless SELF.@EXISTS[]$_);
                             RWPAIR( $_, $exists );
                         } ).eager.Parcel
                      !! $more.list.map( {
                             RWPAIR( $_, !( SELF.@EXISTS[]$_) ?^ $exists ) )
                         } ).eager.Parcel;
                }
                else {
                    @nogo = <exists p>;
                }
            }
            else {
                @nogo = <exists>;
            }
        }
        elsif nqp::existskey($d,'kv') {     # :!delete?:kv(0|1):*
            my $kv := DELETEKEY($d,'kv');
            if nqp::elems($d) == 0 {          # :!delete?:kv(0|1)
                $kv
                  ?? $more.list.map( {
                         next unless SELF.@EXISTS[]$_);
                         $_, SELF.@AT[]$_);
                     } ).flat.eager.Parcel
                  !! $more.list.map( {
                         $_, SELF.@AT[]$_)
                     } ).flat.eager.Parcel;
            }
            else {
                @nogo = <kv>;
            }
        }
        elsif nqp::existskey($d,'p') {      # :!delete?:p(0|1):*
            my $p := DELETEKEY($d,'p');
            if nqp::elems($d) == 0 {          # :!delete?:p(0|1)
                $p
                  ?? $more.list.map( {
                         next unless SELF.@EXISTS[]$_);
                         RWPAIR($_, SELF.@AT[]$_));
                     } ).eager.Parcel
                  !! $more.list.map( {
                         RWPAIR( $_, SELF.@AT[]$_) )
                     } ).eager.Parcel;
            }
            else {
                @nogo = <p>
            }
        }
        elsif nqp::existskey($d,'k') {      # :!delete?:k(0|1):*
            my $k := DELETEKEY($d,'k');
            if nqp::elems($d) == 0 {          # :!delete?:k(0|1)
                $k
                  ?? $more.list.map( {
                         next unless SELF.@EXISTS[]$_);
                         $_;
                     } ).eager.Parcel
                  !! $more.list.flat.eager.Parcel;
            }
            else {
                @nogo = <k>;
            }
        }
        elsif nqp::existskey($d,'v') {      # :!delete?:v(0|1):*
            my $v := DELETEKEY($d,'v');
            if nqp::elems($d) == 0 {          # :!delete?:v(0|1)
                $v
                  ??  $more.list.map( {
                          next unless SELF.@EXISTS[]$_);
                          SELF.@AT[]$_);
                      } ).eager.Parcel
                  !!  $more.list.map( {
                          SELF.@AT[]$_)
                      } ).eager.Parcel;
            }
            else {
                @nogo = <v>;
            }
        }
        elsif nqp::elems($d) == 0 {         # :!delete
            $more.list.map( { SELF.@AT[]$_) } ).eager.Parcel;
        }
    }

    @nogo || nqp::elems($d)
      ?? SLICE_HUH( SELF, @nogo, $d, %adv )
      !! result;
} #SLICE_MORE_@TYPE[].chop()

SOURCE
}