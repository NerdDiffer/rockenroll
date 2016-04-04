require 'rails_helper'

describe Personable do
  let(:dummy_class) do
    Class.new do
      include Personable

      def self._collection_for_person(foo)
        # no op
      end
    end
  end

  describe '.collection_for_person' do
    context 'when passed an integer' do
      it 'calls _collection_for_person' do
        expect(dummy_class).to receive(:_collection_for_person).with(1)
        dummy_class.collection_for_person(1)
      end
    end

    context 'when NOT passed an integer' do
      it 'returns nil' do
        actual = dummy_class.collection_for_person('foo')
        expect(actual).to be_nil
      end
    end
  end

  describe '.integer?' do
    context 'when passed a Fixnum' do
      it 'returns true' do
        actual = dummy_class.send(:integer?, 1)
        expect(actual).to be_truthy
      end
    end

    context 'when passed anything else' do
      it 'returns false with a string' do
        actual = dummy_class.send(:integer?, 'foo')
        expect(actual).to be_falsey
      end

      it 'returns false with a string that looks like an integer' do
        actual = dummy_class.send(:integer?, '1')
        expect(actual).to be_falsey
      end
    end
  end

  describe '.teacher_id_or_student_id_matches' do
    it 'returns this array' do
      actual = dummy_class.send(:teacher_id_or_student_id_matches, 1)
      expected = ['teacher_id = ? OR student_id = ?', 1, 1]
      expect(actual).to eq expected
    end
  end
end
