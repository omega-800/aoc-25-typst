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
        for i in range(1, m) {
          if calc.rem(length, i) == 0 {
            let parts = s.clusters().chunks(i).map(c => c.join(""))
            if parts.fold(true, (acc, c) => acc and parts.at(0) == c) {
              cnt2 += i
              break
            }
          }
        }
      }
    }
  }
  (str(cnt1), str(cnt2))
}
