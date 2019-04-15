----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:34:26 01/27/2016 
-- Design Name: 
-- Module Name:    tst - Behavioral 
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

entity tst is
    Port ( x : in  STD_LOGIC_VECTOR (1 downto 0);
           y : out  STD_LOGIC_VECTOR (1 downto 0));
end tst;

architecture Behavioral of tst is

function tfunc(x:std_logic_vector(1 downto 0))return std_logic_vector is
	variable m:std_logic_vector(1 downto 0);
	begin
		m(1):=x(1) and x(0);
		m(0):=x(0) and x(0);
		return m;
	end function tfunc;
function rfunc(x:std_logic_vector(1 downto 0))return std_logic_vector is
	variable m:std_logic_vector(1 downto 0);
	begin
		m(1):=x(1) xor x(0);
		m(0):=x(0) xor x(1);
		return m;
	end function rfunc;
signal t:std_logic_vector(1 downto 0);		
begin
t<=tfunc(x);
y<=rfunc(t);

end Behavioral;

