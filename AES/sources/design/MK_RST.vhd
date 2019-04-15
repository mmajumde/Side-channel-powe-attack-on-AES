----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:00:54 04/24/2016 
-- Design Name: 
-- Module Name:    MK_RST - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MK_RST is
    Port ( locked : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : out  STD_LOGIC);
end MK_RST;

architecture Behavioral of MK_RST is
signal cnt: std_logic_vector (15 downto 0);
signal reduct: std_logic;
begin
reduct<=not(cnt(0) and cnt(1) and cnt(2) and cnt(3) and cnt(4)and cnt(5)and cnt(6) and cnt(7) and cnt(8) and cnt(9) and cnt(10)and cnt(11) and cnt (12) and cnt(13) and cnt(14) and cnt(15));

process(clk)
 begin

 if ((clk'event and clk='1')) then
	if (locked='0')then
		cnt<="0000000000000000";
	elsif (reduct='1')then
		cnt<=std_logic_vector(unsigned(cnt)+1);
	end if;
 end if;
end process;
--process(locked)
-- begin

-- if ((locked'event and locked='0')) then
--	if (locked='0')then
--		cnt<="0000000000000000";
--	elsif (reduct='1')then
--		cnt<=std_logic_vector(unsigned(cnt)+1);
--	end if;
-- end if;
--end process;

rst<=reduct;


end Behavioral;

