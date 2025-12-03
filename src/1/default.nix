let
  inherit (builtins)
    readFile
    split
    filter
    isString
    foldl'
    elemAt
    substring
    add
    sub
    genList
    stringLength
    match
    head
    fromJSON
    ;

  toInt = str: fromJSON (head (match "[[:space:]]*(-?[[:digit:]]+)[[:space:]]*" str));
  input = readFile ./input.txt;
  arr = filter (v: isString v && v != "") (split "\n" input);
  adjust =
    { n, cnt }:
    if n >= 0 && n <= 99 then
      { inherit n cnt; }
    else
      adjust {
        n = (if n < 0 then add else sub) n 100;
        cnt = cnt + 1;
      };
  result =
    foldl'
      (
        {
          pos,
          cnt1,
          cnt2,
        }:
        cur:
        let
          chars = genList (p: substring p 1 cur) (stringLength cur);
          dir = elemAt chars 0;
          nr = toInt (substring 1 (stringLength cur) cur);
          npos = adjust {
            n = (if dir == "R" then add else sub) pos nr;
            cnt = 0;
          };
        in
        {
          pos = npos.n;
          cnt1 = if npos.n == 0 then cnt1 + 1 else cnt1;
          cnt2 = cnt2 + npos.cnt;
        }
      )
      {
        pos = 50;
        cnt1 = 0;
        cnt2 = 0;
      }
      arr;
in
{
  "1" = result.cnt1;
  "2" = result.cnt2;
}
