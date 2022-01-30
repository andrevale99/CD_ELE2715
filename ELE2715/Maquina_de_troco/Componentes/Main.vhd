entity MAIN is
	port (	clk : in bit;
			clear : in bit;
			iniciar : in bit;
			troco_real : in bit_vector(9 downto 0);
			load_reg : in bit;
			c1, c2, c3, c4, c5, c6 : in bit_vector(5 downto 0);
			v_temp_out : out bit_vector(9 downto 0));
end MAIN;

architecture ckt of MAIN is

	component CALC is
		port (	clk : in bit;
				qtde_cx : in bit_vector(5 downto 0);
				est_at : in bit_vector(3 downto 0);
				est_cf : in bit_vector(3 downto 0);
				prox_est_in : in bit_vector(3 downto 0);
				clr : in bit;
				v_temp_out : in bit_vector(9 downto 0);
				valor : in bit_vector(9 downto 0);
				valor_cx : in bit_vector(9 downto 0);
				c_temp : out bit_vector(5 downto 0);
				prox_est_out : out bit_vector(3 downto 0);
				v_temp_in : out bit_vector(9 downto 0);
				enable : out bit);
	end component;

	component MUX4B4S is
		port ( I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, I16 : in bit_vector(3 downto 0);
				S : in bit_vector(3 downto 0);
				Q : out bit_vector(3 downto 0));
	end component;

	component MUX10B3S is
		port ( I1, I2, I3, I4, I5, I6, I7, I8 : in bit_vector(9 downto 0);
				S : in bit_vector(2 downto 0);
				Q : out bit_vector(9 downto 0));
	end component;

	begin

end ckt;