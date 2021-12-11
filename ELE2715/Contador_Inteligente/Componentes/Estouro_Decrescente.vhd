--=================================================================
--				ESTOURO DECRESCENTE
--=================================================================

entity TC_DEC is
	port(I : in bit_vector(3 downto 0);
			Y : out bit);
end TC_DEC;

architecture ckt of TC_DEC is

	begin
		Y <= not (I(3) or I(2) or I(1) or I(0));

end ckt;