#let day_4 = {
  let cnt1 = 0
  let cnt2 = 0
  let map = read("input.txt")
    .split("\n")
    .map(l => l.clusters())
    .filter(l => l.len() > 0)
  let first = true
  while true {
    let nmap = map
    let changed = false
    for (y, line) in map.enumerate() {
      for (x, char) in line.enumerate() {
        if char != "@" {
          continue
        }
        let rolls = 0
        for yo in (-1, 0, 1) {
          let yn = y + yo
          for xo in (-1, 0, 1) {
            let xn = x + xo
            if (
              (yo != 0 or xo != 0)
                and yn >= 0
                and xn >= 0
                and map.at(yn, default: ()).at(xn, default: ".") == "@"
            ) {
              rolls += 1
            }
          }
        }
        if rolls < 4 {
          if first {
            cnt1 += 1
          }
          cnt2 += 1
          changed = true
          nmap.at(y).at(x) =  "."
        }
      }
    }
    first = false
    if not changed {
      break
    }
    map = nmap
  }
  (str(cnt1) + sym.star, str(cnt2) + sym.star)
}
