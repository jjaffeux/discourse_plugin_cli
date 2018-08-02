# name: ${PLUGIN_NAME}
# about:
# version: 0.1
# authors:
# url: https://github.com/

${IF_STYLESHEET}register_asset "stylesheets/common/${DASHERIZED_PLUGIN_NAME}.scss"${END_IF}

enabled_site_setting :${PLUGIN_NAME}_enabled

PLUGIN_NAME ||= "${PLUGIN_NAME}".freeze

after_initialize do
  module ::${CLASSIFIED_PLUGIN_NAME}
    class Engine < ::Rails::Engine
      engine_name PLUGIN_NAME
      isolate_namespace ${CLASSIFIED_PLUGIN_NAME}
    end
  end

  ${IF_JOB}require File.expand_path("../jobs/scheduled/check_${PLUGIN_NAME}.rb", __FILE__)${END_IF}
end
