
![alt text](https://clickpetroleoegas.com.br/wp-content/uploads/2020/10/Fontes-de-energia-ranovavel-736x490.jpg)
# PowerTrack
---
## TCC Engenharia da Computação - UNINTER
* Aplicação em flutter para medir consumo e apontar soluções  

#### TIPO DE PROJETO:  
SOFTWARE; que nos traz o consumo em media de uma residência em kw por pessoas, picos, e analisando perdas e quantidade de moradores e demonstrando possíveis reduções, CONTRA MEDIDAS PARA GASTAR MENOS, ENERGIA LIMPA. Média de consumo de energia per capita, para saber se gastamos mais que o normal no Brasil, estimar o consumo tendo em vista o uso de energia solar, e eólica nas mesma residência.

* Consumo de energia relacionado ao consumidor  
* CALCULO DE GASTOS; https://mundoeducacao.uol.com.br/matematica/consumo-energia-eletrica.htm  
* Fatores que causam aumento da conta de luz: https://hccenergiasolar.com.br/6-fatores-que-causam-aumento-na-conta-de-luz/

---

# Ideias
[Projeto do figma](https://www.figma.com/file/AbDKwkdldqYcpz7TNqrwTx/Untitled?node-id=0%3A1&t=1Y7qSEVoSF1rwQT6-1) 

Tela de conheça o APP

Tela inicial com botão para novo calculo
novo calculo - cadastro de Região, custo do kw, gasto de energia atual
msg final com equipamento que mais gasta, horário de pico horario com maior gasto.
equipamento gasta tantos RS

menu com cadastrar novos equipamentos, historicos, novo calculo, novo usuário, energias renováveis, como economizar mais energia


## Usuário
#### Conta de Usuário
Vai precisar de:
* Nome
* Email
* Senha

#### Dados do usuário p/ calculos
Dados que vão ser necessários para calcular o **Resultado**
1. Quantos equipamentos eletrônicos tem na casa
2. Quantas pessoas tem na casa

##### Ideia de layout:
Row com campo de texto que da pra pesquisar um item da lista de equipamentos, do lado do item vai ter um botão de +.
Ao clicar no botão de + o item é adicionado e vai ter a opção de selecionar quantidade e tempo de uso por dia, em horas.

A ideia é fazer uma média geral de consumo energético da pessoa

#### Resultado
1. Formas de economizar energia
2. Valor gasto individual e total
3. Mostrar consumo total em Kw/h
4. Gráficos com a economia em R$

#### Melhorias
O que pode ser melhorado:
1. Integração de dispositivos IOT com a API do banco, para atualização de consumo (kWh) e tempo de uso do dispositivo em tempo real ou diário.
2. Adição de gráficos para facilitar a visualização dos dados.
