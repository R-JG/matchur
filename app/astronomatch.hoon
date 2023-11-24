/-  astronomatch
/+  default-agent, dbug, mast
/=  menu  /app/astronomatch/menu
/=  play  /app/astronomatch/play
/=  style  /app/astronomatch/style
|%
++  route-def 
  %-  limo
  :~  [/astronomatch menu]
      [/astronomatch/play play]
  ==
+$  front-end  [=display =cur-url]
+$  state-0  [%0 =game]
+$  versioned-state
  $%  state-0
  ==
+$  card  card:agent:gall
--
%-  agent:dbug
=|  [state-0  =routes front-end]
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
:: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: ::
++  on-init
  ^-  (quip card _this)
  :_  this(routes route-def)
  [(~(arvo pass:io /bind) %e %connect `/'astronomatch' %astronomatch) ~]
++  on-save  
  !>(-.state)
++  on-load
  |=  old-vase=vase
  ^-  (quip card _this)
  =/  old-state  !<(versioned-state old-vase)
  ?-  -.old-state
    %0  [~ this(state [old-state route-def *front-end])]
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
        ?>  =(our.bowl src.bowl)
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
        :: ...
    ==
  ::
  ++  handle-client
    |=  json-req=json
    ^-  (quip card _state)
    =/  client-poke  (parse-json:mast json-req)
    :: ...
  ::
  --
:: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: :: ::
++  on-watch
  |=  =path
  |^  ^-  (quip card _this)
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