module Valanga
  class MusicAttribute
    IMAGE_TEXT = {
      "/game/reflec/groovin/p/images/music/rank/syousai_1.png" => "B",
      "/game/reflec/groovin/p/images/music/rank/syousai_2.png" => "A",
      "/game/reflec/groovin/p/images/music/rank/syousai_3.png" => "AA",
      "/game/reflec/groovin/p/images/music/rank/syousai_4.png" => "AAA",
      "/game/reflec/groovin/p/images/music/rank/syousai_5.png" => "AAA+",
      "../images/music/fullcombo_img1.gif"                     => "full_combo",
      "../images/music/fullcombo_img2.gif"                     => "all_just_reflec_full_combo",
      "../images/music/d_clear_typ_0.gif"                      => "clear",
      "../images/music/d_clear_typ_1.gif"                      => "hard_clear",
      "../images/music/d_clear_typ_2.gif"                      => "super_hard_clear",
    }

    def initialize(document)
      @document = Nokogiri::HTML.parse(document)
    end

    def collete
      Collete.new(self)
    end

    def groovin
      Groovin.new(self)
    end

    def has_special?
      music_bk.size == 9
    end

    private

    def music_info_box
      @music_info_box ||= music_bk.map do |dl|
        dl.children.select(&:element?).map do |ele|
          value = (img = ele.search('img')).empty? ? ele.text : img.attribute('src').value
          IMAGE_TEXT[value] || value
        end
      end
    end

    def music_bk
      return @music_bk if defined? @music_bk

      music_bk = @document.css("div.music_bk dl")

      unless music_bk.size == 8 || music_bk.size == 9
        raise NoMusicInformationError, "Not found music informations"
      end

      @music_bk = music_bk
    end
  end
end