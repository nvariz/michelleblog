describe Post do
  it { expect(subject).to have_many(:comments) }
  it { expect(subject).to validate_presence_of(:title) }
  it { expect(subject).to validate_presence_of(:body) }
end
