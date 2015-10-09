require File.expand_path '../spec_helper.rb', __FILE__
include SinatraTinyUrlHelpers

describe SinatraTinyUrlHelpers do
  context "get_new_code" do
    let(:length){ 5 }

    subject{ get_new_code( length ) }

    it "returns a String object" do
      subject.should be_a(String)
    end

    it "returns 5 characters" do
      subject.size.should eq(length)
    end

    it "should exclude ambiguous characters" do
      SinatraTinyUrlHelpers::VALID_CHARACTERS.should_not =~ /1|l|I|O|0/
    end
  end

  context "is_valid?" do

    context "with nil code" do
      let(:code){ nil }

      it "returns false" do
        SinatraTinyUrlHelpers.send(:is_valid?, code).should eq(false)
      end
    end

    context "without an invalid word in the code" do
      let(:code){ 'a2tf9uf' }

      it "returns true" do
        SinatraTinyUrlHelpers.send(:is_valid?, code).should eq(true)
      end
    end

    context "with invalid word in the code" do
      let(:code){ 'a2foouf' }

      it "returns false" do
        SinatraTinyUrlHelpers.send(:is_valid?, code).should eq(false)
      end
    end

    context "with an existing code" do
      let(:code){ 'z5Gf9ud' }

      before do
        Redis.new.setnx "links:#{code}", 'http://www.sometesturl.com'
      end

      it "returns false" do
        SinatraTinyUrlHelpers.send(:is_valid?, code).should eq(false)
      end
    end

    context "with similar characters" do
      let(:code){ 'z5Gf9ud' }

      before do
        Redis.new.setnx "links:#{code}", 'http://www.sometesturl.com'
      end

      context "differs by 1 character" do
        it "should return false" do
           SinatraTinyUrlHelpers.send(:is_valid?, 'z5Gf9ue').should eq(false)
        end
      end

      context "differs by 2 character" do
        it "should return true" do
           SinatraTinyUrlHelpers.send(:is_valid?, 'z5Gf9ce').should eq(true)
        end
      end
    end
  end
end