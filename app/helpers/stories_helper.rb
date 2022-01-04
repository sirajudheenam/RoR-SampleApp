module StoriesHelper

  class StoryBook
    Story = Struct.new(:title, :content)
    attr_accessor :story
    def initialize(opts)
      @story = Story.new(opts[:title], opts[:to_addr] )
    end
  end

  def new_story(attributes)
    story = StoryBook.new(attributes)
  end

  def populate_stories(arr)
    story_book_array = []
    arr.each do |story_hash|
      story_book_array.push(new_story(story_hash))
    end
    return story_book_array
  end

  def get_stories
    @stories = [
      {title: "story01", content: "Dolore ipsum duis nulla esse labore ullamco duis."},
      {title: "story02", content: "Non in eu tempor ut excepteur esse enim tempor." },
      {title: "story03", content: "Occaecat ipsum do dolor laboris cillum do ut sint."},
      {title: "story04", content: "Dolore eiusmod cupidatat laboris laborum."},
      {title: "story05", content: "Nulla culpa labore id ullamco pariatur excepteur."},
      {title: "story06", content: "Ipsum magna elit eiusmod et id non."},
      {title: "story07", content: "Ea et labore magna labore consequat dolore."},
      {title: "story08", content: "Irure exercitation adipisicing et amet sint."},
      {title: "story09", content: "Fugiat in exercitation minim tempor culpa."},
      {title: "story10", content: "Irure Lorem consectetur proident proident pariatur."},
      {title: "story11", content: "Labore occaecat elit velit reprehenderit mollit."},
      {title: "story12", content: "minim ipsum occaecat duis cupidatat ipsum labore aliqua."},
      {title: "story13", content: "Velit laboris fugiat aliqua enim eu id adipisicing Lorem."},
      {title: "story14", content: "Labor magna veiam sint cillum proident velit consectetur."},
      {title: "story15", content: "consequat non labore sunt aliquip mollit quis."}, 
      {title: "story16", content: "Lorem irure commodo do veniam consequat qui laborum."},
      {title: "story17", content: "reprehenderit veniam mollit nulla mollit ut deserunt."}, 
      {title: "story18", content: "Est deserunt cillum cillum occaecat aliquip sint tempor."},
      {title: "story19", content: "eu amet duis non. Cillum laboris duis commodo quis."},
      {title: "story20", content: "labore cillum dolore fugiat sint dolore nostrud irure."}
    ]
    return @stories
  end

  def find_story_by_title(title)
    stories = get_stories
    # puts stories
    str = {}
    stories.each do |story|
      if title == story[:title]
        str = story
        return str
      end
    end
  end
  
end