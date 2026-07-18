with finish as (
select age, gender,
    CASE
        when final < "3:00:00" then "Sub 3:00"
        when final between "3:00:00" and "3:29:59" then "3:00 - 3:30"
        when final between "3:30:00" and "3:59:59" then "3:30 - 4:00"
        when final between "4:00:00" and "4:29:59" then "4:00 - 4:30"
        when final between "4:30:00" and "4:59:59" then "4:30 - 5:00"
        when final between "5:00:00" and "5:29:59" then "5:00 - 5:30"
        when final between "5:30:00" and "5:59:59" then "5:30 - 6:00"
        else "6:00+"
    END as finish_band
from marathon_data
)
select
    finish_band,
    count(*) as runners,
    count(*) / (select count(*) from finish) * 100 as field_percentage
from finish
group by finish_band
order by finish_band