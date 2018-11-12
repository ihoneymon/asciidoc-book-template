namespace :book do
  desc 'prepare build'
  task :prebuild do   
    Dir.mkdir 'images' unless Dir.exists? 'images'
    Dir.glob("book/*/images/*").each do |image|
      FileUtils.copy(image, "images/" + File.basename(image))
    end
    Dir.mkdir 'publication' unless Dir.exist? 'publication'
  end

  desc 'build basic book formats'
  task :build, [:destination] => :prebuild do |t, args|
    destination_name = args[:destination]
    puts "Converting to HTML..."
    `bundle exec asciidoctor ./book/book.asc -o ./publication/#{destination_name}.html`
    puts " -- HTML output:: ./publication/#{destination_name}.html"

    puts "converting to DOCX... (this one takes a while)"
    `pandoc -s ./publication/#{destination_name}.html -o ./publication/#{destination_name}.docx`
    puts " -- DOCX  output:: ./publication/#{destination_name}.docx"

    puts "Converting to PDF... (this one takes a while)"
    `bundle exec asciidoctor-pdf -r asciidoctor-pdf-cjk-kai_gen_gothic -a pdf-style=KaiGenGothicKR ./book/book.asc -o ./publication/#{destination_name}.pdf`
    puts " -- PDF  output:: ./publication/#{destination_name}.pdf"

    puts "Converting to EPUB... (this one takes a while)"
    `bundle exec asciidoctor -d book -b docbook5 ./book/book.adoc -o ./publication/#{destination_name}.docbook`
    `pandoc -f docbook -t epub ./publication/#{destination_name}.docbook -o ./publication/#{destination_name}.epub`
    puts " -- EPUB  output at ./publication/#{destination_name}.epub"

  end

end

task :default => "book:build"
