--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:46:32 06/07/2016
-- Design Name:   
-- Module Name:   C:/Users/mmajumde/Documents/sasebo_giii/sasebo_giii_aes/AES_crypto/tb_keyexpan.vhd
-- Project Name:  AES_crypto
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: key_expansion
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
 
ENTITY tb_keyexpan IS
END tb_keyexpan;
 
ARCHITECTURE behavior OF tb_keyexpan IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT key_expansion
    PORT(
         kin : IN  std_logic_vector(127 downto 0);
         rcon : IN  std_logic_vector(7 downto 0);
         kout : OUT  std_logic_vector(127 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal kin : std_logic_vector(127 downto 0) := (others => '0');
   signal rcon : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal kout : std_logic_vector(127 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: key_expansion PORT MAP (
          kin => kin,
          rcon => rcon,
          kout => kout
        );

   -- Clock process definitions
   

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      kin<=x"123D21583AB6EFEF21903F01900E355C";
		rcon<=x"01";

      -- insert stimulus here 

      wait;
   end process;

END;
