entity CALC is
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
end CALC;

architecture ckt of CALC is

	component ADD6 is
		port (A, B : in bit_vector(5 downto 0);
				Ci : in bit;
				Co : out bit;
				S : out bit_vector(5 downto 0));
	end component;

	component ADD10 is
		port (A, B : in bit_vector(9 downto 0);
				Ci : in bit;
				Co : out bit;
				S : out bit_vector(9 downto 0));
	end component;

	component SUB6 is
		port (A, B : in bit_vector(5 downto 0);
				Ti : in bit;
				Tout : out bit;
				S : out bit_vector(5 downto 0));
	end component;

	component SUB10 is
		port (A, B : in bit_vector(9 downto 0);
				Ti : in bit;
				Tout : out bit;
				S : out bit_vector(9 downto 0));
	end component;

	component MUX6B is
		port (	I1, I2 : in bit_vector(5 downto 0);
				S : in bit;
				Q : out bit_vector(5 downto 0));
	end component;

	component MUX10B is
		port (	I1, I2 : in bit_vector(9 downto 0);
				S : in bit;
				Q : out bit_vector(9 downto 0));
	end component;

	component MUX4B2S is
		port ( I1, I2, I3, I4 : in bit_vector(3 downto 0);
				S : in bit_vector(1 downto 0);
				Q : out bit_vector(3 downto 0));
	end component;

	component MEM6 is
		port (	Y : in bit_vector(5 downto 0);
				clk, clr, en : in bit;
				Q : out bit_vector(5 downto 0));
	end component;

	component COMP10B is
		port (A, B : in bit_vector(9 downto 0);
				AigB, AmaiorB, AmenorB : out bit);
	end component;

	component COMP6B is
		port (A, B : in bit_vector(5 downto 0);
				AigB, AmaiorB, AmenorB : out bit);
	end component;

	signal aux_est_at : bit_vector(3 downto 0);
	signal aux_est_cf : bit_vector(3 downto 0);

	signal en_mem6 : bit;
	signal out_mem6 : bit_vector(5 downto 0);

	signal maior6, menor6, igual6 : bit;
	signal maior10, menor10, igual10 : bit;

	signal result_soma6 : bit_vector(5 downto 0);
	signal result_sub6 : bit_vector(5 downto 0);

	signal result_soma10 : bit_vector(9 downto 0);
	signal result_sub10 : bit_vector(9 downto 0);

	signal Sa, Sb, Sc : bit;
	signal S_MUX4B2S : bit_vector(1 downto 0);

	signal out_mux6sub : bit_vector(5 downto 0);
	signal out_mux6_soma_sub : bit_vector(5 downto 0);

	signal out_mux10_sub : bit_vector(9 downto 0);

	begin
		en_mem6 <= (est_at(0) xnor est_cf(0)) 
				   and (est_at(1) xnor est_cf(1))
				   and (est_at(2) xnor est_cf(2))
				   and (est_at(3) xnor est_cf(3));
				
		Sa <= igual6;
		Sb <= maior10;
		Sc <= igual10;

		S_MUX4B2S(0) <= Sb;
		S_MUX4B2S(1) <= Sa or (not Sb and not Sc);


		COMP10 : COMP10B port map(valor, v_temp_out, igual10, maior10, menor10);
		COMP6 : COMP6B port map (out_mem6 , qtde_cx, maior6, menor6, igual6);

		SOMA6 : ADD6 port map (out_mem6 , "000001", '0', S=>result_soma6);
		SUBT6 : SUB6 port map (out_mem6, "000001", '0', S=>result_sub6);
		MUX6SUB : MUX6B port map (out_mem6, result_sub6, maior10, out_mux6sub);
		MUX6_SOMA_SUB : MUX6B port map (result_soma6, out_mux6sub, maior10, out_mux6_soma_sub);
		Quant_CX_TEMP : MEM6 port map (out_mux6_soma_sub, clk, clr, en_mem6, out_mem6);

		SOMA10 : ADD10 port map (v_temp_out, valor_cx, '0', S=>result_soma10);
		SUBT10 : SUB10 port map (v_temp_out, valor_cx, '0',S=>result_sub10);
		MUX10SUB : MUX10B port map (v_temp_out, result_sub10, maior10, out_mux10_sub);
		MUX10_SOMA_SUB : MUX10B port map (result_soma10, out_mux10_sub, maior10, v_temp_in);
				   
		
		--Saidas dos sistemas
		enable <= en_mem6 and menor6;
		c_temp <= out_mux6_soma_sub;
		MUX_PROX_EST : MUX4B2S port map (est_cf, prox_est_in, "1000", est_cf, S_MUX4B2S, prox_est_out);



end ckt;