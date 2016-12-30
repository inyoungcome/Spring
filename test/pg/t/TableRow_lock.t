
__DATA__

=== TEST 1: UPDATE statement conflict FOR UPDATE lock in Read COmmit Isolation
--- src
---1 transaction
BEGIN
update parent set name='Parent1' where id = 1;

---2 concurent transaction
BEGIN
select * from parent where id=1 for update;

--- out
===in transaction READ COMMIT isolation ,select will block til the row update success



