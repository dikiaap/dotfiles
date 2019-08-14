#!/usr/bin/env bash

# rofi-calendar: A pop-up calendar for i3blocks.
# Requirements:
#   - rofi (oxide theme)
#   - i3blocks
#   - bash
#   - bsdmainutils (ncal/cal)
#   - coreutils (date)
#   - sed

full_date=$(date '+%-Y-%0m-%_d|%a, %0d %b %0H:%0M|%B')
year_number=${full_date:0:4}
month_number=${full_date:5:2}
day_number=${full_date:8:2}

cal_command() {
    ncal -bhS "$month_number" "$year_number" | sed '1d;s/ *$//g;/^$/d'
}

custom_month() {
    day_number='Null'
    the_date=$(date -d "$year_number-$month_number-01" '+%B %-Y')
}

counts_cal_lines() {
    cal_lines=$(cal_command | wc -l)
}

case "$BLOCK_BUTTON" in
    1)
        # Left-click: Current month
        the_date="${full_date:11:7} ${full_date:29}"
        ;;
    2)
        # Middle-click: Previous month
        ((10#$month_number == 1)) && month_number=12 && year_number=$((year_number - 1)) || month_number=$((10#$month_number - 1))
        custom_month
        ;;
    3)
        # Right-click: Next month
        ((10#$month_number == 12)) && month_number=1 && year_number=$((year_number + 1)) || month_number=$((10#$month_number + 1))
        custom_month
        ;;
esac

case "$BLOCK_BUTTON" in
    1|2|3)
        counts_cal_lines
        cal_command \
            | sed "s#^#<span color='\#f17171'>#g;s#.#&</span>#24" \
            | sed "s#\b${day_number// /}\b#<span bgcolor='\#2b83a6' color='\#ffffff'>${day_number// /}</span>#" \
            | rofi \
                -dmenu \
                -width '-21' \
                -lines "$cal_lines" \
                -font 'Monospace 10' \
                -location '5' \
                -xoffset '-15' \
                -yoffset '-24' \
                -theme-str 'configuration { show-icons: false; }' \
                -theme-str 'window { fullscreen: false; } inputbar { children: [ prompt ]; } listview { scrollbar: false; }' \
                -theme-str 'element normal.normal, element selected.normal, element alternate.normal { background-color: #212121; text-color: #c4cad4; }' \
                -theme-str 'element normal.active, element selected.active, element alternate.active { background-color: #363636; text-color: #f9f9f9; }' \
                -p "$the_date" \
                -a '0' \
                -no-custom \
                -markup-rows &> /dev/null
        ;;
esac

echo "  ${full_date:11:17}"
