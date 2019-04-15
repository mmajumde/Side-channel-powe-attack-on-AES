-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY test_mx_column IS
  END test_mx_column;

  ARCHITECTURE behavior OF test_mx_column IS 

  -- Component Declaration
          COMPONENT mix_column
          PORT(
                 
                  in32: IN std_logic_vector(31 downto 0);       
                  out32 : OUT std_logic_vector(31 downto 0)
                  );
          END COMPONENT;

          --SIGNAL in32 :  std_logic;
          SIGNAL in32,out32 :  std_logic_vector(31 downto 0);
          

  BEGIN

  -- Component Instantiation
          uut: mix_column PORT MAP(
                  in32 => in32,
                  out32 => out32
          );


  --  Test Bench Statements
     tb : PROCESS
     BEGIN
        in32<=x"F12B2345";
        wait for 100 ns; -- wait until global set/reset completes
		  in32<=x"321A0012";
		  wait for 100 ns;
		  in32<=x"ECF2221C";
		  wait for 100 ns;
		  in32<=x"55555555";
        -- Add user defined stimulus here

        wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;
