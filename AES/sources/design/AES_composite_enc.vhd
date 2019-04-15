----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:58:15 01/21/2016 
-- Design Name: 
-- Module Name:    GF_MULINV_8 - Behavioral 
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

entity GF_MULINV_8 is
    Port ( x : in  STD_LOGIC_VECTOR (7 downto 0);
           y : out  STD_LOGIC_VECTOR (7 downto 0));
end GF_MULINV_8;

architecture Behavioral of GF_MULINV_8 is
	function mat_x(x:std_logic_vector(7 downto 0))return std_logic_vector is
	variable m: std_logic_vector(7 downto 0);
		begin
			m(7):=x(7)xor x(5);
			m(6):=x(7) xor x(6) xor x(4) xor x(3) xor x(2) xor x(1);
			m(5):=x(7) xor x(5) xor x(3) xor x(2);
			m(4):=x(7) xor x(5) xor x(3) xor x(2) xor x(1);
			m(3):=x(7) xor x(6) xor x(2) xor x(1);
			m(2):=x(7) xor x(4) xor x(3) xor x(2) xor x(1);
			m(1):=x(6) xor x(4) xor x(1);
			m(0):=x(6) xor x(1) xor x(0);
			return m;
		end mat_x;
	function mat_xi(x:std_logic_vector(7 downto 0))return std_logic_vector is
	variable m: std_logic_vector(7 downto 0);
		begin
			m(7):=x(7) xor x(6) xor x(5) xor x(1);
			m(6):=x(6) xor x(2);
			m(5):=x(6) xor x(5) xor x(1);
			m(4):=x(6) xor x(5) xor x(4) xor x(2) xor x(1);
			m(3):=x(5) xor x(4) xor x(3) xor x(2) xor x(1);
			m(2):=x(7) xor x(4) xor x(3) xor x(2) xor x(1);
			m(1):=x(5) xor x(4);
			m(0):=x(6) xor x(5) xor x(4) xor x(2) xor x(0);
			return m;
		end mat_xi;	
		
	function gf_sq4(x:std_logic_vector(3 downto 0))return std_logic_vector is
	variable m: std_logic_vector(3 downto 0);
		begin
			m(0):=x(3) xor x(1) xor x(0);
			m(1):=x(2) xor x(1);
			m(2):=x(3) xor x(2);
			m(3):=x(3);
			return m;
		end gf_sq4;
		
	function gf_mul4(x,y:std_logic_vector(3 downto 0))return std_logic_vector is
	variable m: std_logic_vector(3 downto 0);
		begin
			m(3):=(x(3) and y(3)) xor (x(3) and y(1)) xor (x(1) and y(3)) xor (x(2) and y(3)) xor (x(2) and y(1)) xor (x(0) and y(3)) xor (x(3) and y(2)) xor (x(3) and y(0)) xor (x(1) and y(2));
			m(2):=(x(3) and y(3)) xor (x(3) and y(1)) xor (x(1) and y(3)) xor (x(2) and y(2)) xor (x(2) and y(0)) xor (x(0) and y(2));
			m(1):=(x(2) and y(3)) xor (x(3) and y(2)) xor (x(2) and y(2)) xor (x(1) and y(1)) xor (x(0) and y(1)) xor (x(1) and y(0));
			m(0):=(x(3) and y(3)) xor (x(2) and y(3)) xor (x(3) and y(2)) xor (x(1) and y(1)) xor (x(0) and y(0));
			return m;
		end gf_mul4;
		
	function gf_mul4_lambda(x:std_logic_vector(3 downto 0))return std_logic_vector is
	variable m: std_logic_vector(3 downto 0);
		begin
			m(3):=x(2) xor x(0);
			m(2):=x(3) xor x(2) xor x(1) xor x(0);
			m(1):=x(3);
			m(0):=x(2);
			return m;
		end gf_mul4_lambda;
		
	component GF_MULINV_4
		Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           y : out  STD_LOGIC_VECTOR (3 downto 0));
		end component;

	
	signal xt,yt: std_logic_vector(7 downto 0);
	signal g1,g0,g1_g0,p,pi: std_logic_vector(3 downto 0);
	

begin
xt<=mat_x(x);
g1<=xt(7 downto 4);
g0<=xt(3 downto 0);
g1_g0<=g1 xor g0;
p<=gf_mul4_lambda(gf_sq4(g1)) xor gf_mul4(g1_g0,g0);

pp1: GF_MULINV_4 PORT MAP(x=>p,y=>pi);
yt(7 downto 4)<=gf_mul4(g1,pi);
yt(3 downto 0)<=gf_mul4(g1_g0,pi);
y<=mat_xi(yt);
end Behavioral;

