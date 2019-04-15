----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:45:40 06/08/2016 
-- Design Name: 
-- Module Name:    Crypto_TOP - Behavioral 
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
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:56:07 04/24/2016 
-- Design Name: 
-- Module Name:    Crypto_TOP - Behavioral 
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

entity Crypto_TOP_SHA is
    Port ( lbus_di_a : in  STD_LOGIC_VECTOR (15 downto 0);
           lbus_do : out  STD_LOGIC_VECTOR (15 downto 0);
           lbus_wrn : in  STD_LOGIC;
           lbus_rdn : in  STD_LOGIC;
           lbus_clkn : in  STD_LOGIC;
           lbus_rstn : in  STD_LOGIC;
           gpio_startn : out  STD_LOGIC;
           gpio_endn : out  STD_LOGIC;
           gpio_exec : out  STD_LOGIC;
			  led:out std_logic_vector(9 downto 0);
           osc_en_b : out  STD_LOGIC);
end Crypto_TOP_SHA;

architecture Behavioral of Crypto_TOP_SHA is
signal lbus_a,lbus_di,lbus_do_s: std_logic_vector(15 downto 0);
signal blk_kin,blk_din,blk_dout: std_logic_vector(127 downto 0);
signal blk_krdy,blk_kvld,blk_drdy,blk_dvld: std_logic;
signal blk_en,blk_rstn,blk_bsy: std_logic;
signal clk,rst,tew,ter,t_trig: std_logic;
component bus_crypto is
     Port ( lbus_a : in  STD_LOGIC_VECTOR (15 downto 0);
           lbus_di : in  STD_LOGIC_VECTOR (15 downto 0);
           lbus_wr : in  STD_LOGIC;
           lbus_rd : in  STD_LOGIC;
           lbus_do : out  STD_LOGIC_VECTOR (15 downto 0);
           blk_kin : out  STD_LOGIC_VECTOR (127 downto 0);
           blk_din : out  STD_LOGIC_VECTOR (127 downto 0);
           blk_dout : in  STD_LOGIC_VECTOR (127 downto 0);
           blk_krdy : out  STD_LOGIC;
           blk_drdy : out  STD_LOGIC;
           blk_kvld : in  STD_LOGIC;
           blk_dvld : in  STD_LOGIC;
           --blk_encdec : out  STD_LOGIC;
           blk_en : out  STD_LOGIC;
           blk_rstn : out  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC);
end component;

component AES_TOP
	Port ( kin : in  STD_LOGIC_VECTOR (127 downto 0);
           din : in  STD_LOGIC_VECTOR (127 downto 0);
           dout : out  STD_LOGIC_VECTOR (127 downto 0);
           krdy : in  STD_LOGIC;
           drdy : in  STD_LOGIC;
           kvld : out  STD_LOGIC;
           dvld : out  STD_LOGIC;
           en : in  STD_LOGIC;
           bsy : out  STD_LOGIC;
           clk : in  STD_LOGIC;
			  --p: out std_logic;
           rstn : in  STD_LOGIC);
			  --rcons: out std_logic_vector (7 downto 0);
			  --rkeys: out std_logic_vector(127 downto 0);
			  --rkeys_nxt: out std_logic_vector(127 downto 0));
	end component;

component MK_CLKRST is
    Port ( clkin : in  STD_LOGIC;
           rstnin : in  STD_LOGIC;
           clk : out  STD_LOGIC;
           rst : out  STD_LOGIC);
end component;

begin
gpio_startn<=not blk_drdy;
gpio_endn<=not blk_bsy;
gpio_exec<=clk;
osc_en_b<='0';
--led<=lbus_di_a(9 downto 0);
--led(8 downto 5)<=blk_din(127 downto 124);
--led(4 downto 0)<=blk_dout(127 downto 123);
--led(4 downto 0)<=lbus_di_a(4 downto 0);
--led(7 downto 0)<=lbus_do_s(7 downto 0);
--led(9)<=t_trig;
led(9)<=tew;
lbus_do<=lbus_do_s;
L1: bus_crypto port map(lbus_a=>lbus_a,lbus_di=>lbus_di,lbus_wr=>lbus_wrn,lbus_rd=>lbus_rdn,clk=>clk,rst=>rst,lbus_do=>lbus_do_s,
blk_kin=>blk_kin,blk_din=>blk_din,blk_dout=>blk_dout,blk_krdy=>blk_krdy,blk_drdy=>blk_drdy,blk_kvld=>blk_kvld,blk_dvld=>blk_dvld,blk_en=>blk_en,
blk_rstn=>blk_rstn);

L2:MK_CLKRST port map(clkin=>lbus_clkn,rstnin=>lbus_rstn,clk=>clk,rst=>rst);

L3: AES_TOP port map(kin=>blk_kin,din=>blk_din,dout=>blk_dout,krdy=>blk_krdy,drdy=>blk_drdy,kvld=>blk_kvld,dvld=>blk_dvld,en=>blk_en,bsy=>blk_bsy,
clk=>clk,rstn=>blk_rstn);
--comment start
process(clk)
	begin
		if(clk'event and clk='1')then
		   if(lbus_wrn='0')then
			  tew<=not tew;
			end if;
		   if(lbus_rdn='0')then
			  ter<=not ter;
			end if;
	   end if;
	end process;
	
process(clk)
	begin
		if(clk'event and clk='1')then
		   
		   if(blk_drdy='1')then
			  t_trig<=not t_trig;
			end if;
	   end if;
	end process;

--comment end
process(clk)
	begin
		if(clk'event and clk='1')then
		   if(lbus_wrn='1')then
			  lbus_a<=lbus_di_a;
			  led(8 downto 0)<=lbus_di_a(8 downto 0);
			  end if;
			if(lbus_wrn='0')then
				lbus_di<=lbus_di_a;
				led(8 downto 0)<=lbus_di_a(8 downto 0);
			  end if;
	   end if;
	end process;

end Behavioral;

