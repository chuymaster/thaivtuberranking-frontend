// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app__site_title => 'Thai VTubers (Virtual Youtubers) Directory';

  @override
  String get common_type_full_vtuber => 'Original VTuber';

  @override
  String get common_type_all_vtuber => 'All VTuber';

  @override
  String get admin__title => '我が名はめぐみん！';

  @override
  String navigation_menu_info_last_updated_at(Object lastUpdatedAt) {
    return 'Last updated: $lastUpdatedAt';
  }

  @override
  String navigation_menu_info_site_title(Object appEnvironment) {
    return '${appEnvironment}Thai VTubers Directory';
  }

  @override
  String get navigation_menu_info_site_description =>
      'Find your favorite Thai VTubers!';

  @override
  String get navigation_menu_menu_title => 'Menu';

  @override
  String get navigation_menu_menu_add_new_channel => 'Submit new channel';

  @override
  String get navigation_menu_menu_report_problems =>
      'Report Problems / Suggest Features';

  @override
  String get navigation_menu_menu_deletion_criterias =>
      'Automatic Channel Deletion Criterias';

  @override
  String get navigation_menu_menu_disclaimer => 'Disclaimer';

  @override
  String get navigation_menu_menu_discover_thai_vtuber =>
      'Discover Thai VTubers Info';

  @override
  String get navigation_menu_menu_for_developers => 'For Developers';

  @override
  String get navigation_menu_menu_api_document => 'API Document';

  @override
  String get navigation_menu_menu_client_app_repo => 'Client App Repository';

  @override
  String get navigation_menu_menu_release_notes => 'Release Notes';

  @override
  String get navigation_menu_menu_developer_blog => 'Developer Blog';

  @override
  String get announcement_text_delete_channel =>
      'Announcement regarding channel delete';

  @override
  String get common_alert_error => 'Error';

  @override
  String get common_button_close => 'Close';

  @override
  String get banner_text_reality => 'REALITY - Become an Anime Avatar';

  @override
  String get banner_description_reality =>
      'Transform yourself and live like a VTuber!';

  @override
  String get common_button_reload => 'Reload';

  @override
  String get channel_button_copy_url => 'Copy the URL of this page';

  @override
  String get channel_toast_copied_url => 'Copied URL';

  @override
  String get channel_graph_description => 'Graph';

  @override
  String get channel_description_empty => 'No description';

  @override
  String channel_info_subscribers_views(Object subscribers, Object views) {
    return 'Subscribers: $subscribers\nViews: $views';
  }

  @override
  String channel_info_updated_published(Object published, Object updated) {
    return 'Latest video: $updated\nChannel published: $published';
  }

  @override
  String get channel_info_api => 'API';

  @override
  String get channel_registration_complete_text_title => 'Channel submitted';

  @override
  String get channel_registration_complete_text_description =>
      'Thank you for submitting the channel. We will add it to the channel database after verification.';

  @override
  String get channel_registration_complete_button_home => 'Back to home';

  @override
  String get channel_registration_text_title => 'Submit new VTuber channel';

  @override
  String get channel_registration_text_input_channel =>
      'Enter the channel ID, started with UC';

  @override
  String get channel_registration_text_select_channel_type =>
      'Select the channel type';

  @override
  String get channel_registration_text_check_before_submit =>
      'Please check the channel info again before submitting.';

  @override
  String get channel_registration_button_submit => 'Submit';

  @override
  String get channel_registration_error_id_required => 'Enter channel ID';

  @override
  String get channel_registration_error_not_begin_with_uc =>
      'Channel ID must start with UC';

  @override
  String channel_registration_error_length_mismatched(Object channelIdLength) {
    return 'Channel ID must be $channelIdLength characters long';
  }

  @override
  String get channel_registration_error_already_existed =>
      'This channel is already in the database';

  @override
  String get channel_registration_error_unknown =>
      'There was a problem submitting data, please try again later';

  @override
  String get channel_registration_title_id_explanation =>
      'What is a Channel ID?';

  @override
  String get channel_registration_title_type_explanation =>
      'Types of channels allowed:';

  @override
  String get channel_registration_text_full_vtuber_explanation =>
      '- Channels primarily featuring VTuber models (Live2D or 3D) from the first content and having a VTuber model as the main character of the content';

  @override
  String get channel_registration_text_all_vtuber_explanation =>
      '- Channels that primarily feature VTuber models after having other contents for a period of time. These channels will only appear in the \'All VTubers\' category.';

  @override
  String get channel_registration_text_type_explanation =>
      'In both cases, the channels must be created by Thais, primarily targeting Thai audiences, and have uploaded some contents.';

  @override
  String get channel_registration_text_id_explanation_1 =>
      'Channel ID is the code following the URL of the channel, such as https://www.youtube.com/channel/';

  @override
  String get channel_registration_text_id_explanation_2 =>
      'You can check the channel ID from this site.';

  @override
  String get home_title_channel_list => 'List of Thai VTuber channels';

  @override
  String get home_title_video_list => 'List of Thai VTuber videos';

  @override
  String get home_tab_channel => 'Channels';

  @override
  String get home_tab_video => 'Videos';

  @override
  String get home_tooltip_add_channel => 'Submit new VTuber channel';

  @override
  String get navigation_menu_text_language => 'Site Language';

  @override
  String get navigation_menu_text_channel_type => 'Channel Type';

  @override
  String get navigation_menu_text_original_description =>
      'Original VTuber\' refers to a channel that debuted and has been creating content as a VTuber from the beginning, rather than transitioning from other types of content.';

  @override
  String get navigation_menu_text_active_type => 'Activity Type';

  @override
  String get navigation_menu_text_active_type_explanation =>
      'Channels that have not uploaded a video for over 90 days are classified as inactive.';

  @override
  String get navigation_menu_radio_box_active_only => 'Active channels';

  @override
  String get navigation_menu_radio_box_active_and_inactive =>
      'Active and inactive channels';

  @override
  String home_tooltip_display_only_channel(Object channelActivityType) {
    return 'Displaying only $channelActivityType';
  }

  @override
  String home_tooltip_display_channel(Object channelActivityType) {
    return 'Displaying $channelActivityType';
  }

  @override
  String get search_bar_placeholder => 'Search for channel';

  @override
  String get search_text_input_prompt => 'Enter the name of the channel';

  @override
  String get search_text_not_found => 'No results found';

  @override
  String channel_list_text_subscribers(Object subscribers) {
    return '$subscribers subscribers';
  }

  @override
  String channel_list_text_views(Object views) {
    return '$views views';
  }

  @override
  String channel_list_text_updated_published(Object published, Object updated) {
    return 'Latest video $updated\nChannel opened on $published';
  }

  @override
  String get video_list_text_not_found => 'No videos';

  @override
  String video_list_text_live_start(Object liveStart) {
    return 'Scheduled $liveStart';
  }

  @override
  String video_list_text_concurrent_view(Object concurrentView) {
    return 'Concurrent View: $concurrentView people';
  }

  @override
  String video_list_text_views_published(Object publishedAt, Object views) {
    return '$views views | $publishedAt';
  }

  @override
  String video_list_text_number(Object displayRank, Object title) {
    return '$displayRank. $title';
  }

  @override
  String get channel_list_tab_subscribers => 'Subscribers';

  @override
  String get channel_list_tab_views => 'Views';

  @override
  String get channel_list_tab_published => 'Published';

  @override
  String channel_list_text_rank(Object displayRank, Object title) {
    return 'Rank $displayRank $title';
  }

  @override
  String get video_list_tab_live => 'Live';

  @override
  String get video_list_tab_one_day => '24 hours';

  @override
  String get video_list_tab_three_days => '3 days';

  @override
  String get video_list_tab_seven_days => '7 days';

  @override
  String get error_empty_channel_description =>
      'Unable to display information.\nPlease check your internet connection,\nor notify the developer to correct the issue';

  @override
  String get error_empty_channel_contact => 'Contact @chuymaster';

  @override
  String error_not_found_description(Object route) {
    return 'Page not found ($route). Please check the URL again.';
  }

  @override
  String get error_not_found_title => 'Not Found!';

  @override
  String get error_lokalise => 'Lokalise!!';
}
