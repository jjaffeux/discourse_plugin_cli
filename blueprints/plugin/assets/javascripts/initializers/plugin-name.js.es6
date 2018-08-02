import { withPluginApi } from "discourse/lib/plugin-api";

function initialize${CLASSIFIED_PLUGIN_NAME}(api) {
}

export default {
  name: "${DASHERIZED_PLUGIN_NAME}",

  initialize() {
    withPluginApi("0.8.7", initialize${CLASSIFIED_PLUGIN_NAME});
  }
};
