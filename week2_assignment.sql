insert into dividend values
 ('AHPC',20702071),
 ('AHPC',20712072),
 ('AHPC',20732074),
 ('AHPC',20762077),
 ('CZBIL',20692070),
 ('CZBIL',20702071),
 ('CZBIL',20712072),
 ('CZBIL',20732074),
 ('GBIME',20692070),
 ('GBIME',20702071),
 ('GBIME',20712072),
 ('GBIME',20732074);

with recursive initial as (
  select company, left(fiscal_year::text,4)::int as years from dividend
), terminal as (
  select initial.company, initial.years, 1 as counter 
   from initial
  union distinct
  select initial.company, initial.years, terminal.counter + 1 
   from initial
   join terminal 
     on initial.company = terminal.company
    and initial.years = terminal.years + 1
)
select jsonb_agg(distinct company) from terminal
where counter >= 3; 