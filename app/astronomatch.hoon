/-  *astronomatch
/+  default-agent, agentio, dbug, mast
/=  menu  /app/astronomatch/menu
/=  play  /app/astronomatch/play
/=  style  /app/astronomatch/style
|%
+$  front-end  [=display =cur-url sel-one=selection sel-two=selection]
+$  state-0  [%0 =game]
+$  versioned-state
  $%  state-0
  ==
+$  card  card:agent:gall
--
%-  agent:dbug
=|  [state-0 front-end]
=*  state  -
^-  agent:gall
=<
|_  bol=bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bol)
    io    ~(. agentio bol)
    routes
      %-  limo
      :~  [/astronomatch menu]
          [/astronomatch/play play]
      ==
:: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: ::
++  on-init
  ^-  (quip card _this)
  :_  this
  [(~(arvo pass:io /bind) %e %connect `/'astronomatch' %astronomatch) ~]
++  on-save  
  !>(-.state)
++  on-load
  |=  old-vase=vase
  ^-  (quip card _this)
  =/  old-state  !<(versioned-state old-vase)
  ?-  -.old-state
    %0  [~ this(state [old-state *front-end])]
  ==
:: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: ::
++  on-poke
  |=  [=mark =vase]
  |^  ^-  (quip card _this)
  ::
  =^  cards  state
    ?+  mark  (on-poke:def mark vase)
      %handle-http-request
        (handle-http !<([@ta inbound-request:eyre] vase))
      %json
        ?>  =(our.bol src.bol)
        (handle-client !<(json vase))
    ==
  [cards this]
  ::
  ++  handle-http
    |=  [rid=@ta req=inbound-request:eyre]
    ^-  (quip card _state)
    ?.  authenticated.req
      [(make-auth-redirect:mast rid) state]
    ?+  method.request.req  [(make-400:mast rid) state]
      %'GET'
        =/  url=path  (stab url.request.req)
        ?:  =(/astronomatch/style url)
          [(make-css-response:mast rid style) state]
        =/  new-display=manx  (rig:mast routes url game)
        :-  (plank:mast "astronomatch" /display-updates our.bol rid new-display)
        state(display new-display, cur-url url)
    ==
  ::
  ++  handle-client
    |=  json-req=json
    ^-  (quip card _state)
    =/  client-poke  (parse-json:mast json-req)
    ?~  tags.client-poke  !!
    ?~  t.tags.client-poke  !!
    ?+  [i.tags.client-poke i.t.tags.client-poke]  !!
      [%click %new-game]
        =.  tiles.game  (new-tiles eny.bol)
        =/  grop  (filter-matches (group-tiles tiles.game))
        ~&  '---------------------------------------------------------'
        ~&  grop
        =/  new-display=manx  (rig:mast routes cur-url game)
        :-  [(gust:mast /display-updates display new-display) ~]
        state(display new-display)
      [%mousedown %tile]
        ?~  t.t.tags.client-poke  !!
        ?~  t.t.t.tags.client-poke  !!
        :-  ~
        %=  state
          sel-one  
            :-  (slav %ud i.t.t.tags.client-poke)
            (slav %ud i.t.t.t.tags.client-poke)
        ==
      [%mouseup %tile]
        ?~  t.t.tags.client-poke  !!
        ?~  t.t.t.tags.client-poke  !!
        =.  sel-two
          :-  (slav %ud i.t.t.tags.client-poke)
          (slav %ud i.t.t.t.tags.client-poke)
        ?:  ?|  
          &(=(x.sel-one x.sel-two) =(y.sel-one y.sel-two))
          ?!  ?|  
            &(=(x.sel-one x.sel-two) |(=(y.sel-one +(y.sel-two)) =(+(y.sel-one) y.sel-two)))
            &(=(y.sel-one y.sel-two) |(=(x.sel-one +(x.sel-two)) =(+(x.sel-one) x.sel-two)))
            ==
          ==
          !!
        =.  tiles.game  (swap-tiles tiles.game sel-one sel-two)
        =/  new-display=manx  (rig:mast routes cur-url game)
        :-  [(gust:mast /display-updates display new-display) ~]
        state(display new-display)
    ==
  ::
  --
:: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: ::
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?+  path  (on-watch:def path)
    [%http-response *]
      `this
    [%display-updates *]
      `this
  ==
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent  on-agent:def
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--
:: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: ::
|%
++  new-tiles
  |=  eny=@
  ^-  tiles
  =/  rng  ~(. og eny)
  =|  x=board-x
  |-
  ?~  x
    ~
  =|  y=board-y
  :-  
    |-
    ?~  y
      ~
    =^   n  rng
      (rads:rng 24)
    [(make-tile n x y) $(rng rng, y (dec y))]
  $(rng +:(rads:rng 10), x (dec x))
::
++  make-tile
  |=  [n=@ud x=@ud y=@ud]
  ^-  tile
  =/  id=@t  (crip (weld <n> (weld <x> <y>)))
  =/  case=@ud  (mod n 4)
  ?:  =(case 0)  [id %comet %red]
  ?:  =(case 1)  [id %comet %blue]
  ?:  =(case 2)  [id %comet %green]
  ?:  =(case 3)  [id %comet %yellow]
  ['error' %comet %red]
::
++  group-tiles
  |=  ti=tiles
  ^-  tile-groups
  =/  acc=tile-groups  ~
  =/  x=@ud  0
  |-
  ?~  ti
    acc
  =/  col=(list tile)  i.ti
  =/  yac=(list [=color ys=(list @ud)])  ~
  =/  y=@ud  0
  |-
  ?~  ti  !!
  ?~  col
    %=  ^$
      ti   t.ti
      x    +(x)
      acc
        =/  hacc=tile-groups  acc
        ?~  hacc
          %+  turn  yac
          |=  [=color ys=(list @ud)]
          =|  j=(jug @ud @ud)
          [color (~(put by j) x (silt ys))]
        |-
        ?~  yac
          acc
        =/  prem=(unit @ud)  ~
        =/  cys=(list @ud)  ys.i.yac
        |-
        ?~  yac  !!
        ?~  cys
          ?~  prem
            %=  ^$
              yac  t.yac
              acc
                =|  j=(jug @ud @ud)
                :_  acc
                [color.i.yac (~(put by j) x (silt ys.i.yac))]
            ==
          ^$(yac t.yac, acc acc)
        =/  a=@ud  0
        =/  aacc=tile-groups  acc
        |-
        ?~  ys.i.yac  !!
        ?~  cys  !!
        ?~  aacc
          ^$(cys t.cys)
        ?:  =(color.i.aacc color.i.yac)
          ?:  (~(has ju coordinates.i.aacc) (dec x) i.cys)
            ?~  prem
              %=  ^$
                cys  t.cys
                prem  [~ a]
                acc
                  %^  snap  acc  a
                  :-  color.i.aacc
                  (~(put by coordinates.i.aacc) x (silt ys.i.yac))
              ==
            %=  ^$
              cys  t.cys
              acc
                =/  merg=[(jug @ud @ud) (jug @ud @ud)]
                  %+  ~(rib by coordinates:(snag u.prem acc))
                    coordinates.i.aacc
                  |=  [[k=@ud v=(set @ud)] riba=(jug @ud @ud)]
                  ^-  [(jug @ud @ud) [@ud (set @ud)]]
                  ?.  (~(has by riba) k)
                    [(~(put by riba) k v) [k v]]
                  [(~(put by riba) k (~(uni in (~(get ju riba) k)) v)) [k v]]
                %^  snap  (oust [a 1] acc)  u.prem
                [color.i.aacc -.merg]
            ==
          $(aacc t.aacc, a +(a))
        $(aacc t.aacc, a +(a))
    ==
  ?~  yac
    %=  $
      col  t.col
      y    +(y)
      yac  [[color.i.col [y ~]] ~]
    ==
  ?:  =(color.i.yac color.i.col)
    %=  $
      col  t.col
      y    +(y)
      yac  [[color.i.yac [y ys.i.yac]] t.yac]
    ==
  %=  $
    col  t.col
    y    +(y)
    yac  [[color.i.col [y ~]] yac]
  ==
::
++  filter-matches
  :: to the sample, add a list of selection coordinates -> this is for the pair of swap coordinates
  :: and for the coordinates of the groups just previously deleted for chain match functionality
  :: (this could either be just these coordinates or all coordinates including and below these)
  |=  gs=tile-groups
  ^-  tile-groups
  ?~  gs
    ~
  =/  vals=(list (set @ud))
    ~(val by coordinates.i.gs)
  =/  tils=@ud  %+  roll  vals
    |=  [s=(set @ud) a=@ud]
    (add ~(wyt in s) a)
  ?:  (gte tils 3)
    [i.gs $(gs t.gs)]
  $(gs t.gs)
::
++  swap-tiles
  |=  [ti=tiles selo=selection selt=selection]
  ^-  tiles
  =/  tilo=tile  (snag y.selo (snag x.selo ti))
  =/  tilt=tile  (snag y.selt (snag x.selt ti))
  =.  ti  (snap ti x.selo (snap (snag x.selo ti) y.selo tilt))
  (snap ti x.selt (snap (snag x.selt ti) y.selt tilo))
::
--