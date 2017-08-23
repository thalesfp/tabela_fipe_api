# Tabela Fipe API

API não oficial para acesso aos dados da tabela Fipe escrita em Ruby utilizando o framework Grape.

URL: https://tabela-fipe-api.herokuapp.com/v1

## Endpoints

| URL | Função | Parâmetros |
|---|---|---|
| GET /referencias | Retorna os meses de referência |  |
| GET /:tipo_veiculo/marcas | Retorna as marcas dos veículos | tipo_veiculo, referencia |
| GET /:tipo_veiculo/marcas/:marca/modelos | Retorna os modelos da marca | tipo_veiculo, referencia |
| GET /:tipo_veiculo/marcas/:marca/modelos/:modelo/ano_modelos | Retorna os ano modelos de um modelo | tipo_veiculo, referencia |
| GET /:tipo_veiculo/marcas/:marca/modelos/:modelo/ano_modelos/:ano_modelo | Retorna informações sobre o ano modelo | tipo_veiculo, referencia |

## Parâmetros
| Nome | Descrição | Valores | Obrigatório |
|---|---|---|---|
| tipo_veiculo | Tipo de veículo | carros ou motos | Sim |
| referencia | Mês e ano de referência | inteiro | Não |

## Exemplo de requisição

GET https://tabela-fipe-api.herokuapp.com/v1/carros/marcas/6/modelos/44/ano_modelos/1995-1?referencia=216

```json
{
    "Valor": "R$ 16.728,00",
    "Marca": "Audi",
    "Modelo": "100 2.8 V6 Avant",
    "AnoModelo": 1995,
    "Combustivel": "Gasolina",
    "CodigoFipe": "008076-4",
    "MesReferencia": "agosto de 2017 ",
    "Autenticacao": "jngjhdzs8tc",
    "TipoVeiculo": 1,
    "SiglaCombustivel": "G",
    "DataConsulta": "quarta-feira, 23 de agosto de 2017 18:45"
}
```

## Atenção

Essa API não grava nenhuma informação da tabela Fipe, servindo apenas de proxy para acessar as informações. Para mais informações favor acessar o site oficial da [FIPE](http://veiculos.fipe.org.br/).
