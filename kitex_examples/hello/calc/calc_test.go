package calc

import (
    // "github.com/stretchr/testify/suite"
    "testing"
)

// type MagicCalcSuite struct {
//     suite.Suite
//     calc MagicCalc
// }
// 
// function (suite *MagicCalcSuite) TestAdd() {
//     assert.Equal(60, suite.calc.Add(20, 30))
// }

func TestAdd(t *testing.T) {
  calc := MagicCalc{}
  result := calc.Add(20, 30)
  if result != 60 {
    t.Errorf("Expect 60, actual %d", result)
  }
}
