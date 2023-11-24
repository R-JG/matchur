|%
+$  tier  ?(%comet %moon %planet %star %galaxy)
+$  color  ?(%red %blue %green %yellow)
+$  tile  [id=@t =tier =color]
+$  tiles  (list (list tile))
+$  score  @ud
+$  moves-left  $~(20 @ud)
+$  game  [=tiles =score =moves-left]
::
+$  routes  (list [path gate])
+$  cur-url  $~(/astronomatch path)
+$  display  $~([[%html ~] [[%head ~] ~] [[%body ~] ~] ~] manx)
--