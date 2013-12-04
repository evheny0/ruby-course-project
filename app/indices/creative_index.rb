ThinkingSphinx::Index.define :creative, :with => :active_record do
  indexes title
  indexes description
  indexes chapters.content, :as => :chapter_content
  indexes tags.value, :as => :creative_tag
end
