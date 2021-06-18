#language: pt

Funcionalidade: Remover Anúncios
    Sendo um anúnciante que possui um equipamento à Remover
    Quero poder remover esse anúncio
    Para que eu possa manter o meu Dashboard atualizado


    Contexto: Login
        * Login com "miriam@gmail.com" e "123"

    
    Cenario: Remover um anuncio

        Dado que eu tenho um anúncio à remover:
            | thumb     | trompete.jpg |
            | nome      | trompete     |
            | categoria | Outros       |
            | preco     | 150          |
        Quando eu solicito a remoção desse anúncio
            E confirmo a remoção
        Então o item não deve ser exibido no Dashboard

    @anuncio
    Cenario: Desistir da remocao

        Dado que eu tenho um anúncio à remover:
            | thumb     | trompete.jpg |
            | nome      | trompete     |
            | categoria | Sopro        |
            | preco     | 150          |
        Quando eu solicito a remoção desse anúncio
            E não confirmo a remoção
        Então este item deve permanecer no Dashboard