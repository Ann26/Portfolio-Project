

select b.stock_name,
--        b.buy,
--        s.sell,
       (s.sell - b.buy) as money
from (select stock_name, sum(price) as buy
      from hoatm.stocks
      where operation = 'buy'
      group by stock_name) b
         join (select stock_name, sum(price) as sell
               from hoatm.stocks
               where operation = 'sell'
               group by stock_name) s
              on b.stock_name = s.stock_name
