--Task1

select sum(p.premium_amount) as total_premium,sum(c.claim_amount) as total_claim
from policies_insurance_large p
left join claims_insurance_large c
on p.policy_id = c.policy_id

--Task2
select extract(year from p.start_date) as year_,
sum(p.premium_amount) - nvl(sum(c.claim_amount), 0) as profit
from policies_insurance_large p
left join claims_insurance_large c
on p.policy_id = c.policy_id
group by extract(year from p.start_date)
order by year_;

--Task3
select status, count(*) as policy_count
from policies_insurance_large
group by status
order by policy_count desc;

--Task4
select * from (select a.agent_id,a.agent_name,count(*) as policy_count
from policies_insurance_large p
join agents_insurance_large a on a.agent_id = p.agent_id
group by a.agent_id, a.agent_name
order by policy_count desc)
where rownum <= 5;

--Task5
select * from (select a.branch,sum(p.premium_amount) as total_premium
from agents_insurance_large a
join policies_insurance_large p
on a.agent_id = p.agent_id
group by a.branch
order by total_premium desc)
where rownum <= 3;

--Task6
select c.city,count(distinct c.customer_id) as customer_count,
round(avg(p.premium_amount), 2) as avg_premium
from customers_insurance_large c
join policies_insurance_large p
on c.customer_id = p.customer_id
group by c.city;

--Task7
select age_group,round(avg(total_claim_per_customer), 2) as avg_claim_per_customer
from (select c.customer_id,
case
when c.age between 18 and 24 then '18-24'
when c.age between 25 and 34 then '25-34'
when c.age between 35 and 44 then '35-44'
when c.age between 45 and 54 then '45-54'
when c.age between 55 and 64 then '55-64'
else '65+'
end as age_group,
sum(cl.claim_amount) as total_claim_per_customer
from customers_insurance_large c
join policies_insurance_large p
on c.customer_id = p.customer_id
join claims_insurance_large cl
on p.policy_id = cl.policy_id
group by c.customer_id,
case
when c.age between 18 and 24 then '18-24'
when c.age between 25 and 34 then '25-34'
when c.age between 35 and 44 then '35-44'
when c.age between 45 and 54 then '45-54'
when c.age between 55 and 64 then '55-64'
else '65+'
end)
group by age_group
order by age_group;

--Task 8
select claim_reason,sum(claim_amount) as total_claim
from claims_insurance_large
group by claim_reason
order by total_claim desc;

--Task 9
select p.policy_type,round(count(cl.claim_id) / count(distinct p.policy_id), 2) as claim_ratio
from policies_insurance_large p
left join claims_insurance_large cl
on p.policy_id = cl.policy_id
group by p.policy_type
order by claim_ratio desc;

--Task 10
select
round(avg(coverage_amount), 2) as avg_coverage
from policies_insurance_large
where trim(lower(status)) = 'active';

--Task 11
select a.agent_name,sum(p.premium_amount) as total_premium,
nvl(sum(cl.claim_amount), 0) as total_claim
from agents_insurance_large a
join policies_insurance_large p
on a.agent_id = p.agent_id
left join claims_insurance_large cl
on p.policy_id = cl.policy_id
group by a.agent_name;

--Task 12
select a.agent_name,count(distinct p.customer_id) as customer_count,
round(avg(p.premium_amount), 2) as avg_premium
from agents_insurance_large a
join policies_insurance_large p
on a.agent_id = p.agent_id
group by a.agent_name;

--Task 13
select a.region,round((sum(p.premium_amount) - nvl(sum(cl.claim_amount), 0))
/ sum(p.premium_amount) * 100,2) as profitability_percent
from agents_insurance_large a
join policies_insurance_large p
on a.agent_id = p.agent_id
left join claims_insurance_large cl
on p.policy_id = cl.policy_id
group by a.region;

--Task 14
select payment_method,count(*) as payment_count,
round(count(*) / sum(count(*)) over () * 100, 2) as payment_share_percent
from payments_insurance_large
group by payment_method
order by payment_count desc;

--Task 15
select round(sum(case when pay.payment_date > pol.start_date then 1 else 0
end) / count(*) * 100,2) as late_payment_percent
from payments_insurance_large pay
join policies_insurance_large pol
on pay.policy_id = pol.policy_id;

--Task 16
select c.customer_id,round(avg(pay.amount), 2) as avg_payment
from customers_insurance_large c
join policies_insurance_large pol
on c.customer_id = pol.customer_id
join payments_insurance_large pay
on pol.policy_id = pay.policy_id
group by c.customer_id;

--Task 17
select * from (select a.branch,sum(p.premium_amount) as total_premium
from agents_insurance_large a
join policies_insurance_large p
on a.agent_id = p.agent_id
group by a.branch
order by total_premium desc)
where rownum <= 5;

--Task 18
select p.policy_type,sum(p.premium_amount) as total_premium
from policies_insurance_large p
group by p.policy_type
order by total_premium desc;

--Bonus 1
select a.agent_name,round((sum(p.premium_amount) - nvl(sum(c.claim_amount), 0))
/ sum(p.premium_amount) * 100,2) as profitability_percent
from agents_insurance_large a
join policies_insurance_large p
on a.agent_id = p.agent_id
left join claims_insurance_large c
on p.policy_id = c.policy_id
group by a.agent_name;

--Bonus 2
select c.customer_id,c.full_name,round(
nvl(sum(cl.claim_amount), 0) / sum(p.premium_amount),2) as claim_ratio
from customers_insurance_large c
join policies_insurance_large p
on c.customer_id = p.customer_id
left join claims_insurance_large cl
on p.policy_id = cl.policy_id
group by c.customer_id, c.full_name;

--Bonus 3
select round((c2024.total_claim - c2023.total_claim)/ c2023.total_claim * 100,2)
as claim_growth_percent
from(select sum(claim_amount) as total_claim from claims_insurance_large
where extract(year from claim_date) = 2023) c2023,(
select sum(claim_amount) as total_claim
from claims_insurance_large
where extract(year from claim_date) = 2024) c2024;


--Analyze 1
select a.region,a.agent_name,
sum(p.premium_amount) as total_premium,
nvl(sum(cl.claim_amount),0) as total_claim
from agents_insurance_large a
join policies_insurance_large p on a.agent_id = p.agent_id
left join claims_insurance_large cl on p.policy_id = cl.policy_id
group by a.region, a.agent_name
order by a.region, total_premium desc;

--Analyze 2
select extract(year from p.start_date) as year_,
sum(p.premium_amount) as total_premium,
nvl(sum(c.claim_amount),0) as total_claim
from policies_insurance_large p
left join claims_insurance_large c
on p.policy_id = c.policy_id
group by extract(year from p.start_date)
order by year_;








