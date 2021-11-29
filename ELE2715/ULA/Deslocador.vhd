--==============================================================================================
--				LOGICA DE UM DESLOCADOR <<
--==============================================================================================
entity SHFTL is
	port (I : in bit_vector(7 downto 0);
			S : in bit_vector(2 downto 0);
			Y : out bit_vector(7 downto 0);
			C : out bit;
			Z : out bit);
end SHFTL;

architecture ckt of SHFTL is

	signal zz : bit_vector(7 downto 0);

	begin

		process(I,S, ZZ)
		begin

		if (S = "000") then 
			Y <= I;
			C <= I(7);
			Z <= not (I(7) or I(6) or I(5) or I(4) or I(3) or I(2) or I(1) or I(0));
		end if;

		if (S = "001") then 
			Y <= I sll 1;
			ZZ <= I sll 1;
			C <= ZZ(7);
			Z <= not (ZZ(7) or ZZ(6) or ZZ(5) or ZZ(4) or ZZ(3) or ZZ(2) or ZZ(1) or ZZ(0));
		end if;	

		if (S= "010") then 
			Y <= I sll 2;
			ZZ <= I sll 2;
			C <= ZZ(7);
			Z <= not (ZZ(7) or ZZ(6) or ZZ(5) or ZZ(4) or ZZ(3) or ZZ(2) or ZZ(1) or ZZ(0));
		end if;

		if (S = "011") then 
			Y <= I sll 3;
			ZZ <= I sll 3;
			C <= ZZ(7);
			Z <= not (ZZ(7) or ZZ(6) or ZZ(5) or ZZ(4) or ZZ(3) or ZZ(2) or ZZ(1) or ZZ(0));
		end if;

		if (S = "100") then 
			Y <= I sll 4;
			ZZ <= I sll 4;
			C <= ZZ(7);
			Z <= not (ZZ(7) or ZZ(6) or ZZ(5) or ZZ(4) or ZZ(3) or ZZ(2) or ZZ(1) or ZZ(0));
		end if;

		if (S = "101") then 
			Y <= I sll 5;
			ZZ <= I sll 5;
			C <= ZZ(7);
			Z <= not (ZZ(7) or ZZ(6) or ZZ(5) or ZZ(4) or ZZ(3) or ZZ(2) or ZZ(1) or ZZ(0));
		end if;

		if (S = "110") then 
			Y <= I sll 6;
			ZZ <= I sll 6;
			C <= ZZ(7);
			Z <= not (ZZ(7) or ZZ(6) or ZZ(5) or ZZ(4) or ZZ(3) or ZZ(2) or ZZ(1) or ZZ(0));
		end if;

		if (S = "111") then 
			Y <= I sll 7;
			ZZ <= I sll 7;
			C <= ZZ(7);
			Z <= not (ZZ(7) or ZZ(6) or ZZ(5) or ZZ(4) or ZZ(3) or ZZ(2) or ZZ(1) or ZZ(0));
		end if;

		

		end process;
end ckt;

--==============================================================================================
--				LOGICA DE UM DESLOCADOR >>
--==============================================================================================

entity SHFTR is
	port (I : in bit_vector(7 downto 0);
			S : in bit_vector(2 downto 0);
			Y : out bit_vector(7 downto 0);
			Z : out bit);
end SHFTR;

architecture ckt of SHFTR is

	signal zz : bit_vector(7 downto 0);

	begin

		process(I,S, ZZ)
		begin

		if (S = "000") then 
			Y <= I;
			Z <= not (I(7) or I(6) or I(5) or I(4) or I(3) or I(2) or I(1) or I(0));

		end if;

		if (S = "001") then 
			Y <= I srl 1;
			ZZ <= I srl 1;
			Z <= not (ZZ(7) or ZZ(6) or ZZ(5) or ZZ(4) or ZZ(3) or ZZ(2) or ZZ(1) or ZZ(0));

		end if;	

		if (S= "010") then 
			Y <= I srl 2;
			ZZ <= I srl 2;
			Z <= not (ZZ(7) or ZZ(6) or ZZ(5) or ZZ(4) or ZZ(3) or ZZ(2) or ZZ(1) or ZZ(0));

		end if;

		if (S = "011") then 
			Y <= I srl 3;
			ZZ <= I srl 3;
			Z <= not (ZZ(7) or ZZ(6) or ZZ(5) or ZZ(4) or ZZ(3) or ZZ(2) or ZZ(1) or ZZ(0));

		end if;

		if (S = "100") then 
			Y <= I srl 4;
			ZZ <= I srl 4;
			Z <= not (ZZ(7) or ZZ(6) or ZZ(5) or ZZ(4) or ZZ(3) or ZZ(2) or ZZ(1) or ZZ(0));

		end if;

		if (S = "101") then 
			Y <= I srl 5;
			ZZ <= I srl 5;
			Z <= not (ZZ(7) or ZZ(6) or ZZ(5) or ZZ(4) or ZZ(3) or ZZ(2) or ZZ(1) or ZZ(0));

		end if;

		if (S = "110") then 
			Y <= I srl 6;
			ZZ <= I srl 6;
			Z <= not (ZZ(7) or ZZ(6) or ZZ(5) or ZZ(4) or ZZ(3) or ZZ(2) or ZZ(1) or ZZ(0));

		end if;

		if (S = "111") then 
			Y <= I srl 7;
			ZZ <= I srl 7;
			Z <= not (ZZ(7) or ZZ(6) or ZZ(5) or ZZ(4) or ZZ(3) or ZZ(2) or ZZ(1) or ZZ(0));

		end if;

		
		end process;
end ckt;