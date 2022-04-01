package calc

type Calc interface {
  Add(x, y int64) int64
}

type MagicCalc struct {
}

func (c MagicCalc) Add(x, y int64) int64 {
  var magicNum int64 = 10
  return magicNum + x + y
}
