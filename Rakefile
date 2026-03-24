require 'fileutils'

namespace :book do
  desc 'prepare build'
  task :prebuild do
    Dir.mkdir 'images' unless Dir.exist? 'images'
    # 이미지 파일이 있는 경로를 현재 구조에 맞춰 탐색
    Dir.glob("{body,preface,appendix}/**/images/*").each do |image|
      FileUtils.copy(image, "images/" + File.basename(image))
    end
    Dir.mkdir 'publication' unless Dir.exist? 'publication'
  end

  desc 'build basic book formats'
  task :build, [:destination] => :prebuild do |t, args|
    destination_name = args[:destination] || 'book'
    
    # 젬들이 직접 설치된 경로를 사용하기 위해 bundle exec를 제거합니다.
    puts "Converting to HTML..."
    `bundle exec asciidoctor ./book.adoc -o ./publication/#{destination_name}.html`
    puts " -- HTML output:: ./publication/#{destination_name}.html"

    puts "converting to DOCX... (this one takes a while)"
    if system("command -v pandoc > /dev/null")
      `pandoc -s ./publication/#{destination_name}.html -o ./publication/#{destination_name}.docx`
      puts " -- DOCX  output:: ./publication/#{destination_name}.docx"
    else
      puts " -- Skipping DOCX (pandoc not found)"
    end

    puts "Converting to PDF... (this one takes a while)"
    `bundle exec asciidoctor-pdf -a pdf-theme=./pdf-theme.yml -a pdf-fontsdir=./fonts -a scripts=cjk ./book.adoc -o ./publication/#{destination_name}.pdf`
    puts " -- PDF  output:: ./publication/#{destination_name}.pdf"

    puts "Converting to EPUB... (this one takes a while)"
    # asciidoctor-epub3 2.x removed bundled CJK fonts; e-readers handle Korean natively
    `bundle exec asciidoctor-epub3 -a scripts! ./book.adoc -o ./publication/#{destination_name}.epub`
    puts " -- EPUB  output at ./publication/#{destination_name}.epub"
  end
end

task :default => "book:build"
