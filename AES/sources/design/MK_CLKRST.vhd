----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:03:50 04/24/2016 
-- Design Name: 
-- Module Name:    MK_CLKRST - Behavioral 
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
library UNISIM;
use UNISIM.VComponents.all;

entity MK_CLKRST is
    Port ( clkin : in  STD_LOGIC;
           rstnin : in  STD_LOGIC;
           clk : out  STD_LOGIC;
           rst : out  STD_LOGIC);
end MK_CLKRST;

architecture Behavioral of MK_CLKRST is
component MK_RST 
    Port ( locked : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : out  STD_LOGIC);
end component;

signal ref_clk,clk_s: std_logic;

begin
clk<=clk_s;
u10: IBUFG port map(O=>ref_clk,I=>clkin);

u12: BUFG port map(I=>ref_clk,O=>clk_s);


L3: MK_RST 

port map(rstnin,clk_s,rst);


end Behavioral;

