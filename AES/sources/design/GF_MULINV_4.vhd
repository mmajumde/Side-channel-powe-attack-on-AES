----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:40:24 01/21/2016 
-- Design Name: 
-- Module Name:    GF_MULINV_4 - Behavioral 
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

entity GF_MULINV_4 is
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           y : out  STD_LOGIC_VECTOR (3 downto 0));
end GF_MULINV_4;

architecture Behavioral of GF_MULINV_4 is

	function gf_sq2(x: std_logic_vector(1 downto 0))return std_logic_vector is
	variable m: std_logic_vector(1 downto 0);
		begin
			m(1):=x(1);
			m(0):=x(1) xor x(0);
			return m;
		end function gf_sq2;
		
	function gf_mul2(x,y: std_logic_vector(1 downto 0))return std_logic_vector is
	variable m: std_logic_vector(1 downto 0);
		begin
			m(1):=(x(1) and y(1)) xor (x(0) and y(1)) xor (x(1) and y(0));
			m(0):=(x(1) and y(1)) xor (x(0) and y(0));
			return m;
		end function gf_mul2;
		
	function gf_mul2_phi(x:std_logic_vector(1 downto 0))return std_logic_vector is
	variable m: std_logic_vector(1 downto 0);
		begin
			m(1):=x(1) xor x(0);
			m(0):=x(1);
			return m;
		end function gf_mul2_phi;
		
   function gf_inv2(x:std_logic_vector(1 downto 0))return std_logic_vector is
	variable m: std_logic_vector(1 downto 0);
		begin
			m(1):=x(1);
			m(0):=x(1) xor x(0);
			return m;
		end gf_inv2;
		
	signal g1,g0,g1_g0,p,pi: std_logic_vector(1 downto 0);

begin
	g1<=x(3 downto 2);
	g0<=x(1 downto 0);
	g1_g0<=g1 xor g0;
	p<=gf_mul2_phi(gf_sq2(g1)) xor gf_mul2(g1_g0,g0);
	pi<=gf_inv2(p);
	y(3 downto 2)<=gf_mul2(g1,pi);
	y(1 downto 0)<=gf_mul2(g1_g0,pi);


end Behavioral;

