create table comptes (
	no integer primary key,
	solde decimal(10,2)
);
insert into comptes values (1, 100);
insert into comptes values (2, 1000);
insert into comptes values (3, 1500);
insert into comptes values (4, 10);

create or replace function virement(crediteur integer, debiteur integer ,montant decimal(10, 2)) returns integer
as $$
BEGIN
	update comptes set solde = solde + montant where no = crediteur;
	update comptes set solde = solde - montant where no = debiteur;
	return 0;
END;
$$ language 'plpgsql';
	
create or replace function virement(crediteur integer, debiteur integer ,montant decimal(10, 2)) returns integer
as $$
DECLARE
ancien_solde decimal(10, 2);
BEGIN
	select solde into ancien_solde from comptes where no = debiteur;
	IF (ancien_solde > montant) THEN
		update comptes set solde = solde + montant where no = crediteur;
		update comptes set solde = solde - montant where no = debiteur;
		return 0;
	END IF;
	return -1;
END;
$$ language 'plpgsql';

create or replace function virement(crediteur integer, debiteur integer ,montant decimal(10, 2)) returns integer
as $$
DECLARE
ancien_solde decimal(10, 2);
test integer;
BEGIN
    select solde into ancien_solde from comptes where no = debiteur;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Compte no % inconnu', debiteur;
    END IF;
    IF (ancien_solde > montant) THEN
        select count(*) into test from comptes where no = crediteur;
        IF (test <> 1) THEN
                RAISE EXCEPTION 'Compte no % inconnu', crediteur;
        END IF;
        update comptes set solde = solde + montant where no = crediteur;
        update comptes set solde = solde - montant where no = debiteur;
        return 0;
    END IF;
    return -1;
END;
$$ language 'plpgsql';
