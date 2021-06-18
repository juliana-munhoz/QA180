describe "POST /sessions" do
  context "login com sucesso" do
    before(:all) do
      payload = { email: "juliana@gmail.com", password: "123" }
      @result = Sessions.new.login(payload)
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end

    it "valida id do usuario" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  #   examples = [
  #     {
  #       title: "senha invalida",
  #       payload: { email: "juliana@yahoo.com", password: "1234" },
  #       code: 401,
  #       error: "Unauthorized",
  #     },
  #     {
  #       title: "senha vazia",
  #       payload: { email: "juliana@yahoo.com", password: "" },
  #       code: 412,
  #       error: "required password",

  #     },
  #     {
  #       title: "senha e email vazios",
  #       payload: { email: "", password: "" },
  #       code: 412,
  #       error: "required email",

  #     },
  #     {
  #       title: "email vazio",
  #       payload: { email: "", password: "123" },
  #       code: 412,
  #       error: "required email",

  #     },
  #     {
  #       title: "usuario invalido",
  #       payload: { email: "X@yahoo.com", password: "123" },
  #       code: 401,
  #       error: "Unauthorized",

  #     },
  #   ]

  examples = Helpers::get_fixture("login")

  examples.each do |e|
    context e[:title] do
      before(:all) do
        @result = Sessions.new.login(e[:payload])
      end

      it "valida status code #{e[:code]}" do
        expect(@result.code).to eql e[:code]
      end

      it "valida mensagem" do
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end
end
