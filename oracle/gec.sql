DECLARE
  sql_stmt VARCHAR(255);
  table_name VARCHAR(64);
  row_count INTEGER;
BEGIN
  sql_stmt := 'select count(*) from :1 ';

  DBMS_OUTPUT.PUT_LINE('About to do stuff...');

  FOR entitytable in ( select * from entitydef )
  LOOP
	  table_name := entitytable.db_name;
	  EXECUTE IMMEDIATE sql_stmt INTO row_count USING table_name;
	  DBMS_OUTPUT.PUT_LINE(' entity table: ' || entitytable.db_name);
          DBMS_OUTPUT.PUT_LINE(' row count: ' || row_count );

  END LOOP;
END;
/
