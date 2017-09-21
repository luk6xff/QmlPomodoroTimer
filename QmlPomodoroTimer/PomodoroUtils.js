function formatDisplayedTime(min, sec)
{
     var timeFormated = "%1:%2";
     var seconds = sec;
     var minutes = min;
     if (seconds < 10)
     {
         seconds = "0"+sec;
     }
     if (minutes < 10)
     {
         minutes = "0"+min;
     }
     return timeFormated.arg(minutes).arg(seconds);
}
