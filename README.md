# Desafio Toro Desenvolvedor Mobile

A descrição original do desafio está disponível [aqui](https://github.com/GabrielRozendo/desafio-toro-mobile/blob/master/README.md)

![GitHub last commit](https://img.shields.io/github/last-commit/GabrielRozendo/desafio-toro-mobile)

[![Codemagic build status](https://api.codemagic.io/apps/5dd6dde7692466744eefe71b/5dd6dde7692466744eefe71a/status_badge.svg)](https://codemagic.io/apps/5dd6dde7692466744eefe71b/5dd6dde7692466744eefe71a/latest_build)

[CodeMagic CI - Resultado do último Build](https://codemagic.io/app/5dd6dde7692466744eefe71b/build/5dd7036729657a000dfda428)

## Problema

Crie um app mobile que exiba em tempo real, de forma organizada e agradável, preços de ações recebidas através de uma conexão websocket.
É preciso exibir pelo menos as 5 ações mais valorizadas e as 5 menos valorizadas em cards contendo o símbolo da ação, o preço atual e um gráfico que ilustre a evolução do preço.
As cotações devem ser recebidas a partir do nosso simulador de cotações que pode ser acessado usando docker com o seguinte comando: docker run -p 8080:8080 toroinvestimentos/quotesmock. O fluxo de cotações está no endpoint /quotes.

## Abordagem da solução

- Utilizando Flutter + BloC
- iOS e Android
- Testes Unitários com 100% de cobertura
- Testes de Widgets/UI não realizado
- Validação se está conectado ao WebSocket assim que abre o App
- App dividido em 3 TabBars:
  1. Todas as ações disponíveis, com a visualização das seguintes informações:
     - CÓDIGO
     - VALOR ATUAL
     - VARIAÇÃO DE VALOR R\$
     - VARIAÇÃO DE PORCENTAGEM %
     - TEMPO RELATIVO DESDE A ÚLTIMA ATUALIZAÇÃO
  2. AS 5 MAIORES ALTAS
  3. AS 5 MAIORES BAIXAS

_Esses dois últimos com informações da ação e um gráfico simples com todas as variações._

- Foi feito vários testes (ficou comentado no código) com outros gráficos mais completos, porém nenhum ficou tão bom quanto esse, além do que, por se tratar de dados com tempo somente da conexão do WebSocket, o gráfico ficaria incompleto se colocasse do dia inteiro.
- Utilização de uma barra no topo flutuante (SliverAppBar) para dar mais espaço à navegação.
- Padronização das cores temas da [Toro Investimentos](https://www.toroinvestimentos.com.br/)
  - Preparado para personalização do tema, com as demais cores
- Utilizando o CodeMagic para CI (conta free, com variação no tempo de build)

### Para executar o projeto

**Requisitos:**

- Ter a versão mínima do Flutter: `Channel stable, v1.9.1+hotfix.6`
- Executar o comando `flutter pub get` para atualizar todas dependências
- Para executar os testes unitários, executar o comando `flutter test`
- Para executar o aplicativo, executar o comando `flutter run`
- Testes realizados com um Android 8.1.0 e iPhone SE e 11 Pro Max na versão 13

**Dependências utilizadas**

- cupertino_icons: ^0.1.2

  - Default

- intl: ^0.15.8

  - Para formatação da moeda R\$
  - Também requisito do chart

- web_socket_channel: ^1.1.0

  - Conexão através de Web Socket

- rxdart: ^0.21.0

  - Recomendado para utilizar juntamente com o BloC

- bloc_pattern: ^1.5.2

  - Padrão BloC Pattern

- flutter_launcher_icons: ^0.7.4

  - Atualização do icone de forma fácil para Android e iPhone ao mesmo tempo

- flutter_sparkline: ^0.1.0
  - Pacote de gráfico que melhor se encaixou nesse projeto

#### Considerações

- O websocket é apenas de simulação e oferece dados bem aleatórios, as vezes não fazem muito sentido.
- As informações da maiores altas e baixas, deveriam estar disponíveis em outro endpoint no servidor, para que conseguisse buscar um histórico do dia inteiro ou de outros períodos.
- Os commits iniciais foram integrados através do git stash, pois muitos commits foram efetuados apenas para migrar de computador (Windows <-> Mac)

##### Screenshots

Relatório da cobertura de testes
<img alt="Code Coverage Report" src="https://github.com/GabrielRozendo/desafio-toro-mobile/raw/developer/screenshots/code_coverage_report.png" />

###### iPhone

<img width="200" alt="iPhone 1 Erro" src="https://github.com/GabrielRozendo/desafio-toro-mobile/raw/developer/screenshots/iPhone/iPhone_1Erro.png" /> <img width="200" alt="iPhone 2 Home" src="https://github.com/GabrielRozendo/desafio-toro-mobile/raw/developer/screenshots/iPhone/iPhone_2Home.png" /> <img width="200" alt="iPhone 3 Home" src="https://github.com/GabrielRozendo/desafio-toro-mobile/raw/developer/screenshots/iPhone/iPhone_3Home.png" />

<img width="200" alt="iPhone 4 Maiores Altas" src="https://github.com/GabrielRozendo/desafio-toro-mobile/raw/developer/screenshots/iPhone/iPhone_4Altas.png" /> <img width="200" alt="iPhone 5 Maiores Altas" src="https://github.com/GabrielRozendo/desafio-toro-mobile/raw/developer/screenshots/iPhone/iPhone_5Altas.png" />

<img width="200" alt="iPhone 6 Maiores Baixas" src="https://github.com/GabrielRozendo/desafio-toro-mobile/raw/developer/screenshots/iPhone/iPhone_6Baixas.png" /> <img width="200" alt="iPhone 6Baixas" src="https://github.com/GabrielRozendo/desafio-toro-mobile/raw/developer/screenshots/iPhone/iPhone_7Baixas.png" />

!["iPhone Demo"](https://github.com/GabrielRozendo/desafio-toro-mobile/raw/developer/screenshots/iPhone/iPhone_demo.gif)

###### Android

<img width="200" alt="Android 1 Loading" src="https://github.com/GabrielRozendo/desafio-toro-mobile/raw/developer/screenshots/Android/Android_1Loading.png" /> <img width="200" alt="Android 2 Home" src="https://github.com/GabrielRozendo/desafio-toro-mobile/raw/developer/screenshots/Android/Android_2Home.png" /> <img width="200" alt="Android 3 Home" src="https://github.com/GabrielRozendo/desafio-toro-mobile/raw/developer/screenshots/Android/Android_3Home.png" />

<img width="200" alt="Android 4 Maiores Altas" src="https://github.com/GabrielRozendo/desafio-toro-mobile/raw/developer/screenshots/Android/Android_4Altas.png" /> <img width="200" alt="Android 5 Maiores Altas" src="https://github.com/GabrielRozendo/desafio-toro-mobile/raw/developer/screenshots/Android/Android_5Altas.png" />

<img width="200" alt="Android 6 Maiores Baixas" src="https://github.com/GabrielRozendo/desafio-toro-mobile/raw/developer/screenshots/Android/Android_6Baixas.png" /> <img width="200" alt="Android 6Baixas" src="https://github.com/GabrielRozendo/desafio-toro-mobile/raw/developer/screenshots/Android/Android_7Baixas.png" />
