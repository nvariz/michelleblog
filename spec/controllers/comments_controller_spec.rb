describe CommentsController do
  describe '#create' do
    let!(:_post)   { Post.create(title: 'title', body: 'body') }
    let(:subject) { post :create, post_id: _post.id, comment: params }

    context 'with invalid params' do
      let(:params) { { name: '', body: 'bar' } }

      it 'does not redirect to show page' do
        expect(subject).to redirect_to(post_path(_post))
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

  describe '#update' do
    let!(:post)    { Post.create(title: 'title', body: 'body') }
    let!(:comment) { Comment.create(name: 'Fu', body: 'bar', post: post) }
    let!(:subject) do
      put :update, id: comment.id, post_id: post.id, comment: params
    end

    context 'with valid params' do
      let(:params) { { body: 'barfu' } }

      it 'redirects to post show page' do
        expect(subject).to redirect_to(post)
      end

      it 'renders a success flash message' do
        expect(flash[:notice]).to eq('Comment saved successfully')
      end

      it 'updates the comment record' do
        expect(Comment.first.body).to eq(params[:body])
      end
    end

    context 'with invalid params' do
      let(:params) { { body: '' } }

      it 'redirects to post show page' do
        expect(subject).to redirect_to(post)
      end

      it 'renders error flash message' do
        expect(flash[:notice]).to eq("Body can't be blank")
      end
    end
  end
end
