#include <algorithm>
#include <iostream>
#include <cstring>

#include <unistd.h>

using std::strcmp;
using std::strlen;

struct Args
{

	// Nome do arquivo para criar o arquivo TESTBENCH.vhd para testar os circuitos
	char *make_testbench;

	// Local do arquivo que será criado
	char *path;
} args;

//============PROTOTIPOS==========================
void parseArgs(int &argc, char *argv[]);

//================================================

int main(int argc, char **argv)
{

	parseArgs(argc, argv);

	return 0;
}

//====================FUNÇÕES=====================

/**
 * @brief Verifica e coloca os argumentos passados nas variáveis
 *
 **/
void parseArgs(int &argc, char *argv[])
{
	if (strcmp(argv[1], "-h") == 0 || strcmp(argv[1], "--help") == 0)
	{
		std::cout << "USAGE: ghdl_run [options] ....\n";
		std::cout << '\n';
		std::cout << "-h | --help"
				  << "\t\t\t"
				  << "Mensagem de Ajuda\n";

		std::cout << '\n';
		std::cout << "-T | --Testbench [Nome]"
				  << "\t\t"
				  << "Cria o arquivo TESTBENCH\n";

		std::cout << '\n';
		std::cout << "-p | --path [Diretorio]"
				  << "\t\t"
				  << "Especifica o diretorio para criacao de arquivo\n"
				  << "\t\t\t\t"
				  << "Default: Atual(./)\n";

		return;
	}

	else
	{
		for (short i = 1; i < argc; i += 2)
		{
			if (strcmp(argv[i], "-p") == 0 || strcmp(argv[i], "--path") == 0)
			{
				args.path = new char[strlen(argv[i + 1]) + 1];
				strcpy(args.path, argv[i + 1]);
			}

			if (strcmp(argv[i], "-T") == 0 || strcmp(argv[i], "--Testbench") == 0)
			{
				args.make_testbench = new char[strlen(argv[i + 1]) + 1];
				strcpy(args.make_testbench, argv[i + 1]);
			}
		}

		return;
	}
}
