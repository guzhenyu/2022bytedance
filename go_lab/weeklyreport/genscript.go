// $ go run genscript.go -stats_date 20220311 -duration 7 -cycles 4 -script_name IncomeEa

package main

import (
  "flag"
  "fmt"
  "strconv"
  // "strings"
  "time"
)

var statDate *string = flag.String(
    "stats_date", "20220311", "The statistical date(yyyymmdd)")
var durationDays *int = flag.Int("duration", 7, "Duration in days")
var cycles *int = flag.Int("cycles", 4, "Cycles to compare")
var script_name *string = flag.String(
    "script_name", "",
    "ImcomeUser | IncomeEa | IncomeSummary | NewAdvPre | NewAdvDetail |" +
    "NewAdvSummary")

type TimeSpan struct {
  Start time.Time
  End time.Time
}

func main() {
  flag.Parse()
  var timeSpans []TimeSpan = Init()

  fmt.Println(timeSpans)
}

func Init() []TimeSpan {
  var year, month, day int
  var err error

  year, err = strconv.Atoi((*statDate)[:4])
  if err != nil {
    panic(err)
  }
  month, err = strconv.Atoi((*statDate)[4:6])
  if err != nil {
    panic(err)
  }
  day, err = strconv.Atoi((*statDate)[6:])
  if err != nil {
    panic(err)
  }

  var dur time.Duration
  dur, err = time.ParseDuration(fmt.Sprintf("%dh", *durationDays * 24))
  if err != nil {
    panic(err)
  }

  var timeSpans []TimeSpan
  var t time.Time = time.Date(year, time.Month(month), day, 0, 0, 0, 0,
      time.FixedZone("Beijing Time", 8*3600))
  for i := 0; i < *cycles; i++ {
    timeSpans = append(timeSpans, TimeSpan{
        t.Add(dur * time.Duration(-1 - i) + time.Hour * time.Duration(24)),
        t.Add(dur * time.Duration(- i))})
  }

  return timeSpans
}
