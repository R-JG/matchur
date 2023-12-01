^~
'''
body {
  margin: 0;
}
.red {
  background-color: red;
}
.blue {
  background-color: blue;
}
.green {
  background-color: green;
}
.yellow {
  background-color: yellow;
}
.board {
  display: flex;
  flex-direction: row;
}
.tile {
  width: 5rem;
  height: 5rem;
  margin: 1rem;
  border: 1px solid black;
  cursor: pointer;
  user-select: none;
  -webkit-user-select: none;
  -moz-user-select: -moz-none;
}
.tile:active {
  scale: 1.1;
}
'''