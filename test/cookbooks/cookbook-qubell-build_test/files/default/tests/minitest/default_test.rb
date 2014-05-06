
require 'minitest/spec'

def assert_include_content(file, content)
  assert File.read(file).include?(content), "Expected file '#{file}' to include the specified content #{content}"
end

describe_recipe 'cookbook-qubell-build::default' do
  it "install maven3 package" do
  case node['platform_family']
    when "debian"
      package("maven3").must_be_installed
      link("/usr/sbin/mvn").must_exist.with(:link_type, :symbolic).and(:to, "/usr/bin/mvn3")
      assert_symlinked_file "/usr/sbin/mvn", "root", "root", 0755
    when "rhel"
      package("apache-maven").must_be_installed
      link("/usr/sbin/mvn").must_exist.with(:link_type, :symbolic).and(:to, "/usr/share/apache-maven/bin/mvn")
      assert_symlinked_file "/usr/sbin/mvn", "root", "root", 0755
  end
end
  it "install java package" do
  case node['platform_family']
    when "debian" 
      package("openjdk-6-jdk").must_be_installed
    when "rhel"
      package("java-1.6.0-openjdk").must_be_installed
    end 
  end
  it "install git package" do
    if node["platform_family"] == 'debian'
      if node["platform_version"] < '12.04'
        package("git-core").must_be_installed
      end
    else
      package("git").must_be_installed
    end
  end
  it "creates build folder" do
      assert_directory "#{node['cookbook-qubell-build']['target']}", "root", "root", "755"
  end
  it "clone app repository to webapp folder" do 
      assert_directory "#{node['cookbook-qubell-build']['dest_path']}/webapp", "root", "root", "755" 
  end  
  it "create target as  array with wars as elements" do
      arr = node['cookbook-qubell-build']['artefacts']
      assert arr.kind_of?(Array)
      assert arr.include?('file:///tmp/mvn/petclinic-1.0.0-SNAPSHOT.war')
  end
  it "create file with git_url" do 
      file("/tmp/gittest").must_exist
      assert_include_content("/tmp/gittest", "#{node['scm']['repository']}?#{node['scm']['revision']}")    
  end
end
