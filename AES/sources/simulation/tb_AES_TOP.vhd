-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY tb_AES_TOP IS
  END tb_AES_TOP;

  ARCHITECTURE behavior OF tb_AES_TOP IS 

  -- Component Declaration
          COMPONENT AES_TOP
          PORT(
           kin : in  STD_LOGIC_VECTOR (127 downto 0);
           din : in  STD_LOGIC_VECTOR (127 downto 0);
           dout : out  STD_LOGIC_VECTOR (127 downto 0);
           krdy : in  STD_LOGIC;
           drdy : in  STD_LOGIC;
           kvld : out  STD_LOGIC;
           dvld : out  STD_LOGIC;
           en : in  STD_LOGIC;
           bsy : out  STD_LOGIC;
           clk : in  STD_LOGIC;
			  p: out std_logic;
           rstn : in  STD_LOGIC;
			 rcons: out std_logic_vector(7 downto 0);
			  rkeys: out std_logic_vector(127 downto 0);
			  rkeys_nxt: out std_logic_vector(127 downto 0));
          END COMPONENT;

          SIGNAL kin,din,dout,rkeys,rkeys_nxt:  std_logic_vector(127 downto 0):=(others=>'0');
          SIGNAL krdy,drdy,kvld,dvld,en,bsy,clk,rstn,p :  std_logic := '0';
			 SIGNAL rcons: std_logic_vector(7 downto 0);
          

  BEGIN

  -- Component Instantiation
          uut:  AES_TOP PORT MAP(
                  kin=>kin,
						din=>din,
						dout=>dout,
						krdy=>krdy,
						drdy=>drdy,
						kvld=>kvld,
						dvld=>dvld,
						en=>en,
					p=>p,
						bsy=>bsy,
						clk=>clk,
						rstn=>rstn,
					rcons=>rcons,
						rkeys=>rkeys,
						rkeys_nxt=>rkeys_nxt
          );

 clk_process: process
   BEGIN
		clk<='0';
		wait for 10 ns;
		clk<='1';
		wait for 10 ns;
	END PROCESS clk_process;
  --  Test Bench Statements
     tb : PROCESS
     BEGIN
	     rstn<='0';
	     wait for 15 ns;
		  rstn<='1';
		  wait for 10 ns;
       Kin<=x"000102030405060708090A0B0C0D0E0F";
		 Din<=x"1724A258659E7D4301B6EB8FCCFAD935";
		  
		  en<='1';
        wait for 15 ns; -- wait until global set/reset completes
        
		  krdy<='1';
		  wait for 15 ns;
		  drdy<='1';
		  krdy<='0';
		  wait for 20 ns;
		  drdy<='0';
		  
        -- Add user defined stimulus here
        wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;
