----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:13:38 06/07/2016 
-- Design Name: 
-- Module Name:    AES_core - Behavioral 
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

entity AES_core is
    Port ( din : in  STD_LOGIC_VECTOR (127 downto 0);
           kin : in  STD_LOGIC_VECTOR (127 downto 0);
           dout : out  STD_LOGIC_VECTOR (127 downto 0);
           sel : in  STD_LOGIC);
end AES_core;

architecture Behavioral of AES_core is
signal st0,st1,st2,st3: std_logic_vector(31 downto 0); --state
signal sb0,sb1,sb2,sb3: std_logic_vector(31 downto 0); --state after subbyte
signal sr0,sr1,sr2,sr3: std_logic_vector(31 downto 0); --state after shift row
signal sc0,sc1,sc2,sc3: std_logic_vector(31 downto 0); --state after mix column
signal sk0,sk1,sk2,sk3: std_logic_vector(31 downto 0); --state after key expansion
--declaring subbyte component
component SUBBYTE
		Port ( x : in  STD_LOGIC_VECTOR (31 downto 0);
           y : out  STD_LOGIC_VECTOR (31 downto 0));
end component; 

--declaring mixcolumn component
component mix_column
      Port ( in32 : in  STD_LOGIC_VECTOR (31 downto 0);
           out32 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

begin
--assigning state
st0<=din(127 downto 96);
st1<=din(95 downto 64);
st2<=din(63 downto 32);
st3<=din(31 downto 0);
--subbyte operation
us0: SUBBYTE port map(x=>st0,y=>sb0);
us1: SUBBYTE port map(x=>st1,y=>sb1);
us2: SUBBYTE port map(x=>st2,y=>sb2);
us3: SUBBYTE port map(x=>st3,y=>sb3);
--shiftrow operation
sr0<=sb0(31 downto 24) & sb1 (23 downto 16) & sb2 (15 downto 8) & sb3 (7 downto 0);
sr1<=sb1(31 downto 24) & sb2 (23 downto 16) & sb3 (15 downto 8) & sb0 (7 downto 0);
sr2<=sb2(31 downto 24) & sb3 (23 downto 16) & sb0 (15 downto 8) & sb1 (7 downto 0);
sr3<=sb3(31 downto 24) & sb0 (23 downto 16) & sb1 (15 downto 8) & sb2 (7 downto 0);

--mixcolumn operation
uc0: mix_column port map(in32=>sr0,out32=>sc0);
uc1: mix_column port map(in32=>sr1,out32=>sc1);
uc2: mix_column port map(in32=>sr2,out32=>sc2);
uc3: mix_column port map(in32=>sr3,out32=>sc3);

--addroundkey
sk0<=sr0 xor kin(127 downto 96) when sel='1' else
	  sc0 xor kin(127 downto 96);
sk1<=sr1 xor kin(95 downto 64) when sel='1' else
	  sc1 xor kin(95 downto 64);
sk2<=sr2 xor kin(63 downto 32) when sel='1' else
	  sc2 xor kin(63 downto 32);
sk3<=sr3 xor kin(31 downto 0) when sel='1' else
	  sc3 xor kin(31 downto 0);
	  
dout<=sk0 & sk1 & sk2 & sk3;

end Behavioral;

