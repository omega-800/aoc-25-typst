#let day_2 = {
  let cnt1 = 0
  let cnt2 = 0
  for line in read("input.txt").split(",") {
    let (first, last) = line.split("-")
    for i in range(int(first), int(last.trim()) + 1) {
      let s = str(i)
      let length = s.len()
      let m = int(length / 2)
      let l = s.slice(0, m)
      let r = s.slice(m, s.len())
      if l == r {
        cnt1 += i
        cnt2 += i
      } else {
        for j in range(1, m + 1).rev() {
          if calc.rem(length, j) != 0 {
            continue
          }
          let parts = ()
          for k in range(0, int(length / j)) {
            parts.push(s.slice(k * j, (k * j) + j))
          }
          // let parts = s.clusters().chunks(j).map(c => c.join(""))
          if parts.fold(true, (acc, c) => acc and parts.at(0) == c) {
            cnt2 += i
            break
          }
        }
      }
    }
  }
  (str(cnt1) + sym.star, str(cnt2) + sym.star)
}
