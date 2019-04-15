--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:16:14 06/07/2016
-- Design Name:   
-- Module Name:   C:/Users/mmajumde/Documents/sasebo_giii/sasebo_giii_aes/AES_crypto/tb_AES_core.vhd
-- Project Name:  AES_crypto
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: AES_core
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_AES_core IS
END tb_AES_core;
 
ARCHITECTURE behavior OF tb_AES_core IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT AES_core
    PORT(
         din : IN  std_logic_vector(127 downto 0);
         kin : IN  std_logic_vector(127 downto 0);
         dout : OUT  std_logic_vector(127 downto 0);
         sel : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal din : std_logic_vector(127 downto 0) := (others => '0');
   signal kin : std_logic_vector(127 downto 0) := (others => '0');
   signal sel : std_logic := '0';

 	--Outputs
   signal dout : std_logic_vector(127 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: AES_core PORT MAP (
          din => din,
          kin => kin,
          dout => dout,
          sel => sel
        );

   -- Clock process definitions
   
--   begin
--	 clk <= '0';
--		wait for <clock>_period/2;
--		clk <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		din<=x"123412343456345621AB3FFF7EFE333C";
		kin<=x"123D21583AB6EFEF21903F01900E355C";
		sel<='0';
      -- hold reset state for 100 ns.
    --  wait for 100 ns;	


      -- insert stimulus here 

      wait;
   end process;

END;
