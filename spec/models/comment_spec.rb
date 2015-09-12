describe Comment do
  it { expect(subject).to belong_to(:post) }
  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to validate_presence_of(:body) }
end
