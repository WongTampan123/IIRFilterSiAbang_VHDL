library ieee;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity filter_si_abang is
	port(
		CLK		: IN STD_LOGIC;
		ADC_IN	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		PV_OUT	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
end entity;

architecture behavioral of filter_si_abang is

	SIGNAL PV_1	: INTEGER := 0;
	SIGNAL PV	: INTEGER := 0;
	SIGNAL PVf	: INTEGER := 0;
	SIGNAL CNT	: INTEGER := 0;

begin

PV 	<= to_integer(unsigned(ADC_IN));

process(CLK)
begin
	if(rising_edge(CLK))then
		if(CNT=0)then
			PVf	<= (PV+10*PV_1)/11;
			CNT	<= CNT+1;
		elsif(CNT=1)then
			PV_1	<= PVf;
			CNT	<= 0;
		end if;
	end if;
end process;

PV_OUT	<= STD_LOGIC_VECTOR(to_unsigned(PVf,PV_OUT'length));

end behavioral;
		