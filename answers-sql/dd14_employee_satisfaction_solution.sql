select
    satisfaction,
    count(satisfaction) as employees
from employee_satisfaction_survey
where (timestamp, email) in (
    select max(timestamp), email from employee_satisfaction_survey group by email
)
group by satisfaction
order by satisfaction
