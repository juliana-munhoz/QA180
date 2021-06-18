describe "GET / equipos/{equipo_id}" do
  before(:all) do
    payload = { email: "tom@gmail.com", password: "123" }
    @user_id = Sessions.new.login(payload).parsed_response["_id"]
  end

  context "find_by_id" do
    # dado que o usuario tenha um novo equipamento
    before(:all) do
      @payload = {
        thumbnail: Helpers::get_thumb("clarinete.jpg"),
        name: "clarinete",
        category: "Outros",
        price: 50,
      }

      MongoDB.new.remove_equipo(@payload[:name], @user_id)

      equipo = Equipos.new.create(@payload, @user_id)
      @equipo_id = equipo.parsed_response["_id"]

      # quando faço uma requisição get por id
      @result = Equipos.new.findById(@equipo_id, @user_id)
    end

    it "deve retornar 200" do
      expect(@result.code).to eql 200
    end

    it "deve retornar o nome" do
      expect(@result.parsed_response).to include("name" => @payload[:name])
    end
  end

  context "equipo nao existe" do
    before(:all) do
      @result = Equipos.new.findById(MongoDB.new.get_mongo_id, @user_id)
    end

    it "deve retornar 404" do
      expect(@result.code).to eql 404
    end
  end
end

describe "GET /equipos" do
  before(:all) do
    payload = { email: "locador@gmail.com", password: "123" }
    @user_id = Sessions.new.login(payload).parsed_response["_id"]
  end

  context "obter uma lista" do
    before(:all) do
      # dado q eu tenho uma lista de equipos
      payloads = [
        {
          thumbnail: Helpers::get_thumb("amp.jpg"),
          name: "amplificador",
          category: "Outros",
          price: 50,
        },
        {
          thumbnail: Helpers::get_thumb("clarinete.jpg"),
          name: "clarinete",
          category: "Outros",
          price: 250,
        },
        {
          thumbnail: Helpers::get_thumb("pedais.jpg"),
          name: "pedais",
          category: "Outros",
          price: 550,
        },
      ]

      payloads.each do |payload|
        MongoDB.new.remove_equipo(payload[:name], @user_id)
        Equipos.new.create(payload, @user_id)
      end

      # quando faço uma rquisição get para /equipos
      @result = Equipos.new.list(@user_id)
    end

    it "deve retornar 200" do
      expect(@result.code).to eql 200
    end

    it "deve retornar uma lista de equipos" do
      expect(@result.parsed_response).not_to be_empty
    end
  end
end
