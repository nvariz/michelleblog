describe Comment do
  it { expect(subject).to belong_to(:post) }
end
