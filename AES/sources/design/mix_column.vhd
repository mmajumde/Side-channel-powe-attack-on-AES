----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:39:12 06/07/2016 
-- Design Name: 
-- Module Name:    mix_column - Behavioral 
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

entity mix_column is
    Port ( in32 : in  STD_LOGIC_VECTOR (31 downto 0);
           out32 : out  STD_LOGIC_VECTOR (31 downto 0));
end mix_column;

architecture Behavioral of mix_column is
signal a0, a1, a2, a3 : std_logic_vector(7 downto 0);
    signal b0, b1, b2, b3 : std_logic_vector(7 downto 0);
    signal output : std_logic_vector(31 downto 0);

    component xtime
        port ( in8 : in STD_LOGIC_VECTOR (7 downto 0);
               out8 : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

begin

    a0 <= in32(31 downto 24);
    a1 <= in32(23 downto 16);
    a2 <= in32(15 downto 8);
    a3 <= in32(7 downto 0);

    X0: xtime port map(a0, b0);
    X1: xtime port map(a1, b1);
    X2: xtime port map(a2, b2);
    X3: xtime port map(a3, b3);
    
    process(a0, a1, a2, a3, b0, b1, b2, b3, output)
    begin
        output(31 downto 24) <= b0 xor a1 xor b1 xor a2 xor a3;
        output(23 downto 16) <= a0 xor b1 xor a2 xor b2 xor a3;
        output(15 downto 8) <= a0 xor a1 xor b2 xor a3 xor b3;
        output(7 downto 0) <= a0 xor b0 xor a1 xor a2 xor b3;
        
        out32 <= output;
    end process;




end Behavioral;

