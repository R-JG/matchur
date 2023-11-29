/-  *astronomatch
|=  =game
|^  ^-  manx
::
;html
  ;head
    ;meta(charset "utf-8");
    ;link(href "/astronomatch/style", rel "stylesheet");
  ==
  ;body
    ;button(event "/click/new-game"): New Game
    ;div(class "board")
      ;*  =/  x=@ud  0
          |-
          ?~  tiles.game
            ~
          :-  (col i.tiles.game x) 
          $(tiles.game t.tiles.game, x +(x))
    ==
  ==
==
::
++  col
  |=  [lt=(list tile) x=@ud]
  ^-  manx
  ;div
    ;*  =/  y=@ud  0
        |-
        ?~  lt
          ~
        :-  (til i.lt x y)
        $(lt t.lt, y +(y))
  ==
::
++  til
  |=  [=tile x=@ud y=@ud]
  ^-  manx
  ;div(class (weld "tile " (trip color.tile)), event "/click/tile/{<x>}/{<y>}");
::
--