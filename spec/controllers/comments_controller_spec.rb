describe CommentsController do
  describe '#create' do
    let!(:_post)   { Post.create(title: 'title', body: 'body') }
    let(:subject) { post :create, post_id: _post.id, comment: params }

    context 'with invalid params' do
      let(:params) { { name: '', body: 'bar' } }

      it 'does not redirect to show page' do
        expect(subject).to render_template('posts/show')
      end

      it 'renders error flash message' do
        post :create, post_id: _post.id, comment: params

        expect(flash[:notice]).to eq("Name can't be blank")
      end
    end

    context 'with valid params' do
      let(:params) { { name: 'foo', body: 'bar' } }

      it 'redirects to show page' do
        expect(subject).to redirect_to(post_path(_post))
      end

      it 'renders a success flash message' do
        post :create, post_id: _post.id, comment: params

        expect(flash[:notice]).to eq('Comment saved successfully')
      end

      it 'creates a new comment record' do
        expect { subject }.to change { Comment.count }.by(1)
      end
    end
  end
end
