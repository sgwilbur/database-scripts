-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/miscellaneous/drop_all.sql
-- Author       : DR Timothy S Hall
-- Description  : Drops all objects within the current schema.
-- Call Syntax  : @drop_all
-- Last Modified: 12/06/2003
-- -----------------------------------------------------------------------------------
BEGIN
  FOR cur_rec IN (SELECT table_name, constraint_name 
                  FROM   user_constraints
                  WHERE  constraint_type = 'R') LOOP
    EXECUTE IMMEDIATE 'ALTER TABLE ' || cur_rec.table_name || ' DROP CONSTRAINT ' || cur_rec.constraint_name;
  END LOOP;

  FOR cur_rec IN (SELECT object_name, object_type 
                  FROM   user_objects) LOOP
    BEGIN
      EXECUTE IMMEDIATE 'DROP ' || cur_rec.object_type || ' ' || cur_rec.object_name;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
  END LOOP;
END;
/
