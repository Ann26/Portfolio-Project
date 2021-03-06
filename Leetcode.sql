-- Combine Two Tables

select p.firstName,
        p.lastName,
        a.city,
        a.state
from person p
left join address a
on p.personID = a.personID
;

-- Find Customer Referee
select name
from customer
where referee_id is null
or referee_id != 2
;

-- Department Highest Salary

select abc.n as Department,
            e1.name as Employee,
            e1.salary
from (
    select e.departmentid as d1,
            d.name as n,
            max(e.salary) as max
    from employee e
    join department d
    on e.departmentid = d.id
    group by 1,2) as abc
join employee e1
on abc.d1 = e1.departmentid
where e1.salary = abc.max
;

-- Department Top Three Salaries

select t1.department,
       t1.employee,
       t1.salary

from (select d.name as Department,
                            e.name as Employee,
                            e.salary
                    from employee e
                    join department d
                    on e.departmentid = d.id) as t1
where concat (t1.department,t1.salary)
in(
    select abc1.combine
    from(
        select abc.department,
                abc.salary,
                concat(abc.department,abc.salary) as combine
        from (
            with total as(
                        select d.name as Department,
                                e.name as Employee,
                                e.salary
                        from employee e
                        join department d
                        on e.departmentid = d.id
                        )
            select t.department,
                    t.salary,
                    row_number() over(partition by t.department order by t.salary desc) as row_num
            from total t
            group by 1,2
            order by 1, 2 desc
            ) abc
        where abc.row_num in ('1','2','3')
        ) abc1
    )
    ;

-- Capital Gain/Loss

 select b.stock_name,
       (s.sell - b.buy) as capital_gain_loss
from (select stock_name, sum(price) as buy
      from stocks
      where operation = 'buy'
      group by stock_name) b
join (select stock_name, sum(price) as sell
      from stocks
      where operation = 'sell'
      group by stock_name) s
 on b.stock_name = s.stock_name
;
