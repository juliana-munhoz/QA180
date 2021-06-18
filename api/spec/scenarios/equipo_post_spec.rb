describe "POST /equipos" do
  before(:all) do
    payload = { email: "tom@gmail.com", password: "123" }
    @user_id = Sessions.new.login(payload).parsed_response["_id"]
  end

  context "novo equipo" do
    before(:all) do
      payload = {
        thumbnail: Helpers::get_thumb("kramer.jpg"),
        name: "Kramer Eddie Van Halen",
        category: "Cordas",
        price: 299,
      }

      MongoDB.new.remove_equipo(payload[:name], @user_id)

      @result = Equipos.new.create(payload, @user_id)
    end
    it "deve retornar 200" do
      expect(@result.code).to eql 200
    end
  end

  context "nao autorizado" do
    before(:all) do
      payload = {
        thumbnail: Helpers::get_thumb("kramer.jpg"),
        name: "Contra Baixo",
        category: "Cordas",
        price: 489,
      }

      @result = Equipos.new.create(payload, nil)
    end
    it "deve retornar 401" do
      expect(@result.code).to eql 401
    end
  end

  # examples = [
  #   {
  #     title: "nome obrigatorio",
  #     payload: { name: "", email: "edmar@yahoo.com", password: "123" },
  #     code: 412,
  #     error: "required name",
  #   },
  #   {
  #     title: "email obrigatorio",
  #     payload: { name: "edmar", email: "", password: "123" },
  #     code: 412,
  #     error: "required email",
  #   },
  #   {
  #     title: "senha obrigatorio",
  #     payload: { name: "Edmar", email: "edmar@yahoo.com", password: "" },
  #     code: 412,
  #     error: "required password",
  #   },
  #   {
  #     title: "todos obrigatorios",
  #     payload: { name: "", email: "", password: "" },
  #     code: 412,
  #     error: "required name",
  #   },
  # ]

  # examples.each do |e|
  #   context e[:title] do
  #     before(:all) do
  #       @result = Signup.new.create(e[:payload])
  #     end

  #     it "valida status code #{e[:code]}" do
  #       expect(@result.code).to eql e[:code]
  #     end

  #     it "valida mensagem" do
  #       expect(@result.parsed_response["error"]).to eql e[:error]
  #     end
  #   end
  # end
  #end
end
