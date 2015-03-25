< UFO-Nov-Dic-2014-clean-headers.tsv cut -f5 \
  | sed -E 's/[^0-9]*//' \
  | grep -Ev '[+:\.@/]' \
  | sed -E '/-/s/([0-9]+)-([0-9]+)/\1 \2/' \
  | awk -F' ' \
    '
      /[0-9] [0-9]/ {$1 = ($1 + $2)/2; $2 = $3}
      $2 ~ /seg|sec/ {$2 = "sec"; $3 = 1.0*$1}
      $2 ~ /min|minute/ {$2 = "min"; $3 = $1*60}
      $2 ~ /hour|hr/ {$2 = "hr"; $3 = $1*3600}
      /sec|min|hr/ {sum += $3; sumsq += $3*$3; n++}
      END {
          mean = sum/n
          meansq = sumsq/n
          var = meansq - mean*mean
          print "n = ", n, "\nsuma = ", sum, "\nsumsq = ", sumsq, "\nmean = ", mean, "\nmeansq = ", meansq, "\nvar = ", var
          }
    '
