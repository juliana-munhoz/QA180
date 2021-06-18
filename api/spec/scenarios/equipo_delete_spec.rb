describe "DELETE /equipos{equipo_id}" do
  before(:all) do
    payload = { email: "tom@gmail.com", password: "123" }
    @user_id = Sessions.new.login(payload).parsed_response["_id"]
  end

  context "delete_by_id" do
    #dado que o usuario tenha um equipamento cadastrado
    before(:all) do
      @payload = {
        thumbnail: Helpers::get_thumb("telecaster.jpg"),
        name: "tele",
        category: "Outros",
        price: 100,
      }

      MongoDB.new.remove_equipo(@payload[:name], @user_id)

      # e que eu tenha o id od equipamento
      new_equipo = Equipos.new.create(@payload, @user_id)
      @equipo_id = new_equipo.parsed_response["_id"]

      #quando eu faço uma requisicao delete por id
      @result = Equipos.new.deleteById(@equipo_id, @user_id)
    end

    it "deve retornar 204" do
      expect(@result.code).to eql 204
    end
  end

  context "equipo nao existe" do
    before(:all) do
      @result = Equipos.new.deleteById(MongoDB.new.get_mongo_id, @user_id)
    end

    it "deve retornar 204" do
      expect(@result.code).to eql 204
    end
  end
end
