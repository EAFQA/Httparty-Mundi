describe "post_token" do
  context "generate token username invalid" do
    let(:result) { ApiToken.save(build(:username_invalid).to_hash) }

    it { expect(result.response.code).to eql "400" }
    it { expect(result.parsed_response["error"]).to eql "4" }
    it { expect(result.parsed_response["error_description"]).to eql "Autorização negada." }
  end

  context "generate token password invalid" do
    let(:result) { ApiToken.save(build(:password_invalid).to_hash) }

    it { expect(result.response.code).to eql "400" }
    it { expect(result.parsed_response["error"]).to eql "4" }
    it { expect(result.parsed_response["error_description"]).to eql "Autorização negada." }
  end

  context "generate token username blank" do
    let(:result) { ApiToken.save(build(:username_blank).to_hash) }

    it { expect(result.response.code).to eql "400" }
    it { expect(result.parsed_response["error"]).to eql "4" }
    it { expect(result.parsed_response["error_description"]).to eql "Autorização negada." }
  end

  context "generate token password blank" do
    let(:result) { ApiToken.save(build(:password_blank).to_hash) }

    it { expect(result.response.code).to eql "400" }
    it { expect(result.parsed_response["error"]).to eql "4" }
    it { expect(result.parsed_response["error_description"]).to eql "Autorização negada." }
  end

  context "generate token grant_type blank" do
    let(:result) { ApiToken.save(build(:grant_type_blank).to_hash) }
    it { expect(result.response.code).to eql "400" }
    it { expect(result.parsed_response["error"]).to eql "unsupported_grant_type" }
  end

  context "generate token" do
    let(:result) { ApiToken.save(build(:new_token).to_hash) }
    it { expect(result.response.code).to eql "200" }
    it { expect(result.parsed_response["token_type"]).to eql "bearer" }
    it { expect(result.parsed_response["expires_in"]).to eql 3599 }
  end
end
