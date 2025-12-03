#let day_3 = {
  let cnt1 = 0
  let cnt2 = 0
  for line in read("input.txt").split("\n") {
    let numbers = line.clusters().map(int)
    if numbers.len() == 0 { continue }
    let sorted = numbers.sorted(by: (l, r) => l > r).dedup()
    let first = sorted.at(0)
    let rest = numbers.slice(numbers.position(n => n == first) + 1)
    let second = 0
    if rest.len() == 0 {
      first = sorted.at(1)
      second = calc.max(..numbers.slice(numbers.position(n => n == first) + 1))
    } else {
      second = calc.max(..rest)
    }
    cnt1 += first * 10 + second


    let res = ()
    let iprev = 0
    for i in range(1, 13).rev() {
      let avail = numbers.slice(iprev, numbers.len() - i + 1)
      let m = calc.max(..avail)
      iprev = iprev + avail.position(n => n == m) + 1
      res.push(calc.pow(10, i - 1) * m)
    }
    cnt2 += res.sum()
  }
  (str(cnt1) + sym.star, str(cnt2) + sym.star)
}
