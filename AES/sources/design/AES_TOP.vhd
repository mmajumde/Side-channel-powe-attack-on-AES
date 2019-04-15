----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:03:23 06/07/2016 
-- Design Name: 
-- Module Name:    AES_TOP - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity AES_TOP is
    Port ( kin : in  STD_LOGIC_VECTOR (127 downto 0);
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
			  rcons: out std_logic_vector (7 downto 0);
			  rkeys: out std_logic_vector(127 downto 0);
			  rkeys_nxt: out std_logic_vector(127 downto 0)
			  );
end AES_TOP;

architecture Behavioral of AES_TOP is

component xtime 
Port ( in8 : in STD_LOGIC_VECTOR (7 downto 0);
           out8 : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component AES_core
 Port ( din : in  STD_LOGIC_VECTOR (127 downto 0);
           kin : in  STD_LOGIC_VECTOR (127 downto 0);
           dout : out  STD_LOGIC_VECTOR (127 downto 0);
           sel : in  STD_LOGIC);
end component;
 
component key_expansion
Port ( kin : in  STD_LOGIC_VECTOR (127 downto 0);
           rcon : in  STD_LOGIC_VECTOR (7 downto 0);
           kout : out  STD_LOGIC_VECTOR (127 downto 0));
end component;


signal dat,dat_nxt,key,rkey,rkey_nxt: std_logic_vector(127 downto 0);
signal rnd: std_logic_vector(9 downto 0);
signal rcon,y: std_logic_vector(7 downto 0);
signal sel,rst: std_logic;
signal unary_rnd: std_logic;
signal p1:std_logic:='0';
begin
rst<=not rstn; 
unary_rnd<=rnd(9) or rnd (8) or rnd (7) or rnd(6) or rnd(5) or rnd(4) or rnd(3) or rnd(2) or rnd(1);
dout<=dat;
p<=p1;
rcons<=rcon;
rkeys<=rkey;
rkeys_nxt<=rkey_nxt;
u1: AES_core port map(din=>dat,kin=>rkey_nxt,sel=>sel,dout=>dat_nxt);
u2: key_expansion port map(kin=>rkey,kout=>rkey_nxt,rcon=>rcon);
process (clk)
 begin
	if(clk'event and clk='1')then
		if(rst='1')then
			dvld<='0';
			
		elsif (en='1')then
		   dvld<=sel;
		end if;
  end if;
 end process;
 
 process (clk)
 begin
	if(clk'event and clk='1')then
		if(rst='1')then
			
			kvld<='0';
		elsif (en='1')then
			kvld<=krdy;	
		end if;
  end if;
 end process;
 
  process (clk)
 begin
	if(clk'event and clk='1')then
		if(rst='1')then
			
			bsy<='0';
		elsif (en='1')then
		bsy<=drdy or unary_rnd or sel;
		end if;
  end if;
 end process;
 
  process (clk)
 begin
	if(clk'event and clk='1')then
		if(rst='1')then
			
			sel<='0';
		elsif (en='1')then
		sel<=rnd(9);
		end if;
  end if;
 end process;
 
process (clk)
begin
  if (clk'event and clk='1')then
	 if(rst='1')then
		rnd<="0000000001";
	 elsif (en='1')then
		if (drdy='1')then
			rnd<=rnd(8 downto 0) & rnd(9);
		elsif (rnd(0)='0')then
			rnd<=rnd(8 downto 0) & rnd(9);
		end if;
	end if;
 end if;
end process;

process (clk)
 begin
  if (clk'event and clk='1')then
	 if(rst='1')then
		dat<=(others=>'0');
	 elsif (en='1')then
		if (drdy='1')then
			dat<=din xor key;
		elsif ((not rnd(0) or sel)='1')then
			dat<=dat_nxt;
		else
		p1<=not p1;
--		else
--		   dat<=(others=>'0');
		end if;
	end if;
 end if;
end process;

process (clk)
 begin
  if (clk'event and clk='1')then
	 if(rst='1')then
		key<=(others=>'0');
	 elsif (en='1')then
		if (krdy='1')then
			key<=kin;
		end if;
	end if;
 end if;
end process;

process (clk)
 begin
  if (clk'event and clk='1')then
	 if(rst='1')then
		rkey<=(others=>'0');
	 elsif (en='1')then
		if (krdy='1')then
			rkey<=kin;
		elsif (rnd(0)='1')then
		   rkey<=key;
		else
			rkey<=rkey_nxt;
		end if;
	end if;
 end if;
end process;

u3:xtime port map (in8=>rcon,out8=>y);

process (clk)
 begin
  if (clk'event and clk='1')then
	 if(rst='1')then
		rcon<="00000001";
	 elsif (en='1')then
		if (drdy='1')then
			rcon<="00000001";
		elsif (rnd(0)='0')then
		   rcon<=y;
		
		end if;
	end if;
 end if;
end process;
end Behavioral;

