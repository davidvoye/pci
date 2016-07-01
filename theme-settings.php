<?php
/**
 * @file
 * Customize the Apearance settings page for this theme.
 */

/**
 * Implements hook_form_system_theme_settings_alter().
 */
function wwuzen_next_president_form_system_theme_settings_alter(&$form, &$form_state, $form_id = NULL) {
  // Work-around for a core bug affecting admin themes. See issue #943212.
  if (isset($form_id)) {
    return;
  }
}
