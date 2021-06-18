#language:pt

Funcionalidade: Receber pedido de locação

    Sendo um anúnciante que possui equipamentos cadastrados
    Desejo receber pedidos de locação
    Para que eu possa decidir se quero aprova-los ou rejeita-los

    @receber_pedido
    Cenario: Receber pedido
        Dado que meu perfil de anúnciante é "edmar@anunciante.com" e "123"
            E que eu tenha o seguinte equipamento cadastrado:
            | thumb     | baixo.jpg |
            | nome      | Baixo     |
            | categoria | Cordas    |
            | preco     | 879       |
            E acesso o meu dashboard
        Quando "juliana@locataria.com" e "123" solicita a locação deste equipamento
        Então devo ver a seguinte mensagem: 
        """
        juliana@locataria.com deseja alugar o equipamento: Baixo em: DATA_ATUAL
        """
        E devo ver os links: "ACEITAR" e "REJEITAR" no pedido