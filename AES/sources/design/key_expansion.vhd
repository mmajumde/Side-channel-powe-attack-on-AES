----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:42:08 06/07/2016 
-- Design Name: 
-- Module Name:    key_expansion - Behavioral 
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

entity key_expansion is
    Port ( kin : in  STD_LOGIC_VECTOR (127 downto 0);
           rcon : in  STD_LOGIC_VECTOR (7 downto 0);
           kout : out  STD_LOGIC_VECTOR (127 downto 0));
end key_expansion;

architecture Behavioral of key_expansion is
component SUBBYTE
		Port ( x : in  STD_LOGIC_VECTOR (31 downto 0);
           y : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
signal ws, wr, w0, w1, w2, w3: std_logic_vector(31 downto 0);
signal sig: std_logic_vector(31 downto 0);

begin
sig<=kin(23 downto 16) & kin(15 downto 8) & kin(7 downto 0) & kin (31 downto 24);
L1: SUBBYTE port map(x=>sig,y=>ws);
wr<=(ws(31 downto 24) xor rcon) & ws(23 downto 0);
w0<=wr xor kin(127 downto 96);
w1<=w0 xor kin(95 downto 64);
w2<=w1 xor kin(63 downto 32);
w3<=w2 xor kin(31 downto 0);

kout<=w0 & w1 & w2 & w3;
end Behavioral;

