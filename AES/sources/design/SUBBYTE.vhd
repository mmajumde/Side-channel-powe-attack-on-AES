----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:21:31 01/27/2016 
-- Design Name: 
-- Module Name:    SUBBYTE - Behavioral 
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

entity SUBBYTE is
    Port ( x : in  STD_LOGIC_VECTOR (31 downto 0);
           y : out  STD_LOGIC_VECTOR (31 downto 0));
end SUBBYTE;

architecture Behavioral of SUBBYTE is
function mat_at(x:std_logic_vector(7 downto 0))return std_logic_vector is
	variable m: std_logic_vector(7 downto 0);
		begin
			m(7):=x(7)xor x(6) xor x(5) xor x(4) xor x(3);
			m(6):= not(x(6) xor x(5) xor x(4) xor x(3) xor x(2));
			m(5):=not(x(5) xor x(4) xor x(3) xor x(2) xor x(1));
			m(4):=x(4) xor x(3) xor x(2) xor x(1) xor x(0);
			m(3):=x(7) xor x(3) xor x(2) xor x(1) xor x(0);
			m(2):=x(7) xor x(6) xor x(2) xor x(1) xor x(0);
			m(1):=not(x(7) xor x(6) xor x(5) xor x(1) xor x(0));
			m(0):=not(x(7) xor x(6) xor x(5) xor x(4) xor x(0));
			return m;
		end mat_at;
		
		COMPONENT GF_MULINV_8 
		Port ( x : in  STD_LOGIC_VECTOR (7 downto 0);
           y : out  STD_LOGIC_VECTOR (7 downto 0));
		end component;
		
signal s: std_logic_vector (31 downto 0);

begin
pp0:GF_MULINV_8 PORT MAP (x=>x(31 downto 24),y=>s(31 downto 24));
pp1:GF_MULINV_8 PORT MAP (x=>x(23 downto 16),y=>s(23 downto 16));
pp2:GF_MULINV_8 PORT MAP (x=>x(15 downto 8),y=>s(15 downto 8));
pp3:GF_MULINV_8 PORT MAP (x=>x(7 downto 0),y=>s(7 downto 0));

y(31 downto 24)<=mat_at(s(31 downto 24));
y(23 downto 16)<=mat_at(s(23 downto 16));
y(15 downto 8)<=mat_at(s(15 downto 8));
y(7 downto 0)<=mat_at(s(7 downto 0));



end Behavioral;

