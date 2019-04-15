--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:03:52 01/27/2016
-- Design Name:   
-- Module Name:   C:/Users/mmajumde/Documents/sasebo_giii/sasebo_giii_aes/AES_crypto/tbench_gfmulinv8.vhd
-- Project Name:  AES_crypto
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: GF_MULINV_8
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
 
ENTITY tbench_gfmulinv8 IS
END tbench_gfmulinv8;
 
ARCHITECTURE behavior OF tbench_gfmulinv8 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT GF_MULINV_8
    PORT(
         x : IN  std_logic_vector(7 downto 0);
         y : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal x : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal y : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: GF_MULINV_8 PORT MAP (
          x => x,
          y => y
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		x<="00000000";
		wait for 100 ns;
		x<="00000001";
		wait for 100 ns;
		x<="00000010";
		wait for 100 ns;
		x<="11110011";
		wait for 100 ns;
		x<="11110100";
		wait for 100 ns;
		x<="11100101";
		wait for 100 ns;
		x<="10100110";
		wait for 100 ns;
		x<="00000111";
		wait for 100 ns;
		x<="01111000";
		wait;
      
   end process;

END;

   