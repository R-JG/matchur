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
      ;*  (turn tiles.game col)
    ==
  ==
==
::
++  col
  |=  lt=(list tile)
  ;div
    ;*  (turn lt til)
  ==
::
++  til
  |=  =tile
  ;div(class (weld "tile " (trip color.tile)));
::
--