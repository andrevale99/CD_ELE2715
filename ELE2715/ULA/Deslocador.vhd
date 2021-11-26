--==============================================================================================
--				LOGICA DE UM DESLOCADOR <<
--==============================================================================================
entity SHFTL is
	port (I : in bit_vector(7 downto 0);
			S : in bit_vector(2 downto 0);
			Y : out bit_vector(7 downto 0));
end SHFTL;

architecture ckt of SHFTL is

	begin

		process(I,S)
		begin

		if (S = "000") then 
			Y <= I;
		end if;

		if (S = "001") then 
			Y <= I sll 1;

		end if;	

		if (S= "010") then 
			Y <= I sll 2;
		end if;

		if (S = "011") then 
			Y <= I sll 3;
		end if;

		if (S = "100") then 
			Y <= I sll 4;
		end if;

		if (S = "101") then 
			Y <= I sll 5;
		end if;

		if (S = "110") then 
			Y <= I sll 6;
		end if;

		if (S = "111") then 
			Y <= I sll 7;
		end if;

		end process;
end ckt;

--==============================================================================================
--				LOGICA DE UM DESLOCADOR >>
--==============================================================================================

entity SHFTR is
	port (I : in bit_vector(7 downto 0);
			S : in bit_vector(2 downto 0);
			Y : out bit_vector(7 downto 0));
end SHFTR;

architecture ckt of SHFTR is

	begin

		process(I,S)
		begin

		if (S = "000") then 
			Y <= I;
		end if;

		if (S = "001") then 
			Y <= I srl 1;

		end if;	

		if (S= "010") then 
			Y <= I srl 2;
		end if;

		if (S = "011") then 
			Y <= I srl 3;
		end if;

		if (S = "100") then 
			Y <= I srl 4;
		end if;

		if (S = "101") then 
			Y <= I srl 5;
		end if;

		if (S = "110") then 
			Y <= I srl 6;
		end if;

		if (S = "111") then 
			Y <= I srl 7;
		end if;

		end process;
end ckt;