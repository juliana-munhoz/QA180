describe "POST /equipos{equipo_id}/bookings" do
  before(:all) do
    usuario_locador = Sessions.new.login({ email: "locador@gmail.com", password: "123" })
    @usuario_locador_id = usuario_locador.parsed_response["_id"]
  end

  context "solicitar locacao" do
    before(:all) do

      #dado que usuario A tem um instrumento para locação

      usuario_vendedor = Sessions.new.login({ email: "locatario@gmail.com", password: "123" })
      usuario_vendedor_id = usuario_vendedor.parsed_response["_id"]

      instrumento_para_alugar = {
        thumbnail: Helpers::get_thumb("amp.jpg"),
        name: "Amplificador",
        category: "Outros",
        price: 500,
      }

      MongoDB.new.remove_equipo(instrumento_para_alugar[:name], usuario_vendedor_id)

      instrumento_id = Equipos.new.create(instrumento_para_alugar, usuario_vendedor_id).parsed_response["_id"]

      # quando é solicitada a locação do instrumento

      @result = Equipos.new.booking(instrumento_id, @usuario_locador_id)
    end

    it "deve retornar 200" do
      expect(@result.code).to eql 200
    end
  end
end
