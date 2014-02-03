require 'spec_helper'

describe ApplicationHelper do
  let(:target) { FactoryGirl.create(:folder)}
  let(:item_with_file_true) { FactoryGirl.create(:item, :file => fixture_file_upload('/test.pdf'))}
  let(:item_with_file_false) { FactoryGirl.create(:item, :file => fixture_file_upload('/test.pdf'))}
  let(:target_jpeg) { FactoryGirl.create(:item, :file => fixture_file_upload('/test.jpeg',"image/jpeg"))}
  let(:target_mp3) { FactoryGirl.create(:item, :file => fixture_file_upload('/test.mp3', "audio/mp3"))}
  let(:target_pdf) { FactoryGirl.create(:item, :file => fixture_file_upload('/test.pdf', "application/pdf"))}
  let(:target_exel) { FactoryGirl.create(:item, :file => fixture_file_upload('/test.exel',"application/vnd.ms-excel"))}
  let(:target_sheet) { FactoryGirl.create(:item, :file => fixture_file_upload('/test.xlsx',"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))}
 
  describe 'true pdf' do
    it 'should find file' do 
      expect(helper.pdf(item_with_file_true)).to eq("<a href=\"/items/1/show_pdf\" alt=\"Open PDF\" rel=\"tooltip\" target=\"_blank\" title=\"Open PDF\"><img align=\"bottom\" border=\"0\" class=\"icon \" src=\"/assets/icons/fam-fam/16/page_go.png\" /></a>")
    end
  end
end
