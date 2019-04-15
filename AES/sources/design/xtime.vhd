library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity xtime is
    Port ( in8 : in STD_LOGIC_VECTOR (7 downto 0);
           out8 : out STD_LOGIC_VECTOR (7 downto 0));
end xtime;

architecture Behavioral of xtime is
    signal x : std_logic_vector(7 downto 0);
begin
    process(x, in8)
    begin
        if in8(7) = '0' then
            out8 <= in8(6 downto 0) & '0';
        else
            out8 <= (in8(6 downto 0) & '0') XOR x"1b";
        end if;
    end process;
end Behavioral;
