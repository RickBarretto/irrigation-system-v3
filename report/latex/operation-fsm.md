## Variáveis: (4)
* Esvaziando: estado da FSM principal
* Pulso Adubação: Um pulso que dura um certo tempo, permitindo a adubação
* Nível Vazio: Quando o contador da caixa chegar a 0
* Condição de Limpeza: Quando o registrador de adubação estiver ativo e o nível no crítico


## Estados: (4)
* Espera: O sistema de irrigação está em modo espera
* Aspersão: Ativa o esvaziamento da caixa e altera o aumenta clock do contador
* Gotejamento: Ativa o esvaziamento da caixa e diminui o clock do contador
* Limpeza: Esvazia a caixa e desliga o registrador de adubação