#
# Copyright:: Copyright (c) 2015 Chef Software, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if node['delivery']['change']['stage'] == 'acceptance'
  all_cookbooks.each do |cookbook|
    execute "functional_kitchen_#{cookbook[:name]}" do
      cwd cookbook[:path]
      command "kitchen test"
      environment('PATH' => ENV['PATH'],
                  'KITCHEN_YAML' => ".kitchen.#{node['delivery-truck']['kitchen_driver']}.yml")
      only_if { has_kitchen_tests?(cookbook[:path]) }
    end
  end
end