require "json"
require "yaml"

ROOT = File.expand_path("..", __dir__)
errors = []
skills = {}

Dir[File.join(ROOT, "skills/**/SKILL.md")].sort.each do |path|
  text = File.read(path)
  frontmatter = text[/\A---\s*\n(.*?)\n---\s*\n/m, 1]
  unless frontmatter
    errors << "missing frontmatter: #{path}"
    next
  end

  begin
    metadata = YAML.safe_load(frontmatter)
  rescue StandardError => e
    errors << "invalid YAML #{path}: #{e.message}"
    next
  end

  slug = File.basename(File.dirname(path))
  errors << "duplicate slug: #{slug}" if skills.key?(slug)
  errors << "name mismatch: #{path}" unless metadata["name"] == slug
  errors << "missing description: #{path}" if metadata["description"].to_s.strip.empty?

  test_path = File.join(File.dirname(path), "test-prompts.json")
  if File.exist?(test_path)
    begin
      suite = JSON.parse(File.read(test_path))
      errors << "test skill mismatch: #{test_path}" unless suite["skill"] == slug
      cases = suite.fetch("test_cases")
      types = cases.map { |test_case| test_case.fetch("type") }
      %w[should_trigger should_not_trigger edge_case].each do |type|
        errors << "missing #{type}: #{test_path}" unless types.include?(type)
      end
    rescue StandardError => e
      errors << "invalid tests #{test_path}: #{e.message}"
    end
  end

  skills[slug] = metadata
end

errors << "no Skills found" if skills.empty?

skills.each do |slug, metadata|
  Array(metadata["related_skills"]).each do |edge|
    target = edge["slug"]
    errors << "dangling related Skill: #{slug} -> #{target}" unless skills.key?(target)
  end
end

Dir[File.join(ROOT, "**/*.md")].each do |path|
  File.read(path).scan(/\[[^\]]*\]\(([^)]+)\)/).flatten.each do |target|
    next if target.match?(%r{\A(?:https?://|mailto:|#)})
    resolved = File.expand_path(target.split("#", 2).first, File.dirname(path))
    errors << "broken link #{path}: #{target}" unless File.exist?(resolved)
  end
end

Dir[File.join(ROOT, "**/*")].select { |path| File.file?(path) }.each do |path|
  next if path.include?("/.git/")
  File.readlines(path).each_with_index do |line, index|
    errors << "local absolute path #{path}:#{index + 1}" if line.include?(Dir.home)
  end
end

if errors.empty?
  puts "REPOSITORY_OK skills=#{skills.size}"
else
  warn errors.join("\n")
  exit 1
end
