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

  describe 'content_icon valid' do
    it 'should folder' do 
      expect(helper.content_icon(target)).to eq("<img align=\"bottom\" border=\"0\" class=\"icon \" src=\"/assets/icons/fam-fam/16/folder.png\" /> <span class=\"text\">title1</span>")   
    end
    it 'should jpeg' do
      expect(helper.content_icon(target_jpeg)).to eq("<img align=\"bottom\" border=\"0\" class=\"icon \" src=\"/assets/icons/fam-fam/16/picture.png\" /> <span class=\"text\">test.jpeg</span>")
    end
    it 'should target_mp3' do 
      expect(helper.content_icon(target_mp3)).to eq("<img align=\"bottom\" border=\"0\" class=\"icon \" src=\"/assets/icons/fam-fam/16/music.png\" /> <span class=\"text\">test.mp3</span>")
    end
    it 'should target_pdf' do 
      expect(helper.content_icon(target_pdf)).to eq("<img align=\"bottom\" border=\"0\" class=\"icon \" src=\"/assets/icons/fam-fam/16/page_white_acrobat.png\" /> <span class=\"text\">test.pdf</span>")
    end
    it 'should target_exel' do 
      expect(helper.content_icon(target_exel)).to eq("<img align=\"bottom\" border=\"0\" class=\"icon \" src=\"/assets/icons/fam-fam/16/map.png\" /> <span class=\"text\">test.exel</span>")
    end
    it 'should target_sheet' do 
      expect(helper.content_icon(target_sheet)).to eq("<img align=\"bottom\" border=\"0\" class=\"icon \" src=\"/assets/icons/fam-fam/16/page_excel.png\" /> <span class=\"text\">test.xlsx</span>")
    end
    it 'should invalid params' do 
      expect(helper.content_icon(item_with_file_false)).to eq("<img align=\"bottom\" border=\"0\" class=\"icon \" src=\"/assets/icons/fam-fam/16/page.png\" /> <span class=\"text\">test.pdf</span>")
    end
  end

end