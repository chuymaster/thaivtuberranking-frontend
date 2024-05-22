import 'app_localizations.dart';

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get app__site_title => 'タイのVTuber（バーチャルユーチューバー）一覧';

  @override
  String get common_type_full_vtuber => 'オリジナルVTuber';

  @override
  String get common_type_all_vtuber => '全てのVTuber';

  @override
  String get admin__title => '我が名はめぐみん！';

  @override
  String navigation_menu_info_last_updated_at(Object lastUpdatedAt) {
    return '最終更新日 $lastUpdatedAt';
  }

  @override
  String navigation_menu_info_site_title(Object appEnvironment) {
    return '${appEnvironment}Thai VTubers Directory';
  }

  @override
  String get navigation_menu_info_site_description => 'お気に入りのタイのVTuberを見つけよう！';

  @override
  String get navigation_menu_menu_title => 'メニュー';

  @override
  String get navigation_menu_menu_add_new_channel => 'チャンネル掲載申請';

  @override
  String get navigation_menu_menu_report_problems => 'お問い合わせ・要望';

  @override
  String get navigation_menu_menu_deletion_criterias => 'チャンネル自動削除基準';

  @override
  String get navigation_menu_menu_disclaimer => '免責事項';

  @override
  String get navigation_menu_menu_discover_thai_vtuber => 'タイのVTuber情報を探す';

  @override
  String get navigation_menu_menu_for_developers => '開発者向け情報';

  @override
  String get navigation_menu_menu_api_document => 'APIドキュメント';

  @override
  String get navigation_menu_menu_client_app_repo => 'クライアントアプリレポジトリ';

  @override
  String get navigation_menu_menu_release_notes => 'リリースノート';

  @override
  String get navigation_menu_menu_developer_blog => '開発者ブログ';

  @override
  String get announcement_text_delete_channel => 'チャンネル削除告知';

  @override
  String get common_alert_error => 'エラー';

  @override
  String get common_button_close => '閉じる';

  @override
  String get banner_text_reality => 'REALITY - 顔出しナシのライブ配信';

  @override
  String get banner_description_reality => 'スマホ一台で好きな姿に変身！';

  @override
  String get common_button_reload => '再読込';

  @override
  String get channel_button_copy_url => 'このページのURLをコピー';

  @override
  String get channel_toast_copied_url => 'コピーしました';

  @override
  String get channel_graph_description => 'グラフ';

  @override
  String get channel_description_empty => 'チャンネル説明なし';

  @override
  String channel_info_subscribers_views(Object subscribers, Object views) {
    return '登録者数 $subscribers人\n視聴回数 $views回';
  }

  @override
  String channel_info_updated_published(Object published, Object updated) {
    return '最新動画 $updated\nチャンネル開設日 $published';
  }

  @override
  String get channel_info_api => 'API';

  @override
  String get channel_registration_complete_text_title => 'チャンネル掲載申請が完了しました。';

  @override
  String get channel_registration_complete_text_description => 'ご申請いただき、ありがとうございます。\n確認後、問題なければチャンネル一覧に掲載いたします。';

  @override
  String get channel_registration_complete_button_home => 'ホームに戻る';

  @override
  String get channel_registration_text_title => 'VTuberチャンネル掲載申請';

  @override
  String get channel_registration_text_input_channel => 'UCで始まるチャンネルIDを入力してください。';

  @override
  String get channel_registration_text_select_channel_type => 'チャンネルカテゴリの選択';

  @override
  String get channel_registration_text_check_before_submit => 'チャンネル情報が正しいかどうか、今一度ご確認ください。';

  @override
  String get channel_registration_button_submit => '申請';

  @override
  String get channel_registration_error_id_required => 'チャンネルIDを入力してください。';

  @override
  String get channel_registration_error_not_begin_with_uc => 'チャンネルIDはUCで始まる必要があります。';

  @override
  String channel_registration_error_length_mismatched(Object channelIdLength) {
    return 'チャンネルIDは$channelIdLength文字である必要があります。';
  }

  @override
  String get channel_registration_error_already_existed => 'このチャンネルは掲載済です。';

  @override
  String get channel_registration_error_unknown => '問題が発生しました。後ほど再試行してください。';

  @override
  String get channel_registration_title_id_explanation => 'チャンネルIDとは？';

  @override
  String get channel_registration_title_type_explanation => '掲載可能なチャンネル';

  @override
  String get channel_registration_text_full_vtuber_explanation => '・チャンネル開設時からVTuberモデル（Live2Dまたは3D）を使って動画を投稿し、主にVTuberとして活動しているチャンネル';

  @override
  String get channel_registration_text_all_vtuber_explanation => '・一定期間の活動後、VTuberに転換したチャンネル。あるいはVTuberモデルを使って動画を投稿しているが、メインコンテンツではないチャンネル。「全てのVTuber」のカテゴリで表示されます。';

  @override
  String get channel_registration_text_type_explanation => 'いずれもタイ人によって制作され、タイ人を主な視聴者としているチャンネル、かつコンテンツがアップロードされている場合に限り、掲載が可能になります。';

  @override
  String get channel_registration_text_id_explanation_1 => 'チャンネルIDは、チャンネルURLに続くコードです。例：https://www.youtube.com/channel/';

  @override
  String get channel_registration_text_id_explanation_2 => '\nチャンネルIDはこちらのサイトから調べることができます。';

  @override
  String get home_title_channel_list => 'タイのVTuberチャンネル一覧';

  @override
  String get home_title_video_list => 'タイのVTuber動画一覧';

  @override
  String get home_tab_channel => 'チャンネル';

  @override
  String get home_tab_video => '動画';

  @override
  String get home_tooltip_add_channel => 'チャンネル掲載申請';

  @override
  String get navigation_menu_text_language => '表示言語';

  @override
  String get navigation_menu_text_channel_type => 'チャンネルカテゴリ';

  @override
  String get navigation_menu_text_original_description => '「オリジナルVTuber」は、チャンネル開設時からVTuberとしてデビューし、コンテンツを制作しているチャンネルを指します。';

  @override
  String get navigation_menu_text_active_type => '活動状態';

  @override
  String get navigation_menu_text_active_type_explanation => '90日以上動画を投稿していないチャンネルは活動休止チャンネルとなります。';

  @override
  String get navigation_menu_radio_box_active_only => '活動中';

  @override
  String get navigation_menu_radio_box_active_and_inactive => '活動休止中を含む';

  @override
  String home_tooltip_display_only_channel(Object channelActivityType) {
    return '$channelActivityType のみを表示中';
  }

  @override
  String home_tooltip_display_channel(Object channelActivityType) {
    return '$channelActivityType を表示中';
  }

  @override
  String get search_bar_placeholder => 'チャンネル検索';

  @override
  String get search_text_input_prompt => 'チャンネル名を入力';

  @override
  String get search_text_not_found => '結果が見つかりません';

  @override
  String channel_list_text_subscribers(Object subscribers) {
    return 'フォロワー数 $subscribers人';
  }

  @override
  String channel_list_text_views(Object views) {
    return '視聴回数 $views回';
  }

  @override
  String channel_list_text_updated_published(Object published, Object updated) {
    return '動画更新日 $updated\n開設日  $published';
  }

  @override
  String get video_list_text_not_found => '動画がありません';

  @override
  String video_list_text_live_start(Object liveStart) {
    return 'ライブ開始 $liveStart';
  }

  @override
  String video_list_text_concurrent_view(Object concurrentView) {
    return '同時接続数 $concurrentView 人';
  }

  @override
  String video_list_text_views_published(Object publishedAt, Object views) {
    return '$views回 | $publishedAt';
  }

  @override
  String video_list_text_number(Object displayRank, Object title) {
    return '$displayRank. $title';
  }

  @override
  String get channel_list_tab_subscribers => 'フォロワー数';

  @override
  String get channel_list_tab_views => '視聴回数';

  @override
  String get channel_list_tab_published => '開設日';

  @override
  String channel_list_text_rank(Object displayRank, Object title) {
    return '$displayRank位 $title';
  }

  @override
  String get video_list_tab_live => 'ライブ';

  @override
  String get video_list_tab_one_day => '24時間';

  @override
  String get video_list_tab_three_days => '3日';

  @override
  String get video_list_tab_seven_days => '7日';

  @override
  String get error_empty_channel_description => 'エラーが発生しました。\nインターネットが正常に接続されているかを確認し、\n開発者に連絡してください。';

  @override
  String get error_empty_channel_contact => '@chuymaster に連絡';

  @override
  String error_not_found_description(Object route) {
    return '$routeが存在しません。URLをもう一度確認してください。';
  }

  @override
  String get error_not_found_title => '存在しないページです';
}
