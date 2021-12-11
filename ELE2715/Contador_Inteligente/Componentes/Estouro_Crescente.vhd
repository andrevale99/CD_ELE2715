--=================================================================
--				ESTOURO CRESCENTE
--=================================================================
entity TC_CRES is
	port(I : in bit_vector(3 downto 0);
			Y : out bit);
end TC_CRES;

architecture ckt of TC_CRES is

	begin
		Y <= I(3) and I(2) and I(1) and I(0);

end ckt;