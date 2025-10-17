create or replace function p_en_g(weight integer) returns integer as $$
begin
return weight * 454;
end;
$$ language 'plpgsql';

create or replace function affichage(weight integer) returns integer as $$

