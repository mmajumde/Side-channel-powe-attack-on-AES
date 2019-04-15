--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:22:56 06/28/2016
-- Design Name:   
-- Module Name:   C:/Users/mmajumde/Documents/sasebo_giii/sasebo_giii_aes/AES_crypto/tb_GF_MULINV_4.vhd
-- Project Name:  AES_crypto
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: GF_MULINV_4
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
 
ENTITY tb_GF_MULINV_4 IS
END tb_GF_MULINV_4;
 
ARCHITECTURE behavior OF tb_GF_MULINV_4 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT GF_MULINV_4
    PORT(
         x : IN  std_logic_vector(3 downto 0);
         y : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal x : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal y : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: GF_MULINV_4 PORT MAP (
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
		x<=x"F";
      wait for 100 ns;	
		x<=x"E";
		wait for 100 ns;
		x<=x"D";
      

      -- insert stimulus here 

      wait;
   end process;

END;
