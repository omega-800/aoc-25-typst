#let day_1 = {
  let cnt1 = 0
  let cnt2 = 0
  let pos = 50
  for line in read("input.txt").split("\n") {
    if line.len() < 2 { continue }
    let num = int(line.slice(1))
    if line.first(default: "R") == "R" {
      pos += num
    } else {
      pos -= num
    }
    while pos < 0 or pos > 99 {
      if pos < 0 {
        pos += 100
      } else {
        pos -= 100
      }
      cnt2 += 1
    }
    if pos == 0 {
      cnt1 += 1
    }
  }
  (str(cnt1), str(cnt2))
}
