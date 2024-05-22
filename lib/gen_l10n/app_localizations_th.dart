import 'app_localizations.dart';

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get app__site_title => 'ลิสต์รายชื่อ VTuber (วีทูปเบอร์) ไทย';

  @override
  String get common_type_full_vtuber => 'VTuber เต็มตัว';

  @override
  String get common_type_all_vtuber => 'VTuber ทั้งหมด';

  @override
  String get admin__title => '我が名はめぐみん！';

  @override
  String navigation_menu_info_last_updated_at(Object lastUpdatedAt) {
    return 'ข้อมูลอัปเดต $lastUpdatedAt';
  }

  @override
  String navigation_menu_info_site_title(Object appEnvironment) {
    return '${appEnvironment}Thai VTubers Directory';
  }

  @override
  String get navigation_menu_info_site_description => 'เว็บนี้จัดทำเพื่อส่งเสริมวงการ VTuber ไทย\nโดยการเรียบเรียงแชนแนล VTuber คนไทยบนยูทูป';

  @override
  String get navigation_menu_menu_title => 'เมนู';

  @override
  String get navigation_menu_menu_add_new_channel => 'แจ้งเพิ่มแชนแนล';

  @override
  String get navigation_menu_menu_report_problems => 'แจ้งปัญหา/แจ้งข้อมูลแชนแนลผิด/เสนอฟีเจอร์';

  @override
  String get navigation_menu_menu_deletion_criterias => 'เกณฑ์การลบแชนแนลโดยอัตโนมัติ';

  @override
  String get navigation_menu_menu_disclaimer => 'คำสงวนสิทธิ์';

  @override
  String get navigation_menu_menu_discover_thai_vtuber => 'แหล่งข้อมูล VTuber ไทย';

  @override
  String get navigation_menu_menu_for_developers => 'ข้อมูลสำหรับนักพัฒนา';

  @override
  String get navigation_menu_menu_api_document => 'API Document';

  @override
  String get navigation_menu_menu_client_app_repo => 'Client App Repository';

  @override
  String get navigation_menu_menu_release_notes => 'Release Notes';

  @override
  String get navigation_menu_menu_developer_blog => 'บล็อกผู้พัฒนา';

  @override
  String get announcement_text_delete_channel => 'ประกาศเรื่องการลบแชนแนล';

  @override
  String get common_alert_error => 'Error';

  @override
  String get common_button_close => 'ปิด';

  @override
  String get banner_text_reality => 'REALITY - Become an Anime Avatar';

  @override
  String get banner_description_reality => 'สร้างอวาตาร์อนิเมะมาไลฟ์แบบ VTuber เลย!';

  @override
  String get common_button_reload => 'รีโหลด';

  @override
  String get channel_button_copy_url => 'Copy URL ของหน้านี้';

  @override
  String get channel_toast_copied_url => 'Copy URL แล้ว';

  @override
  String get channel_graph_description => 'กราฟความเปลี่ยนแปลง';

  @override
  String get channel_description_empty => 'ไม่มีคำอธิบาย';

  @override
  String channel_info_subscribers_views(Object subscribers, Object views) {
    return 'ผู้ติดตาม $subscribers คน\nดู $views ครั้ง';
  }

  @override
  String channel_info_updated_published(Object published, Object updated) {
    return 'คลิปล่าสุด $updated\nวันเปิดแชนแนล $published';
  }

  @override
  String get channel_info_api => 'API';

  @override
  String get channel_registration_complete_text_title => 'แจ้งเพิ่มแชนแนลสำเร็จ';

  @override
  String get channel_registration_complete_text_description => 'ขอบคุณที่ส่งข้อมูลแชนแนล ทางทีมงานจะพิจารณาและนำเข้าสู่ฐานข้อมูลหากข้อมูลถูกต้อง';

  @override
  String get channel_registration_complete_button_home => 'กลับสู่หน้าแรก';

  @override
  String get channel_registration_text_title => 'แจ้งเพิ่มแชนแนล VTuber';

  @override
  String get channel_registration_text_input_channel => 'โปรดกรอกแชนแนล ID (ขึ้นต้นด้วย UC)';

  @override
  String get channel_registration_text_select_channel_type => 'โปรดเลือกประเภทของช่องที่ต้องการแจ้ง';

  @override
  String get channel_registration_text_check_before_submit => 'โปรดตรวจสอบแชนแนลอีกครั้งก่อนส่งข้อมูล';

  @override
  String get channel_registration_button_submit => 'ส่งข้อมูล';

  @override
  String get channel_registration_error_id_required => 'โปรดกรอกแชนแนล ID';

  @override
  String get channel_registration_error_not_begin_with_uc => 'แชนแนล ID ต้องขึ้นต้นด้วย UC';

  @override
  String channel_registration_error_length_mismatched(Object channelIdLength) {
    return 'แชนแนล ID ต้องมีความยาว $channelIdLength ตัวอักษร';
  }

  @override
  String get channel_registration_error_already_existed => 'แชนแนลนี้อยู่ในฐานข้อมูลแล้ว';

  @override
  String get channel_registration_error_unknown => 'เกิดปัญหาในการส่งข้อมูล กรุณาลองใหม่ในภายหลัง';

  @override
  String get channel_registration_title_id_explanation => 'แชนแนล ID คืออะไร?';

  @override
  String get channel_registration_title_type_explanation => 'ประเภทของแชนแนลที่อนุญาต';

  @override
  String get channel_registration_text_full_vtuber_explanation => '- แชนแนลที่นำแสดงโดยโมเดล VTuber (โมเดล Live2D หรือ 3D) เป็นหลักตั้งแต่คอนเทนต์แรก มีโมเดล VTuber เป็นตัวเอกของคอนเทนต์ และประกาศตนว่าเป็น VTuber';

  @override
  String get channel_registration_text_all_vtuber_explanation => '- แชนแนลที่นำโมเดล VTuber มาแสดงเป็นหลักหลังจากเปิดแชนแนลและอัพโหลดคอนเทนต์อื่นไปแล้ว จะปรากฏในการรายชื่อหมวด \"VTuber ทั้งหมด\" เท่านั้น';

  @override
  String get channel_registration_text_type_explanation => 'ทั้งสองกรณีต้องเป็นแชนแนลที่ทำโดยคนไทย มุ่งเน้นกลุ่มผู้ชมคนไทยเป็นหลัก และมีคอนเทนต์อัพโหลดแล้ว ทีมงานจึงจะสามารถพิจารณาได้';

  @override
  String get channel_registration_text_id_explanation_1 => 'แชนแนล ID คือรหัสตามหลัง URL ของแชนแนล เช่น https://www.youtube.com/channel/';

  @override
  String get channel_registration_text_id_explanation_2 => 'ตรวจสอบ ID ของแชนแนลได้ที่นี่';

  @override
  String get home_title_channel_list => 'ลิสต์แชนแนล VTuber ไทย';

  @override
  String get home_title_video_list => 'ลิสต์วิดีโอ VTuber ไทย';

  @override
  String get home_tab_channel => 'แชนแนล';

  @override
  String get home_tab_video => 'วิดีโอ';

  @override
  String get home_tooltip_add_channel => 'แจ้งเพิ่มแชนแนล';

  @override
  String get navigation_menu_text_language => 'ภาษาของเว็บ';

  @override
  String get navigation_menu_text_channel_type => 'ประเภทแชนแนล';

  @override
  String get navigation_menu_text_original_description => '\'VTuber เต็มตัว\' หมายถึงแชนแนลที่เดบิวต์ตัวเองเป็น VTuber และทำคอนเทนต์ VTuber ตั้งแต่ต้น ไม่ได้เปลี่ยนมาจากคอนเทนต์อื่น';

  @override
  String get navigation_menu_text_active_type => 'ประเภทการอัปเดต';

  @override
  String get navigation_menu_text_active_type_explanation => 'แชนแนลที่ไม่มีการอัปโหลดวิดีโอมา 90 วันขึ้นไป จัดเป็นแชนแนลที่ไม่มีการอัปเดต';

  @override
  String get navigation_menu_radio_box_active_only => 'แชนแนลที่ยังอัปเดตอยู่';

  @override
  String get navigation_menu_radio_box_active_and_inactive => 'แชนแนลที่อัปเดตและไม่อัปเดต';

  @override
  String home_tooltip_display_only_channel(Object channelActivityType) {
    return 'กำลังแสดงเฉพาะ $channelActivityType';
  }

  @override
  String home_tooltip_display_channel(Object channelActivityType) {
    return 'กำลังแสดง $channelActivityType';
  }

  @override
  String get search_bar_placeholder => 'ค้นหาแชนแนล';

  @override
  String get search_text_input_prompt => 'พิมพ์ชื่อแชนแนลที่อยากค้นหา';

  @override
  String get search_text_not_found => 'ไม่พบผลลัพธ์';

  @override
  String channel_list_text_subscribers(Object subscribers) {
    return 'ผู้ติดตาม $subscribers คน';
  }

  @override
  String channel_list_text_views(Object views) {
    return 'ดู $views ครั้ง';
  }

  @override
  String channel_list_text_updated_published(Object published, Object updated) {
    return 'วิดีโอล่าสุด $updated\nวันเปิดแชนแนล $published';
  }

  @override
  String get video_list_text_not_found => 'ไม่มีวิดีโอ';

  @override
  String video_list_text_live_start(Object liveStart) {
    return 'เริ่ม $liveStart';
  }

  @override
  String video_list_text_concurrent_view(Object concurrentView) {
    return 'ดูพร้อมกัน $concurrentView คน';
  }

  @override
  String video_list_text_views_published(Object publishedAt, Object views) {
    return 'ดู $views ครั้ง | $publishedAt';
  }

  @override
  String video_list_text_number(Object displayRank, Object title) {
    return '$displayRank. $title';
  }

  @override
  String get channel_list_tab_subscribers => 'ผู้ติดตาม';

  @override
  String get channel_list_tab_views => 'Views';

  @override
  String get channel_list_tab_published => 'วันเปิดแชนแนล';

  @override
  String channel_list_text_rank(Object displayRank, Object title) {
    return 'อันดับ $displayRank $title';
  }

  @override
  String get video_list_tab_live => 'Live';

  @override
  String get video_list_tab_one_day => '24 ชม.';

  @override
  String get video_list_tab_three_days => '3 วัน';

  @override
  String get video_list_tab_seven_days => '7 วัน';

  @override
  String get error_empty_channel_description => 'เกิดข้อผิดพลาดจึงไม่สามารถแสดงข้อมูลได้\nกรุณาตรวจสอบการเชื่อมต่ออินเทอร์เน็ต\nหรือแจ้งผู้พัฒนาเพื่อทำการแก้ไข';

  @override
  String get error_empty_channel_contact => 'ติดต่อ @chuymaster';

  @override
  String error_not_found_description(Object route) {
    return 'ไม่พบเพจที่ต้องการเปิด ($route).\nโปรดตรวจสอบ URL อีกครั้ง';
  }

  @override
  String get error_not_found_title => 'Not Found';
}
