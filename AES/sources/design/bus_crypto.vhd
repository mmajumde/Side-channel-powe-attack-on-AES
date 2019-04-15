----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:51:26 06/08/2016 
-- Design Name: 
-- Module Name:    bus_crypto - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bus_crypto is
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
end bus_crypto;

architecture Behavioral of bus_crypto is
signal control,trig_wr,ctrl_wr: std_logic;
signal wr: std_logic_vector(1 downto 0);
signal blk_trig:std_logic_vector(3 downto 0);
signal blk_dout_reg: std_logic_vector(127 downto 0);
signal index: integer;
begin

index<=to_integer(unsigned(lbus_a(3 downto 0)));

control<='1' when lbus_di<=x"1234" else
			 '0';
ctrl_wr<=trig_wr and control;
blk_en<='1';
process(clk)
 begin
  if (clk'event and clk='1')then
	if(rst='1')then
		wr<="00";
	else
		wr<=wr(0)&lbus_wr;
	end if;
	end if;
	end process;
	
process(clk)
 begin
  if (clk'event and clk='1')then
	if(rst='1')then
		trig_wr<='0';
	elsif (wr="01")then
		trig_wr<='1';
	else
		trig_wr<='0';
	end if;
	end if;
end process;
	

	  
process(clk)
 begin
  if (clk'event and clk='1')then
	if(rst='1')then
     blk_dout_reg<=(others=>'0');
   elsif (blk_dvld='1')then
		blk_dout_reg<=blk_dout;
	end if;
  end if;
 end process;
   


--process(clk)
-- begin
--  if (clk'event and clk='1')then
--	if(rst='1')then
--     blk_trig<="0000";
--   elsif(ctrl_wr='1')then
--	  blk_trig<=lbus_di(0)&"000";
--	else
--		blk_trig<='0' & blk_trig(3 downto 1);
--	end if;
--end if;
--end process;

process(clk)
 begin
  if (clk'event and clk='1')then
	if(rst='1')then
     blk_trig<="0000";
   elsif(trig_wr='1' and lbus_a=x"1234")then
		
			blk_trig<=lbus_di(0)&"000";
	  
	else
		blk_trig<='0' & blk_trig(3 downto 1);
	end if;
end if;
end process;
blk_drdy<=blk_trig(0);
 
	

process(clk)
 begin
  if (clk'event and clk='1')then
	if(rst='1')then
		blk_krdy<='0';
   elsif (trig_wr='1' and lbus_a=x"1234")then
		blk_krdy<=lbus_di(1);
	else 
		blk_krdy<='0';
	end if;
  end if;
 end process;
 
 
   
process(clk)
 begin
  if (clk'event and clk='1')then
	if(rst='1')then
		blk_rstn<='1';
   elsif (trig_wr='1' and lbus_a=x"1234")then
		blk_rstn<=not lbus_di(2);
	else 
		blk_rstn<='1';
	end if;
  end if;
 end process;	
	
process(clk)
 
	begin
		if (clk'event and clk='1')then
			 if( rst='1')then
				blk_kin<=(others=>'0');
				blk_din<=(others=>'0');
			 elsif (trig_wr='1')then
					if (lbus_a(15 downto 4)=x"222")then
						for i in 0 to 7 loop
							if (index=i) then
									blk_din(i*16+15 downto i*16)<=lbus_di;
							end if;
						end loop;

					elsif (lbus_a(15 downto 4)=x"333")then
						for i in 0 to 7 loop
							if (index=i) then
									blk_kin(i*16+15 downto i*16)<=lbus_di;
							end if;
						end loop;
					end if;
			 elsif (lbus_rd='0')then
			     if (lbus_a(15 downto 4)=x"555")then
					 for i in 0 to 7 loop
							if (index=i) then
									lbus_do<=blk_dout_reg(i*16+15 downto i*16);
							end if;
						end loop;
					end if;
	 end if;
	end if;
	end process;
					
end Behavioral;

