require_relative "routes/signup"
require_relative "libs/mongo"

describe "POST /signup" do
  context "novo usuário" do
    before(:all) do
      payload = { name: "Maria", email: "maria@gmail.com", password: "123" }
      MongoDB.new.remove_user(payload[:email])
      @result = Signup.new.create(payload)
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end
    it "valida id do usuário" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  context "usuario existente" do
    before(:all) do
      payload = { name: "Rosa", email: "rosa@yahoo.com", password: "123" }
      MongoDB.new.remove_user(payload[:email])
      Signup.new.create(payload)
      @result = Signup.new.create(payload)
    end

    it "valida status code" do
      expect(@result.code).to eql 409
    end
    it "valida id do usuário" do
      expect(@result.parsed_response["error"]).to eql "Email already exists :("
    end
  end

  examples = [
    {
      title: "nome obrigatorio",
      payload: { name: "", email: "edmar@yahoo.com", password: "123" },
      code: 412,
      error: "required name",
    },
    {
      title: "email obrigatorio",
      payload: { name: "edmar", email: "", password: "123" },
      code: 412,
      error: "required email",
    },
    {
      title: "senha obrigatorio",
      payload: { name: "Edmar", email: "edmar@yahoo.com", password: "" },
      code: 412,
      error: "required password",
    },
    {
      title: "todos obrigatorios",
      payload: { name: "", email: "", password: "" },
      code: 412,
      error: "required name",
    },
  ]

  examples.each do |e|
    context e[:title] do
      before(:all) do
        @result = Signup.new.create(e[:payload])
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
