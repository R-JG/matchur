|%
+$  board-x  $~(5 @ud)
+$  board-y  $~(5 @ud)
+$  tier  ?(%comet %moon %planet %star %galaxy)
+$  color  ?(%red %blue %green %yellow)
+$  tile  [id=@t =tier =color]
+$  tiles  (list (list tile))
+$  tile-group  [=color coordinates=(jug @ud @ud)]
+$  tile-groups  (list tile-group)
+$  score  @ud
+$  moves-left  $~(20 @ud)
+$  game  [=tiles =score =moves-left]
::
+$  selection  [x=@ud y=@ud]
+$  routes  (list [path gate])
+$  cur-url  $~(/astronomatch path)
+$  display  $~([[%html ~] [[%head ~] ~] [[%body ~] ~] ~] manx)
--