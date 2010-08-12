require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "JcheckRails Encoder" do
  context "parsing regexp options" do
    it "should see ignore case option" do
      JcheckRails::Encoder.regex_options_string(/a/i.options).should == "i"
    end
    
    it "should see extended option" do
      JcheckRails::Encoder.regex_options_string(/a/x.options).should == "x"
    end
    
    it "should see multiline option" do
      JcheckRails::Encoder.regex_options_string(/a/m.options).should == "m"
    end
    
    it "should work with combined options" do
      JcheckRails::Encoder.regex_options_string(/a/im.options).should == "im"
    end
  end
  
  context "parsing hashes" do
    it "convert hash keys and values" do
      JcheckRails::Encoder.convert_hash({:key => "value", "other" => "thing"}).should == "{'key': 'value', 'other': 'thing'}"
    end
  end
  
  context "converting values" do
    it "should convert blank hashes to true" do
      JcheckRails::Encoder.convert_to_javascript({}).should == "true"
    end
    
    it "should generate strings with single quotes" do
      JcheckRails::Encoder.convert_to_javascript("some string").should == "'some string'"
    end
    
    it "should generate strings with escaped quotes" do
      JcheckRails::Encoder.convert_to_javascript("it can't happen").should == "'it can\\'t happen'"
    end
    
    it "should convert regular expressions" do
      JcheckRails::Encoder.convert_to_javascript(/^[sS]ome_reg/im).should == "/^[sS]ome_reg/im"
    end
  end
end