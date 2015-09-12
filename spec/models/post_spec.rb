describe Post do
  it { expect(subject).to have_many(:comments) }
end
