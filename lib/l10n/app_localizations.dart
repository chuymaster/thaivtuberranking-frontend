import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_th.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
    Locale('th')
  ];

  /// No description provided for @app__site_title.
  ///
  /// In en, this message translates to:
  /// **'Thai VTubers (Virtual Youtubers) Directory'**
  String get app__site_title;

  /// No description provided for @common_type_full_vtuber.
  ///
  /// In en, this message translates to:
  /// **'Original VTuber'**
  String get common_type_full_vtuber;

  /// No description provided for @common_type_all_vtuber.
  ///
  /// In en, this message translates to:
  /// **'All VTuber'**
  String get common_type_all_vtuber;

  /// No description provided for @admin__title.
  ///
  /// In en, this message translates to:
  /// **'我が名はめぐみん！'**
  String get admin__title;

  /// No description provided for @navigation_menu_info_last_updated_at.
  ///
  /// In en, this message translates to:
  /// **'Last updated: {lastUpdatedAt}'**
  String navigation_menu_info_last_updated_at(Object lastUpdatedAt);

  /// No description provided for @navigation_menu_info_site_title.
  ///
  /// In en, this message translates to:
  /// **'{appEnvironment}Thai VTubers Directory'**
  String navigation_menu_info_site_title(Object appEnvironment);

  /// No description provided for @navigation_menu_info_site_description.
  ///
  /// In en, this message translates to:
  /// **'Find your favorite Thai VTubers!'**
  String get navigation_menu_info_site_description;

  /// No description provided for @navigation_menu_menu_title.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get navigation_menu_menu_title;

  /// No description provided for @navigation_menu_menu_add_new_channel.
  ///
  /// In en, this message translates to:
  /// **'Submit new channel'**
  String get navigation_menu_menu_add_new_channel;

  /// No description provided for @navigation_menu_menu_report_problems.
  ///
  /// In en, this message translates to:
  /// **'Report Problems / Suggest Features'**
  String get navigation_menu_menu_report_problems;

  /// No description provided for @navigation_menu_menu_deletion_criterias.
  ///
  /// In en, this message translates to:
  /// **'Automatic Channel Deletion Criterias'**
  String get navigation_menu_menu_deletion_criterias;

  /// No description provided for @navigation_menu_menu_disclaimer.
  ///
  /// In en, this message translates to:
  /// **'Disclaimer'**
  String get navigation_menu_menu_disclaimer;

  /// No description provided for @navigation_menu_menu_discover_thai_vtuber.
  ///
  /// In en, this message translates to:
  /// **'Discover Thai VTubers Info'**
  String get navigation_menu_menu_discover_thai_vtuber;

  /// No description provided for @navigation_menu_menu_for_developers.
  ///
  /// In en, this message translates to:
  /// **'For Developers'**
  String get navigation_menu_menu_for_developers;

  /// No description provided for @navigation_menu_menu_api_document.
  ///
  /// In en, this message translates to:
  /// **'API Document'**
  String get navigation_menu_menu_api_document;

  /// No description provided for @navigation_menu_menu_client_app_repo.
  ///
  /// In en, this message translates to:
  /// **'Client App Repository'**
  String get navigation_menu_menu_client_app_repo;

  /// No description provided for @navigation_menu_menu_release_notes.
  ///
  /// In en, this message translates to:
  /// **'Release Notes'**
  String get navigation_menu_menu_release_notes;

  /// No description provided for @navigation_menu_menu_developer_blog.
  ///
  /// In en, this message translates to:
  /// **'Developer Blog'**
  String get navigation_menu_menu_developer_blog;

  /// No description provided for @announcement_text_delete_channel.
  ///
  /// In en, this message translates to:
  /// **'Announcement regarding channel delete'**
  String get announcement_text_delete_channel;

  /// No description provided for @common_alert_error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get common_alert_error;

  /// No description provided for @common_button_close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get common_button_close;

  /// No description provided for @banner_text_reality.
  ///
  /// In en, this message translates to:
  /// **'REALITY - Become an Anime Avatar'**
  String get banner_text_reality;

  /// No description provided for @banner_description_reality.
  ///
  /// In en, this message translates to:
  /// **'Transform yourself and live like a VTuber!'**
  String get banner_description_reality;

  /// No description provided for @common_button_reload.
  ///
  /// In en, this message translates to:
  /// **'Reload'**
  String get common_button_reload;

  /// No description provided for @channel_button_copy_url.
  ///
  /// In en, this message translates to:
  /// **'Copy the URL of this page'**
  String get channel_button_copy_url;

  /// No description provided for @channel_toast_copied_url.
  ///
  /// In en, this message translates to:
  /// **'Copied URL'**
  String get channel_toast_copied_url;

  /// No description provided for @channel_graph_description.
  ///
  /// In en, this message translates to:
  /// **'Graph'**
  String get channel_graph_description;

  /// No description provided for @channel_description_empty.
  ///
  /// In en, this message translates to:
  /// **'No description'**
  String get channel_description_empty;

  /// No description provided for @channel_info_subscribers_views.
  ///
  /// In en, this message translates to:
  /// **'Subscribers: {subscribers}\nViews: {views}'**
  String channel_info_subscribers_views(Object subscribers, Object views);

  /// No description provided for @channel_info_updated_published.
  ///
  /// In en, this message translates to:
  /// **'Latest video: {updated}\nChannel published: {published}'**
  String channel_info_updated_published(Object published, Object updated);

  /// No description provided for @channel_info_api.
  ///
  /// In en, this message translates to:
  /// **'API'**
  String get channel_info_api;

  /// No description provided for @channel_registration_complete_text_title.
  ///
  /// In en, this message translates to:
  /// **'Channel submitted'**
  String get channel_registration_complete_text_title;

  /// No description provided for @channel_registration_complete_text_description.
  ///
  /// In en, this message translates to:
  /// **'Thank you for submitting the channel. We will add it to the channel database after verification.'**
  String get channel_registration_complete_text_description;

  /// No description provided for @channel_registration_complete_button_home.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get channel_registration_complete_button_home;

  /// No description provided for @channel_registration_text_title.
  ///
  /// In en, this message translates to:
  /// **'Submit new VTuber channel'**
  String get channel_registration_text_title;

  /// No description provided for @channel_registration_text_input_channel.
  ///
  /// In en, this message translates to:
  /// **'Enter the channel ID, started with UC'**
  String get channel_registration_text_input_channel;

  /// No description provided for @channel_registration_text_select_channel_type.
  ///
  /// In en, this message translates to:
  /// **'Select the channel type'**
  String get channel_registration_text_select_channel_type;

  /// No description provided for @channel_registration_text_check_before_submit.
  ///
  /// In en, this message translates to:
  /// **'Please check the channel info again before submitting.'**
  String get channel_registration_text_check_before_submit;

  /// No description provided for @channel_registration_button_submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get channel_registration_button_submit;

  /// No description provided for @channel_registration_error_id_required.
  ///
  /// In en, this message translates to:
  /// **'Enter channel ID'**
  String get channel_registration_error_id_required;

  /// No description provided for @channel_registration_error_not_begin_with_uc.
  ///
  /// In en, this message translates to:
  /// **'Channel ID must start with UC'**
  String get channel_registration_error_not_begin_with_uc;

  /// No description provided for @channel_registration_error_length_mismatched.
  ///
  /// In en, this message translates to:
  /// **'Channel ID must be {channelIdLength} characters long'**
  String channel_registration_error_length_mismatched(Object channelIdLength);

  /// No description provided for @channel_registration_error_already_existed.
  ///
  /// In en, this message translates to:
  /// **'This channel is already in the database'**
  String get channel_registration_error_already_existed;

  /// No description provided for @channel_registration_error_unknown.
  ///
  /// In en, this message translates to:
  /// **'There was a problem submitting data, please try again later'**
  String get channel_registration_error_unknown;

  /// No description provided for @channel_registration_title_id_explanation.
  ///
  /// In en, this message translates to:
  /// **'What is a Channel ID?'**
  String get channel_registration_title_id_explanation;

  /// No description provided for @channel_registration_title_type_explanation.
  ///
  /// In en, this message translates to:
  /// **'Types of channels allowed:'**
  String get channel_registration_title_type_explanation;

  /// No description provided for @channel_registration_text_full_vtuber_explanation.
  ///
  /// In en, this message translates to:
  /// **'- Channels primarily featuring VTuber models (Live2D or 3D) from the first content and having a VTuber model as the main character of the content'**
  String get channel_registration_text_full_vtuber_explanation;

  /// No description provided for @channel_registration_text_all_vtuber_explanation.
  ///
  /// In en, this message translates to:
  /// **'- Channels that primarily feature VTuber models after having other contents for a period of time. These channels will only appear in the \'All VTubers\' category.'**
  String get channel_registration_text_all_vtuber_explanation;

  /// No description provided for @channel_registration_text_type_explanation.
  ///
  /// In en, this message translates to:
  /// **'In both cases, the channels must be created by Thais, primarily targeting Thai audiences, and have uploaded some contents.'**
  String get channel_registration_text_type_explanation;

  /// No description provided for @channel_registration_text_id_explanation_1.
  ///
  /// In en, this message translates to:
  /// **'Channel ID is the code following the URL of the channel, such as https://www.youtube.com/channel/'**
  String get channel_registration_text_id_explanation_1;

  /// No description provided for @channel_registration_text_id_explanation_2.
  ///
  /// In en, this message translates to:
  /// **'You can check the channel ID from this site.'**
  String get channel_registration_text_id_explanation_2;

  /// No description provided for @home_title_channel_list.
  ///
  /// In en, this message translates to:
  /// **'List of Thai VTuber channels'**
  String get home_title_channel_list;

  /// No description provided for @home_title_video_list.
  ///
  /// In en, this message translates to:
  /// **'List of Thai VTuber videos'**
  String get home_title_video_list;

  /// No description provided for @home_tab_channel.
  ///
  /// In en, this message translates to:
  /// **'Channels'**
  String get home_tab_channel;

  /// No description provided for @home_tab_video.
  ///
  /// In en, this message translates to:
  /// **'Videos'**
  String get home_tab_video;

  /// No description provided for @home_tooltip_add_channel.
  ///
  /// In en, this message translates to:
  /// **'Submit new VTuber channel'**
  String get home_tooltip_add_channel;

  /// No description provided for @navigation_menu_text_language.
  ///
  /// In en, this message translates to:
  /// **'Site Language'**
  String get navigation_menu_text_language;

  /// No description provided for @navigation_menu_text_channel_type.
  ///
  /// In en, this message translates to:
  /// **'Channel Type'**
  String get navigation_menu_text_channel_type;

  /// No description provided for @navigation_menu_text_original_description.
  ///
  /// In en, this message translates to:
  /// **'Original VTuber\' refers to a channel that debuted and has been creating content as a VTuber from the beginning, rather than transitioning from other types of content.'**
  String get navigation_menu_text_original_description;

  /// No description provided for @navigation_menu_text_active_type.
  ///
  /// In en, this message translates to:
  /// **'Activity Type'**
  String get navigation_menu_text_active_type;

  /// No description provided for @navigation_menu_text_active_type_explanation.
  ///
  /// In en, this message translates to:
  /// **'Channels that have not uploaded a video for over 90 days are classified as inactive.'**
  String get navigation_menu_text_active_type_explanation;

  /// No description provided for @navigation_menu_radio_box_active_only.
  ///
  /// In en, this message translates to:
  /// **'Active channels'**
  String get navigation_menu_radio_box_active_only;

  /// No description provided for @navigation_menu_radio_box_active_and_inactive.
  ///
  /// In en, this message translates to:
  /// **'Active and inactive channels'**
  String get navigation_menu_radio_box_active_and_inactive;

  /// No description provided for @home_tooltip_display_only_channel.
  ///
  /// In en, this message translates to:
  /// **'Displaying only {channelActivityType}'**
  String home_tooltip_display_only_channel(Object channelActivityType);

  /// No description provided for @home_tooltip_display_channel.
  ///
  /// In en, this message translates to:
  /// **'Displaying {channelActivityType}'**
  String home_tooltip_display_channel(Object channelActivityType);

  /// No description provided for @search_bar_placeholder.
  ///
  /// In en, this message translates to:
  /// **'Search for channel'**
  String get search_bar_placeholder;

  /// No description provided for @search_text_input_prompt.
  ///
  /// In en, this message translates to:
  /// **'Enter the name of the channel'**
  String get search_text_input_prompt;

  /// No description provided for @search_text_not_found.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get search_text_not_found;

  /// No description provided for @channel_list_text_subscribers.
  ///
  /// In en, this message translates to:
  /// **'{subscribers} subscribers'**
  String channel_list_text_subscribers(Object subscribers);

  /// No description provided for @channel_list_text_views.
  ///
  /// In en, this message translates to:
  /// **'{views} views'**
  String channel_list_text_views(Object views);

  /// No description provided for @channel_list_text_updated_published.
  ///
  /// In en, this message translates to:
  /// **'Latest video {updated}\nChannel opened on {published}'**
  String channel_list_text_updated_published(Object published, Object updated);

  /// No description provided for @video_list_text_not_found.
  ///
  /// In en, this message translates to:
  /// **'No videos'**
  String get video_list_text_not_found;

  /// No description provided for @video_list_text_live_start.
  ///
  /// In en, this message translates to:
  /// **'Scheduled {liveStart}'**
  String video_list_text_live_start(Object liveStart);

  /// No description provided for @video_list_text_concurrent_view.
  ///
  /// In en, this message translates to:
  /// **'Concurrent View: {concurrentView} people'**
  String video_list_text_concurrent_view(Object concurrentView);

  /// No description provided for @video_list_text_views_published.
  ///
  /// In en, this message translates to:
  /// **'{views} views | {publishedAt}'**
  String video_list_text_views_published(Object publishedAt, Object views);

  /// No description provided for @video_list_text_number.
  ///
  /// In en, this message translates to:
  /// **'{displayRank}. {title}'**
  String video_list_text_number(Object displayRank, Object title);

  /// No description provided for @channel_list_tab_subscribers.
  ///
  /// In en, this message translates to:
  /// **'Subscribers'**
  String get channel_list_tab_subscribers;

  /// No description provided for @channel_list_tab_views.
  ///
  /// In en, this message translates to:
  /// **'Views'**
  String get channel_list_tab_views;

  /// No description provided for @channel_list_tab_published.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get channel_list_tab_published;

  /// No description provided for @channel_list_text_rank.
  ///
  /// In en, this message translates to:
  /// **'Rank {displayRank} {title}'**
  String channel_list_text_rank(Object displayRank, Object title);

  /// No description provided for @video_list_tab_live.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get video_list_tab_live;

  /// No description provided for @video_list_tab_one_day.
  ///
  /// In en, this message translates to:
  /// **'24 hours'**
  String get video_list_tab_one_day;

  /// No description provided for @video_list_tab_three_days.
  ///
  /// In en, this message translates to:
  /// **'3 days'**
  String get video_list_tab_three_days;

  /// No description provided for @video_list_tab_seven_days.
  ///
  /// In en, this message translates to:
  /// **'7 days'**
  String get video_list_tab_seven_days;

  /// No description provided for @error_empty_channel_description.
  ///
  /// In en, this message translates to:
  /// **'Unable to display information.\nPlease check your internet connection,\nor notify the developer to correct the issue'**
  String get error_empty_channel_description;

  /// No description provided for @error_empty_channel_contact.
  ///
  /// In en, this message translates to:
  /// **'Contact @chuymaster'**
  String get error_empty_channel_contact;

  /// No description provided for @error_not_found_description.
  ///
  /// In en, this message translates to:
  /// **'Page not found ({route}). Please check the URL again.'**
  String error_not_found_description(Object route);

  /// No description provided for @error_not_found_title.
  ///
  /// In en, this message translates to:
  /// **'Not Found!'**
  String get error_not_found_title;

  /// No description provided for @error_lokalise.
  ///
  /// In en, this message translates to:
  /// **'Lokalise!!'**
  String get error_lokalise;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja', 'th'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
    case 'th':
      return AppLocalizationsTh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
