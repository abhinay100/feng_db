-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 26, 2015 at 03:41 AM
-- Server version: 5.5.44-0ubuntu0.14.04.1
-- PHP Version: 5.5.27-1+deb.sury.org~trusty+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `fengoffice`
--

-- --------------------------------------------------------

--
-- Table structure for table `fo_address_types`
--

CREATE TABLE IF NOT EXISTS `fo_address_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_system` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `fo_address_types`
--

INSERT INTO `fo_address_types` (`id`, `name`, `is_system`) VALUES
(1, 'home', 1),
(2, 'work', 1),
(3, 'other', 1);

-- --------------------------------------------------------

--
-- Table structure for table `fo_administration_logs`
--

CREATE TABLE IF NOT EXISTS `fo_administration_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `title` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `log_data` text COLLATE utf8_unicode_ci NOT NULL,
  `category` enum('system','security') COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `created_on` (`created_on`),
  KEY `category` (`category`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `fo_administration_logs`
--

INSERT INTO `fo_administration_logs` (`id`, `created_on`, `title`, `log_data`, `category`) VALUES
(1, '2015-08-26 10:29:21', 'invalid login', '127.0.0.1', 'security');

-- --------------------------------------------------------

--
-- Table structure for table `fo_administration_tools`
--

CREATE TABLE IF NOT EXISTS `fo_administration_tools` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `controller` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `action` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `fo_administration_tools`
--

INSERT INTO `fo_administration_tools` (`id`, `name`, `controller`, `action`, `order`, `visible`) VALUES
(1, 'test_mail_settings', 'administration', 'tool_test_email', 1, 1),
(2, 'mass_mailer', 'administration', 'tool_mass_mailer', 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `fo_application_logs`
--

CREATE TABLE IF NOT EXISTS `fo_application_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `taken_by_id` int(10) unsigned DEFAULT NULL,
  `rel_object_id` int(10) NOT NULL DEFAULT '0',
  `object_name` text COLLATE utf8_unicode_ci,
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `action` enum('upload','open','close','delete','edit','add','trash','untrash','subscribe','unsubscribe','tag','comment','link','unlink','login','logout','untag','archive','unarchive','move','copy','read','download','checkin','checkout') COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_private` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_silent` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `member_id` int(10) NOT NULL DEFAULT '0',
  `log_data` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `created_on` (`created_on`,`is_silent`) USING BTREE,
  KEY `object` (`rel_object_id`,`created_on`,`is_silent`),
  KEY `member` (`member_id`,`created_on`,`is_silent`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `fo_application_logs`
--

INSERT INTO `fo_application_logs` (`id`, `taken_by_id`, `rel_object_id`, `object_name`, `created_on`, `created_by_id`, `action`, `is_private`, `is_silent`, `member_id`, `log_data`) VALUES
(1, 2, 2, 'admin', '2015-08-26 10:29:38', 2, 'login', 0, 0, 0, '127.0.0.1');

-- --------------------------------------------------------

--
-- Table structure for table `fo_application_read_logs`
--

CREATE TABLE IF NOT EXISTS `fo_application_read_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `taken_by_id` int(10) NOT NULL DEFAULT '0',
  `rel_object_id` int(10) NOT NULL DEFAULT '0',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `action` enum('read','download') COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_on` (`created_on`),
  KEY `object_key` (`rel_object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_billings`
--

CREATE TABLE IF NOT EXISTS `fo_billings` (
  `object_id` int(10) unsigned NOT NULL,
  `value` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_billing_categories`
--

CREATE TABLE IF NOT EXISTS `fo_billing_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `description` text COLLATE utf8_unicode_ci,
  `default_value` float NOT NULL DEFAULT '0',
  `report_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `created_on` datetime DEFAULT NULL,
  `created_by_id` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_comments`
--

CREATE TABLE IF NOT EXISTS `fo_comments` (
  `object_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rel_object_id` int(10) unsigned NOT NULL DEFAULT '0',
  `text` text COLLATE utf8_unicode_ci,
  `author_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `author_email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `author_homepage` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`object_id`),
  KEY `object_id` (`rel_object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_config_categories`
--

CREATE TABLE IF NOT EXISTS `fo_config_categories` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_system` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `category_order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `order` (`category_order`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Dumping data for table `fo_config_categories`
--

INSERT INTO `fo_config_categories` (`id`, `name`, `is_system`, `category_order`) VALUES
(1, 'system', 1, 0),
(2, 'general', 0, 1),
(3, 'mailing', 0, 2),
(4, 'brand_colors', 0, 3),
(5, 'passwords', 0, 4);

-- --------------------------------------------------------

--
-- Table structure for table `fo_config_options`
--

CREATE TABLE IF NOT EXISTS `fo_config_options` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `category_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `value` text COLLATE utf8_unicode_ci,
  `config_handler_class` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_system` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `option_order` smallint(5) unsigned NOT NULL DEFAULT '0',
  `dev_comment` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `order` (`option_order`),
  KEY `category_id` (`category_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=75 ;

--
-- Dumping data for table `fo_config_options`
--

INSERT INTO `fo_config_options` (`id`, `category_name`, `name`, `value`, `config_handler_class`, `is_system`, `option_order`, `dev_comment`) VALUES
(1, 'system', 'project_logs_per_page', '10', 'IntegerConfigHandler', 1, 0, NULL),
(2, 'system', 'messages_per_page', '5', 'IntegerConfigHandler', 1, 0, NULL),
(3, 'system', 'max_avatar_width', '50', 'IntegerConfigHandler', 1, 0, NULL),
(4, 'system', 'max_avatar_height', '50', 'IntegerConfigHandler', 1, 0, NULL),
(5, 'system', 'logs_per_project', '5', 'IntegerConfigHandler', 1, 0, NULL),
(6, 'system', 'max_logo_width', '50', 'IntegerConfigHandler', 1, 0, NULL),
(7, 'system', 'max_logo_height', '50', 'IntegerConfigHandler', 1, 0, NULL),
(8, 'system', 'files_per_page', '50', 'IntegerConfigHandler', 1, 0, NULL),
(9, 'system', 'notification_from_address', '', 'StringConfigHandler', 1, 0, 'Address to use as from field in email notifications. If empty, users address is used'),
(10, 'system', 'min_chars_for_match', '3', 'IntegerConfigHandler', 1, 0, 'If search criteria len is less than this, then use always LIKE'),
(11, 'system', 'getting_started_step', '1', 'IntegerConfigHandler', 1, 0, ''),
(12, 'general', 'upgrade_last_check_datetime', '2006-09-02 13:46:47', 'DateTimeConfigHandler', 1, 0, 'Date and time of the last upgrade check'),
(13, 'general', 'upgrade_last_check_new_version', '0', 'BoolConfigHandler', 1, 0, 'True if system checked for the new version and found it. This value is used to hightligh upgrade tab in the administration'),
(14, 'general', 'file_storage_adapter', 'fs', 'FileStorageConfigHandler', 0, 0, 'What storage adapter should be used? fs or mysql'),
(15, 'general', 'theme', 'default', 'ThemeConfigHandler', 0, 0, NULL),
(16, 'general', 'days_on_trash', '30', 'IntegerConfigHandler', 0, 0, 'Days before a file is deleted from trash. 0 = Not deleted'),
(17, 'mailing', 'exchange_compatible', '0', 'BoolConfigHandler', 1, 0, NULL),
(18, 'mailing', 'mail_transport', 'mail()', 'MailTransportConfigHandler', 0, 0, 'Values: ''mail()'' - try to emulate mail() function, ''smtp'' - use SMTP connection'),
(19, 'mailing', 'smtp_server', '', 'StringConfigHandler', 0, 0, ''),
(20, 'mailing', 'smtp_port', '25', 'IntegerConfigHandler', 0, 0, NULL),
(21, 'mailing', 'smtp_address', '', 'StringConfigHandler', 0, 0, ''),
(22, 'mailing', 'smtp_authenticate', '0', 'BoolConfigHandler', 0, 0, 'Use SMTP authentication'),
(23, 'mailing', 'smtp_username', '', 'StringConfigHandler', 0, 0, NULL),
(24, 'mailing', 'smtp_password', '', 'PasswordConfigHandler', 0, 0, NULL),
(25, 'mailing', 'smtp_secure_connection', 'no', 'SecureSmtpConnectionConfigHandler', 0, 0, 'Values: no, ssl, tls'),
(26, 'mailing', 'show images in document notifications', '0', 'BoolConfigHandler', 0, 0, NULL),
(27, 'mailing', 'notification_recipients_field', 'to', 'MailFieldConfigHandler', 0, 10, NULL),
(28, 'passwords', 'min_password_length', '0', 'IntegerConfigHandler', 0, 1, NULL),
(29, 'passwords', 'password_numbers', '0', 'IntegerConfigHandler', 0, 2, NULL),
(30, 'passwords', 'password_uppercase_characters', '0', 'IntegerConfigHandler', 0, 3, NULL),
(31, 'passwords', 'password_metacharacters', '0', 'IntegerConfigHandler', 0, 4, NULL),
(32, 'passwords', 'password_expiration', '0', 'IntegerConfigHandler', 0, 5, NULL),
(33, 'passwords', 'password_expiration_notification', '0', 'IntegerConfigHandler', 0, 6, NULL),
(34, 'passwords', 'account_block', '0', 'BoolConfigHandler', 0, 7, NULL),
(35, 'passwords', 'new_password_char_difference', '0', 'BoolConfigHandler', 0, 8, NULL),
(36, 'passwords', 'validate_password_history', '0', 'BoolConfigHandler', 0, 9, NULL),
(37, 'passwords', 'block_login_after_x_tries', '0', 'BoolConfigHandler', 0, 20, NULL),
(38, 'general', 'checkout_notification_dialog', '0', 'BoolConfigHandler', 0, 0, NULL),
(39, 'general', 'file_revision_comments_required', '0', 'BoolConfigHandler', 0, 0, NULL),
(40, 'general', 'currency_code', '$', 'StringConfigHandler', 0, 0, NULL),
(41, 'general', 'checkout_for_editing_online', '0', 'BoolConfigHandler', 0, 0, NULL),
(42, 'general', 'show_feed_links', '0', 'BoolConfigHandler', 0, 0, NULL),
(43, 'general', 'use_owner_company_logo_at_header', '1', 'BoolConfigHandler', 0, 0, NULL),
(44, 'general', 'ask_administration_autentification', '0', 'BoolConfigHandler', 0, 0, NULL),
(45, 'general', 'use tasks dependencies', '1', 'BoolConfigHandler', 0, 0, NULL),
(46, 'general', 'untitled_notes', '0', 'BoolConfigHandler', 0, 0, NULL),
(47, 'general', 'repeating_task', '0', 'BoolConfigHandler', 0, 0, NULL),
(48, 'general', 'working_days', '1,2,3,4,5,6,7', 'StringConfigHandler', 0, 0, NULL),
(49, 'general', 'wysiwyg_tasks', '1', 'BoolConfigHandler', 0, 0, NULL),
(50, 'general', 'wysiwyg_messages', '1', 'BoolConfigHandler', 0, 0, NULL),
(51, 'general', 'wysiwyg_projects', '0', 'BoolConfigHandler', 0, 0, NULL),
(52, 'general', 'use_milestones', '0', 'BoolConfigHandler', 0, 0, NULL),
(53, 'general', 'show_tab_icons', '1', 'BoolConfigHandler', 0, 0, NULL),
(54, 'general', 'can_assign_tasks_to_companies', '0', 'BoolConfigHandler', 0, 0, NULL),
(55, 'general', 'use_object_properties', '0', 'BoolConfigHandler', 0, 0, NULL),
(56, 'general', 'let_users_create_objects_in_root', '1', 'BoolConfigHandler', 0, 0, NULL),
(57, 'general', 'add_default_permissions_for_users', '1', 'BoolConfigHandler', 0, 0, NULL),
(58, 'general', 'inherit_permissions_from_parent_member', '1', 'BoolConfigHandler', 0, 0, NULL),
(59, 'general', 'give_member_permissions_to_new_users', '2,4,3,1', 'UserTypeMultipleConfigHandler', 0, 0, NULL),
(60, 'general', 'milestone_selector_filter', 'current_and_parents', 'MilestoneSelectorFilterConfigHandler', 0, 0, NULL),
(61, 'general', 'show_owner_company_name_header', '0', 'BoolConfigHandler', 1, 100, ''),
(62, 'general', 'enabled_dimensions', ',2', 'RootDimensionsConfigHandler', 1, 0, NULL),
(63, 'general', 'last_sharing_table_rebuild', '', 'StringConfigHandler', 1, 0, NULL),
(64, 'general', 'check_unique_mail_contact_comp', '0', 'BoolConfigHandler', 0, 0, NULL),
(65, 'general', 'mandatory_address_fields', '', 'AddressFieldsConfigHandler', 0, 0, NULL),
(66, 'system', 'last_template_instantiation_id', '0', 'IntegerConfigHandler', 1, 0, NULL),
(67, 'brand_colors', 'brand_colors_head_back', '424242', 'ColorPickerConfigHandler', 0, 0, NULL),
(68, 'brand_colors', 'brand_colors_head_font', 'FFFFFF', 'ColorPickerConfigHandler', 0, 0, NULL),
(69, 'brand_colors', 'brand_colors_tabs_back', 'e7e7e7', 'ColorPickerConfigHandler', 1, 0, NULL),
(70, 'brand_colors', 'brand_colors_tabs_font', '333333', 'ColorPickerConfigHandler', 1, 0, NULL),
(71, 'system', 'hide_people_vinculations', '1', 'BoolConfigHandler', 1, 0, NULL),
(72, 'mailing', 'user_email_fetch_count', '10', 'IntegerConfigHandler', 0, 0, 'How many emails to fetch when checking for email'),
(73, 'mailing', 'sent_mails_sync', '0', 'BoolConfigHandler', 0, 0, 'imap email accounts synchronization possibility'),
(74, 'mailing', 'check_spam_in_subject', '0', 'BoolConfigHandler', 0, 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `fo_contacts`
--

CREATE TABLE IF NOT EXISTS `fo_contacts` (
  `object_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `surname` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_company` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `company_id` int(10) unsigned DEFAULT NULL,
  `department` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `job_title` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  `timezone` float(3,1) NOT NULL DEFAULT '0.0',
  `user_type` smallint(5) unsigned NOT NULL DEFAULT '0',
  `is_active_user` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `token` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `salt` varchar(13) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `twister` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `display_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `permission_group_id` int(10) unsigned NOT NULL,
  `username` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `contact_passwords_id` int(10) unsigned NOT NULL,
  `picture_file` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `picture_file_small` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `picture_file_medium` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar_file` varchar(44) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comments` text COLLATE utf8_unicode_ci,
  `last_login` datetime DEFAULT NULL,
  `last_visit` datetime DEFAULT NULL,
  `last_activity` datetime DEFAULT NULL,
  `personal_member_id` int(10) unsigned DEFAULT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `default_billing_id` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`),
  KEY `first_name` (`first_name`,`surname`) USING BTREE,
  KEY `surname` (`surname`,`first_name`) USING BTREE,
  KEY `company` (`is_company`,`company_id`,`department`),
  KEY `username` (`user_type`,`username`),
  KEY `perm_group` (`permission_group_id`) USING HASH
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `fo_contacts`
--

INSERT INTO `fo_contacts` (`object_id`, `first_name`, `surname`, `is_company`, `company_id`, `department`, `job_title`, `birthday`, `timezone`, `user_type`, `is_active_user`, `token`, `salt`, `twister`, `display_name`, `permission_group_id`, `username`, `contact_passwords_id`, `picture_file`, `picture_file_small`, `picture_file_medium`, `avatar_file`, `comments`, `last_login`, `last_visit`, `last_activity`, `personal_member_id`, `disabled`, `default_billing_id`) VALUES
(1, 'avni', '', 1, 0, '', '', '0000-00-00 00:00:00', 0.0, 0, 0, '', '', '', '', 0, '', 0, '', '', '', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, 0),
(2, 'admin', '', 0, 1, '', '', '0000-00-00 00:00:00', -7.0, 1, 0, '2fe880c2712abf1018c5675b022f2f895f470f47', 'ccaee9972124f', '2157964038', '', 14, 'admin', 0, '', '', '', '', '', '2015-08-26 10:29:38', '2015-08-26 10:29:38', '2015-08-26 10:29:38', 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `fo_contact_addresses`
--

CREATE TABLE IF NOT EXISTS `fo_contact_addresses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contact_id` int(10) unsigned NOT NULL,
  `address_type_id` int(10) unsigned NOT NULL,
  `street` text COLLATE utf8_unicode_ci,
  `city` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `state` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `country` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `zip_code` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_main` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `by_contact` (`contact_id`,`is_main`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_contact_config_categories`
--

CREATE TABLE IF NOT EXISTS `fo_contact_config_categories` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_system` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `category_order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `order` (`category_order`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=8 ;

--
-- Dumping data for table `fo_contact_config_categories`
--

INSERT INTO `fo_contact_config_categories` (`id`, `name`, `is_system`, `type`, `category_order`) VALUES
(1, 'general', 0, 0, 0),
(2, 'task panel', 0, 0, 2),
(3, 'calendar panel', 0, 0, 4),
(4, 'context help', 1, 0, 5),
(5, 'time panel', 0, 0, 3),
(6, 'listing preferences', 0, 0, 10),
(7, 'mails panel', 0, 0, 5);

-- --------------------------------------------------------

--
-- Table structure for table `fo_contact_config_options`
--

CREATE TABLE IF NOT EXISTS `fo_contact_config_options` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `default_value` text COLLATE utf8_unicode_ci,
  `config_handler_class` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_system` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `option_order` smallint(5) unsigned NOT NULL DEFAULT '0',
  `dev_comment` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `order` (`option_order`),
  KEY `category_id` (`category_name`,`is_system`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=202 ;

--
-- Dumping data for table `fo_contact_config_options`
--

INSERT INTO `fo_contact_config_options` (`id`, `category_name`, `name`, `default_value`, `config_handler_class`, `is_system`, `option_order`, `dev_comment`) VALUES
(1, 'task panel', 'tasksDateStart', '0000-00-00 00:00:00', 'DateTimeConfigHandler', 1, 0, 'date from to filter out task list'),
(2, 'task panel', 'tasksDateEnd', '0000-00-00 00:00:00', 'DateTimeConfigHandler', 1, 0, 'the date up to filter the list of tasks'),
(3, 'task panel', 'show_notify_checkbox_in_quick_add', '1', 'BoolConfigHandler', 1, 0, 'Show notification checkbox in quick add task view'),
(4, 'task panel', 'can notify from quick add', '1', 'BoolConfigHandler', 0, 0, 'Notification checkbox default value'),
(5, 'task panel', 'can notify subscribers', '1', 'BoolConfigHandler', 0, 0, 'Notification checkbox default value'),
(6, 'task panel', 'tasksShowWorkspaces', '1', 'BoolConfigHandler', 1, 0, ''),
(7, 'task panel', 'tasksShowTime', '1', 'BoolConfigHandler', 1, 0, ''),
(8, 'task panel', 'tasksShowDates', '1', 'BoolConfigHandler', 1, 0, ''),
(9, 'task panel', 'tasksShowPercentCompletedBar', '0', 'BoolConfigHandler', 1, 0, ''),
(10, 'task panel', 'tasksShowTimeEstimates', '1', 'BoolConfigHandler', 1, 0, ''),
(11, 'task panel', 'tasksShowTimePending', '0', 'BoolConfigHandler', 1, 0, ''),
(12, 'task panel', 'tasksShowTimeWorked', '0', 'BoolConfigHandler', 1, 0, ''),
(13, 'task panel', 'tasksShowQuickEdit', '1', 'BoolConfigHandler', 1, 0, ''),
(14, 'task panel', 'tasksShowQuickComplete', '0', 'BoolConfigHandler', 1, 0, ''),
(15, 'task panel', 'tasksShowQuickComment', '0', 'BoolConfigHandler', 1, 0, ''),
(16, 'task panel', 'tasksShowStartDates', '0', 'BoolConfigHandler', 1, 0, ''),
(17, 'task panel', 'tasksShowAssignedBy', '0', 'BoolConfigHandler', 1, 0, ''),
(18, 'task panel', 'tasksShowClassification', '1', 'BoolConfigHandler', 1, 0, ''),
(19, 'task panel', 'tasksShowSubtasksStructure', '1', 'BoolConfigHandler', 1, 0, ''),
(20, 'task panel', 'tasksShowEndDates', '1', 'BoolConfigHandler', 1, 0, ''),
(21, 'task panel', 'tasksShowQuickAddSubTasks', '0', 'BoolConfigHandler', 1, 0, ''),
(22, 'task panel', 'tasksShowDescriptionOnTimeForms', '1', 'BoolConfigHandler', 0, 0, ''),
(23, 'task panel', 'tasksShowTags', '1', 'BoolConfigHandler', 1, 0, ''),
(24, 'task panel', 'tasksShowEmptyMilestones', '1', 'BoolConfigHandler', 1, 0, ''),
(25, 'task panel', 'tasksPreviousPendingTasks', '1', 'BoolConfigHandler', 1, 0, ''),
(26, 'task panel', 'tasksGroupBy', 'due_date', 'StringConfigHandler', 1, 0, ''),
(27, 'task panel', 'tasksOrderBy', 'priority', 'StringConfigHandler', 1, 0, ''),
(28, 'task panel', 'task panel status', '1', 'IntegerConfigHandler', 1, 0, ''),
(29, 'task panel', 'task panel filter', 'assigned_to', 'StringConfigHandler', 1, 0, ''),
(30, 'task panel', 'task panel filter value', '0', 'UserCompanyConfigHandler', 1, 0, ''),
(31, 'task panel', 'noOfTasks', '15', 'IntegerConfigHandler', 0, 100, NULL),
(32, 'task panel', 'task_display_limit', '500', 'IntegerConfigHandler', 0, 200, NULL),
(33, 'task panel', 'pushUseWorkingDays', '1', 'BoolConfigHandler', 1, 0, NULL),
(34, 'task panel', 'zoom in gantt', '3', 'IntegerConfigHandler', 1, 0, ''),
(35, 'task panel', 'tasksShowDimensionCols', '', 'StringConfigHandler', 1, 0, ''),
(36, 'general', 'listingContactsBy', '0', 'BoolConfigHandler', 0, 0, NULL),
(37, 'general', 'localization', '', 'LocalizationConfigHandler', 0, 100, ''),
(38, 'general', 'search_engine', 'match', 'SearchEngineConfigHandler', 0, 700, ''),
(39, 'general', 'lastAccessedWorkspace', '0', 'IntegerConfigHandler', 1, 0, ''),
(40, 'general', 'work_day_start_time', '9:00', 'TimeConfigHandler', 0, 400, 'Work day start time'),
(41, 'general', 'work_day_end_time', '18:00', 'TimeConfigHandler', 0, 410, 'Work day end time'),
(42, 'general', 'time_format_use_24', '0', 'BoolConfigHandler', 0, 500, 'Use 24 hours time format'),
(43, 'general', 'date_format', 'd/m/Y', 'DateFormatConfigHandler', 0, 600, 'Date objects will be displayed using this format.'),
(44, 'general', 'descriptive_date_format', 'F j, Y (l)', 'StringConfigHandler', 0, 700, 'Descriptive dates will be displayed using this format.'),
(45, 'general', 'custom_report_tab', '5', 'StringConfigHandler', 1, 0, NULL),
(46, 'general', 'last_mail_format', 'html', 'StringConfigHandler', 1, 0, NULL),
(47, 'general', 'amount_objects_to_show', '5', 'IntegerConfigHandler', 0, 0, NULL),
(48, 'general', 'reset_password', '', 'StringConfigHandler', 1, 0, 'Used to store per-user tokens to validate password reset requests'),
(49, 'general', 'autodetect_time_zone', '1', 'BoolConfigHandler', 0, 0, NULL),
(50, 'general', 'detect_mime_type_from_extension', '0', 'BoolConfigHandler', 0, 0, NULL),
(51, 'general', 'root_dimensions', ',2', 'RootDimensionsConfigHandler', 0, 0, NULL),
(52, 'general', 'show_object_direct_url', '0', 'BoolConfigHandler', 0, 0, NULL),
(53, 'general', 'drag_drop_prompt', 'prompt', 'DragDropPromptConfigHandler', 0, 0, NULL),
(54, 'general', 'notify_myself_too', '0', 'BoolConfigHandler', 0, 100, ''),
(55, 'calendar panel', 'calendar view type', 'viewweek', 'StringConfigHandler', 1, 0, ''),
(56, 'calendar panel', 'calendar user filter', '0', 'IntegerConfigHandler', 1, 0, ''),
(57, 'calendar panel', 'calendar status filter', '', 'StringConfigHandler', 1, 0, ''),
(58, 'calendar panel', 'start_monday', '', 'BoolConfigHandler', 0, 0, ''),
(59, 'calendar panel', 'show_week_numbers', '', 'BoolConfigHandler', 0, 0, ''),
(60, 'calendar panel', 'show_birthdays_in_calendar', '1', 'BoolConfigHandler', 0, 0, ''),
(61, 'calendar panel', 'show_multiple_color_events', '1', 'BoolConfigHandler', 0, 0, ''),
(62, 'context help', 'show_tasks_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(63, 'context help', 'show_account_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(64, 'context help', 'show_active_tasks_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(65, 'context help', 'show_general_timeslots_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(66, 'context help', 'show_late_tasks_widget_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(67, 'context help', 'show_pending_tasks_widget_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(68, 'context help', 'show_documents_widget_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(69, 'context help', 'show_active_tasks_widget_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(70, 'context help', 'show_calendar_widget_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(71, 'context help', 'show_messages_widget_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(72, 'context help', 'show_dashboard_info_widget_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(73, 'context help', 'show_comments_widget_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(74, 'context help', 'show_emails_widget_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(75, 'context help', 'show_reporting_panel_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(76, 'context help', 'show_add_file_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(77, 'context help', 'show_administration_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(78, 'context help', 'show_member_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(79, 'context help', 'show_add_contact_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(80, 'context help', 'show_add_company_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(81, 'context help', 'show_upload_file_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(82, 'context help', 'show_upload_file_workspace_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(83, 'context help', 'show_upload_file_tags_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(84, 'context help', 'show_upload_file_description_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(85, 'context help', 'show_upload_file_custom_properties_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(86, 'context help', 'show_upload_file_subscribers_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(87, 'context help', 'show_upload_file_linked_objects_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(88, 'context help', 'show_add_note_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(89, 'context help', 'show_add_note_workspace_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(90, 'context help', 'show_add_note_tags_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(91, 'context help', 'show_add_note_custom_properties_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(92, 'context help', 'show_add_note_subscribers_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(93, 'context help', 'show_add_note_linked_object_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(94, 'context help', 'show_add_milestone_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(95, 'context help', 'show_add_milestone_workspace_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(96, 'context help', 'show_add_milestone_tags_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(97, 'context help', 'show_add_milestone_description_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(98, 'context help', 'show_add_milestone_reminders_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(99, 'context help', 'show_add_milestone_custom_properties_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(100, 'context help', 'show_add_milestone_linked_object_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(101, 'context help', 'show_add_milestone_subscribers_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(102, 'context help', 'show_add_workspace_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(103, 'context help', 'show_print_report_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(104, 'context help', 'show_add_task_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(105, 'context help', 'show_add_task_workspace_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(106, 'context help', 'show_add_task_tags_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(107, 'context help', 'show_add_task_reminders_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(108, 'context help', 'show_add_task_custom_properties_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(109, 'context help', 'show_add_task_linked_objects_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(110, 'context help', 'show_add_task_subscribers_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(111, 'context help', 'show_list_task_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(112, 'context help', 'show_time_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(113, 'context help', 'show_add_webpage_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(114, 'context help', 'show_add_webpage_workspace_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(115, 'context help', 'show_add_webpage_tags_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(116, 'context help', 'show_add_webpage_description_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(117, 'context help', 'show_add_webpage_custom_properties_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(118, 'context help', 'show_add_webpage_subscribers_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(119, 'context help', 'show_add_webpage_linked_objects_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(120, 'context help', 'show_add_event_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(121, 'context help', 'show_add_event_workspace_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(122, 'context help', 'show_add_event_tag_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(123, 'context help', 'show_add_event_description_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(124, 'context help', 'show_add_event_repeat_options_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(125, 'context help', 'show_add_event_reminders_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(126, 'context help', 'show_add_event_custom_properties_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(127, 'context help', 'show_add_event_subscribers_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(128, 'context help', 'show_add_event_linked_objects_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(129, 'context help', 'show_add_event_inivitation_context_help', '1', 'BoolConfigHandler', 1, 0, NULL),
(130, 'time panel', 'TM show time type', '0', 'IntegerConfigHandler', 1, 0, ''),
(131, 'time panel', 'TM report show time type', '0', 'IntegerConfigHandler', 1, 0, ''),
(132, 'time panel', 'TM user filter', '0', 'IntegerConfigHandler', 1, 0, ''),
(133, 'time panel', 'TM tasks user filter', '0', 'IntegerConfigHandler', 1, 0, ''),
(134, 'time panel', 'add_timeslot_view_dimensions_combos', '2,3,', 'ManageableDimensionsConfigHandler', 0, 0, 'dimensions ids for skip'),
(135, 'general', 'show_context_help', 'until_close', 'ShowContextHelpConfigHandler', 0, 0, NULL),
(136, 'dashboard', 'show charts widget', '1', 'BoolConfigHandler', 0, 600, ''),
(137, 'dashboard', 'show dashboard info widget', '1', 'BoolConfigHandler', 0, 900, ''),
(138, 'general', 'rememberGUIState', '1', 'RememberGUIConfigHandler', 0, 300, ''),
(139, 'calendar panel', 'calendar task filter', 'pending', 'StringConfigHandler', 1, 0, ''),
(140, 'task panel', 'close timeslot open', '1', 'BoolConfigHandler', 0, 0, ''),
(141, 'calendar panel', 'reminders_events', 'reminder_email,1,60', 'StringConfigHandler', 0, 0, NULL),
(142, 'dashboard', 'filters_dashboard', '0,0,10,0', 'StringConfigHandler', 0, 0, 'first position: entry to see the dimension, second position: view timeslot, third position: recent activities to show, fourth position: view views and downloads'),
(143, 'task panel', 'reminders_tasks', 'reminder_email,1,1440', 'StringConfigHandler', 0, 23, NULL),
(144, 'task panel', 'add_task_autoreminder', '0', 'BoolConfigHandler', 0, 21, NULL),
(145, 'task panel', 'add_self_task_autoreminder', '1', 'BoolConfigHandler', 0, 22, NULL),
(146, 'task panel', 'add_task_default_reminder', '1', 'BoolConfigHandler', 0, 20, NULL),
(147, 'task panel', 'quick_add_task_view_dimensions_combos', '2,3,', 'ManageableDimensionsConfigHandler', 0, 0, 'dimensions ids for skip'),
(148, 'calendar panel', 'add_event_autoreminder', '1', 'BoolConfigHandler', 0, 0, NULL),
(149, 'calendar panel', 'autoassign_events', '0', 'BoolConfigHandler', 0, 0, NULL),
(150, 'calendar panel', 'event_send_invitations', '1', 'BoolConfigHandler', 0, 0, NULL),
(151, 'calendar panel', 'event_subscribe_invited', '1', 'BoolConfigHandler', 0, 0, NULL),
(152, 'mails panel', 'mails_per_page', '50', 'IntegerConfigHandler', 0, 0, NULL),
(153, 'mails panel', 'attach_to_notification', '1', 'BoolConfigHandler', 0, 0, NULL),
(154, 'general', 'access_member_after_add', '1', 'BoolConfigHandler', 0, 1300, NULL),
(155, 'general', 'access_member_after_add_remember', '0', 'BoolConfigHandler', 0, 1301, NULL),
(156, 'general', 'sendEmailNotification', '1', 'BoolConfigHandler', 1, 0, 'Send email notification to new user'),
(157, 'general', 'viewContactsChecked', '1', 'BoolConfigHandler', 1, 0, 'in people panel is view contacts checked'),
(158, 'general', 'viewUsersChecked', '1', 'BoolConfigHandler', 1, 0, 'in people panel is view users checked'),
(159, 'general', 'viewCompaniesChecked', '1', 'BoolConfigHandler', 1, 0, 'in people panel is view companies checked'),
(160, 'general', 'updateOnLinkedObjects', '1', 'BoolConfigHandler', 0, 0, 'Update objects when linking others'),
(161, 'dashboard', 'overviewAsList', '0', 'BoolConfigHandler', 1, 0, 'View Overview as list'),
(162, 'general', 'contacts_per_page', '50', 'IntegerConfigHandler', 0, 1200, NULL),
(163, 'listing preferences', 'breadcrumb_member_count', '5', 'IntegerConfigHandler', 0, 5, NULL),
(164, 'general', 'timeReportDate', '4', 'IntegerConfigHandler', 1, 0, ''),
(165, 'general', 'timeReportDateStart', '0000-00-00 00:00:00', 'DateTimeConfigHandler', 1, 0, ''),
(166, 'general', 'timeReportDateEnd', '0000-00-00 00:00:00', 'DateTimeConfigHandler', 1, 0, ''),
(167, 'general', 'timeReportPerson', '0', 'IntegerConfigHandler', 1, 0, ''),
(168, 'general', 'timeReportTimeslotType', '2', 'IntegerConfigHandler', 1, 0, ''),
(169, 'general', 'timeReportGroupBy', '0,0,0', 'StringConfigHandler', 1, 0, ''),
(170, 'general', 'timeReportAltGroupBy', '0,0,0', 'StringConfigHandler', 1, 0, ''),
(171, 'general', 'timeReportShowEstimatedTime', '1', 'BoolConfigHandler', 1, 0, ''),
(172, 'general', 'can_modify_navigation_panel', '1', 'BoolConfigHandler', 1, 0, ''),
(173, 'general', 'view_mail_attachs_expanded', '1', 'BoolConfigHandler', 1, 0, ''),
(174, 'general', 'timeReportShowBilling', '0', 'BoolConfigHandler', 1, 0, ''),
(175, 'general', 'settings_closed', '0', 'BoolConfigHandler', 1, 0, ''),
(176, 'mails panel', 'view deleted accounts emails', '1', 'BoolConfigHandler', 0, 0, NULL),
(177, 'mails panel', 'check_is_defult_account', '1', 'BoolConfigHandler', 0, 0, NULL),
(178, 'mails panel', 'block_email_images', '1', 'BoolConfigHandler', 0, 0, NULL),
(179, 'mails panel', 'draft_autosave_timeout', '60', 'IntegerConfigHandler', 0, 100, NULL),
(180, 'mails panel', 'attach_docs_content', '1', 'BoolConfigHandler', 0, 0, NULL),
(181, 'mails panel', 'email_polling', '0', 'IntegerConfigHandler', 1, 0, NULL),
(182, 'mails panel', 'show_unread_on_title', '0', 'BoolConfigHandler', 1, 0, NULL),
(183, 'mails panel', 'max_spam_level', '0', 'IntegerConfigHandler', 0, 100, NULL),
(184, 'mails panel', 'create_contacts_from_email_recipients', '0', 'BoolConfigHandler', 0, 101, NULL),
(185, 'mails panel', 'mail_drag_drop_prompt', 'prompt', 'MailDragDropPromptConfigHandler', 0, 102, NULL),
(186, 'mails panel', 'auto_classify_attachments', '1', 'BoolConfigHandler', 0, 103, NULL),
(187, 'mails panel', 'show_emails_as_conversations', '0', 'BoolConfigHandler', 0, 0, NULL),
(188, 'mails panel', 'mails account filter', '', 'StringConfigHandler', 1, 0, NULL),
(189, 'mails panel', 'mails classification filter', 'all', 'StringConfigHandler', 1, 0, NULL),
(190, 'mails panel', 'mails read filter', 'all', 'StringConfigHandler', 1, 0, NULL),
(191, 'mails panel', 'hide_quoted_text_in_emails', '1', 'BoolConfigHandler', 0, 110, NULL),
(192, 'mails panel', 'mail_account_err_check_interval', '300', 'IntegerConfigHandler', 0, 120, NULL),
(193, 'mails panel', 'classify_mail_with_conversation', '1', 'BoolConfigHandler', 0, 130, NULL),
(194, 'mails panel', 'folder_received_columns', 'from,subject,account,date,folder,actions', 'StringConfigHandler', 1, 0, NULL),
(195, 'mails panel', 'folder_sent_columns', 'to,subject,account,date,folder,actions', 'StringConfigHandler', 1, 0, NULL),
(196, 'mails panel', 'folder_draft_columns', 'to,subject,account,date,folder,actions', 'StringConfigHandler', 1, 0, NULL),
(197, 'mails panel', 'folder_junk_columns', 'from,subject,account,date,folder,actions', 'StringConfigHandler', 1, 0, NULL),
(198, 'mails panel', 'folder_outbox_columns', 'to,subject,account,date,folder,actions', 'StringConfigHandler', 1, 0, NULL),
(199, 'mails panel', 'check_attach_word', '1', 'BoolConfigHandler', 0, 0, NULL),
(200, 'listing preferences', 'lp_dim_workspaces_show_as_column', '1', 'BoolConfigHandler', 0, 0, NULL),
(201, 'listing preferences', 'lp_dim_tags_show_as_column', '1', 'BoolConfigHandler', 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `fo_contact_config_option_values`
--

CREATE TABLE IF NOT EXISTS `fo_contact_config_option_values` (
  `option_id` int(10) unsigned NOT NULL DEFAULT '0',
  `contact_id` int(10) unsigned NOT NULL DEFAULT '0',
  `value` text COLLATE utf8_unicode_ci,
  `member_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`option_id`,`contact_id`,`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `fo_contact_config_option_values`
--

INSERT INTO `fo_contact_config_option_values` (`option_id`, `contact_id`, `value`, `member_id`) VALUES
(27, 2, 'priority', 0),
(28, 2, '2', 0);

-- --------------------------------------------------------

--
-- Table structure for table `fo_contact_dimension_permissions`
--

CREATE TABLE IF NOT EXISTS `fo_contact_dimension_permissions` (
  `permission_group_id` int(10) unsigned NOT NULL,
  `dimension_id` int(10) unsigned NOT NULL,
  `permission_type` enum('allow all','deny all','check') COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`permission_group_id`,`dimension_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `fo_contact_dimension_permissions`
--

INSERT INTO `fo_contact_dimension_permissions` (`permission_group_id`, `dimension_id`, `permission_type`) VALUES
(1, 2, 'allow all'),
(14, 1, 'allow all'),
(14, 2, 'allow all');

-- --------------------------------------------------------

--
-- Table structure for table `fo_contact_emails`
--

CREATE TABLE IF NOT EXISTS `fo_contact_emails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contact_id` int(10) unsigned NOT NULL,
  `email_type_id` int(10) unsigned NOT NULL,
  `email_address` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_main` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `by_contact` (`contact_id`,`is_main`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `fo_contact_emails`
--

INSERT INTO `fo_contact_emails` (`id`, `contact_id`, `email_type_id`, `email_address`, `is_main`) VALUES
(1, 2, 2, 'admin@admin.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `fo_contact_im_values`
--

CREATE TABLE IF NOT EXISTS `fo_contact_im_values` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contact_id` int(10) unsigned NOT NULL,
  `im_type_id` int(10) unsigned NOT NULL,
  `value` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_main` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `by_contact` (`contact_id`,`is_main`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_contact_member_cache`
--

CREATE TABLE IF NOT EXISTS `fo_contact_member_cache` (
  `contact_id` int(10) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `parent_member_id` int(10) unsigned NOT NULL DEFAULT '0',
  `last_activity` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`contact_id`,`member_id`),
  KEY `by_contact` (`contact_id`) USING HASH,
  KEY `by_parent` (`parent_member_id`) USING HASH,
  KEY `last_activity` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_contact_member_permissions`
--

CREATE TABLE IF NOT EXISTS `fo_contact_member_permissions` (
  `permission_group_id` int(10) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `object_type_id` int(10) unsigned NOT NULL,
  `can_write` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_delete` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`permission_group_id`,`member_id`,`object_type_id`),
  KEY `member_id` (`member_id`),
  KEY `obj_type` (`object_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `fo_contact_member_permissions`
--

INSERT INTO `fo_contact_member_permissions` (`permission_group_id`, `member_id`, `object_type_id`, `can_write`, `can_delete`) VALUES
(14, 0, 3, 1, 1),
(14, 0, 4, 1, 1),
(14, 0, 5, 1, 1),
(14, 0, 6, 1, 1),
(14, 0, 9, 1, 1),
(14, 0, 10, 1, 1),
(14, 0, 11, 1, 1),
(14, 0, 15, 1, 1),
(14, 0, 17, 1, 1),
(14, 1, 3, 1, 1),
(14, 1, 4, 1, 1),
(14, 1, 5, 1, 1),
(14, 1, 6, 1, 1),
(14, 1, 9, 1, 1),
(14, 1, 10, 1, 1),
(14, 1, 11, 1, 1),
(14, 1, 12, 1, 1),
(14, 1, 13, 1, 1),
(14, 1, 15, 1, 1),
(14, 1, 16, 1, 1),
(14, 1, 17, 1, 1),
(14, 1, 18, 1, 1),
(14, 1, 19, 1, 1),
(14, 1, 22, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `fo_contact_passwords`
--

CREATE TABLE IF NOT EXISTS `fo_contact_passwords` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `contact_id` int(10) NOT NULL,
  `password` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `password_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `fo_contact_passwords`
--

INSERT INTO `fo_contact_passwords` (`id`, `contact_id`, `password`, `password_date`) VALUES
(1, 2, 'DwVUBAJWA1RTXFEDVRNRRUpPDUFQ', '2015-08-26 10:29:09');

-- --------------------------------------------------------

--
-- Table structure for table `fo_contact_permission_groups`
--

CREATE TABLE IF NOT EXISTS `fo_contact_permission_groups` (
  `contact_id` int(10) unsigned NOT NULL,
  `permission_group_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`contact_id`,`permission_group_id`),
  KEY `contact_id` (`contact_id`),
  KEY `permission_group_id` (`permission_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `fo_contact_permission_groups`
--

INSERT INTO `fo_contact_permission_groups` (`contact_id`, `permission_group_id`) VALUES
(2, 14);

-- --------------------------------------------------------

--
-- Table structure for table `fo_contact_telephones`
--

CREATE TABLE IF NOT EXISTS `fo_contact_telephones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contact_id` int(10) unsigned NOT NULL,
  `telephone_type_id` int(10) unsigned NOT NULL,
  `number` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `name` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_main` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `by_contact` (`contact_id`,`is_main`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_contact_web_pages`
--

CREATE TABLE IF NOT EXISTS `fo_contact_web_pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contact_id` int(10) unsigned NOT NULL,
  `web_type_id` int(10) unsigned NOT NULL,
  `url` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `by_contact` (`contact_id`,`web_type_id`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_contact_widgets`
--

CREATE TABLE IF NOT EXISTS `fo_contact_widgets` (
  `widget_name` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `contact_id` int(11) NOT NULL,
  `section` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `order` int(11) NOT NULL,
  `options` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`widget_name`,`contact_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_contact_widget_options`
--

CREATE TABLE IF NOT EXISTS `fo_contact_widget_options` (
  `widget_name` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `contact_id` int(11) NOT NULL,
  `member_type_id` int(11) NOT NULL DEFAULT '0',
  `option` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `config_handler_class` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `is_system` tinyint(1) unsigned DEFAULT '0',
  PRIMARY KEY (`widget_name`,`contact_id`,`member_type_id`,`option`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `fo_contact_widget_options`
--

INSERT INTO `fo_contact_widget_options` (`widget_name`, `contact_id`, `member_type_id`, `option`, `value`, `config_handler_class`, `is_system`) VALUES
('calendar', 0, 0, 'filter_by_myself', '1', 'BooleanConfigHandler', 0),
('overdue_upcoming', 0, 0, 'assigned_to_user', '0', 'UserCompanyConfigHandler', 0);

-- --------------------------------------------------------

--
-- Table structure for table `fo_cron_events`
--

CREATE TABLE IF NOT EXISTS `fo_cron_events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `recursive` tinyint(1) NOT NULL DEFAULT '1',
  `delay` int(10) unsigned NOT NULL DEFAULT '0',
  `is_system` tinyint(1) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=13 ;

--
-- Dumping data for table `fo_cron_events`
--

INSERT INTO `fo_cron_events` (`id`, `name`, `recursive`, `delay`, `is_system`, `enabled`, `date`) VALUES
(1, 'purge_trash', 1, 1440, 1, 1, '0000-00-00 00:00:00'),
(2, 'send_reminders', 1, 10, 0, 1, '0000-00-00 00:00:00'),
(3, 'send_password_expiration_reminders', 1, 1440, 1, 1, '0000-00-00 00:00:00'),
(4, 'send_notifications_through_cron', 1, 1, 0, 0, '0000-00-00 00:00:00'),
(5, 'delete_mails_from_server', 1, 1440, 1, 1, '0000-00-00 00:00:00'),
(6, 'clear_tmp_folder', 1, 1440, 1, 1, '0000-00-00 00:00:00'),
(7, 'check_upgrade', 1, 1440, 1, 0, '0000-00-00 00:00:00'),
(8, 'import_google_calendar', 1, 10, 0, 0, '0000-00-00 00:00:00'),
(9, 'export_google_calendar', 1, 10, 0, 0, '0000-00-00 00:00:00'),
(10, 'sharing_table_partial_rebuild', 1, 1440, 1, 1, '0000-00-00 00:00:00'),
(11, 'check_sharing_table_flags', 1, 10, 1, 1, '0000-00-00 00:00:00'),
(12, 'check_mail', 1, 10, 0, 1, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `fo_custom_properties`
--

CREATE TABLE IF NOT EXISTS `fo_custom_properties` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `object_type_id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `values` text COLLATE utf8_unicode_ci NOT NULL,
  `default_value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `is_required` tinyint(1) NOT NULL,
  `is_multiple_values` tinyint(1) NOT NULL,
  `property_order` int(10) NOT NULL,
  `visible_by_default` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_custom_property_values`
--

CREATE TABLE IF NOT EXISTS `fo_custom_property_values` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `object_id` int(10) NOT NULL,
  `custom_property_id` int(10) NOT NULL,
  `value` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_dimensions`
--

CREATE TABLE IF NOT EXISTS `fo_dimensions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_root` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_manageable` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `allows_multiple_selection` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `defines_permissions` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_system` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `default_order` int(10) NOT NULL DEFAULT '0',
  `options` text COLLATE utf8_unicode_ci NOT NULL,
  `permission_query_method` enum('mandatory','not_mandatory') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'mandatory',
  `is_required` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`) USING BTREE,
  KEY `by_name` (`name`),
  KEY `defines_perm` (`defines_permissions`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `fo_dimensions`
--

INSERT INTO `fo_dimensions` (`id`, `code`, `name`, `is_root`, `is_manageable`, `allows_multiple_selection`, `defines_permissions`, `is_system`, `is_default`, `default_order`, `options`, `permission_query_method`, `is_required`) VALUES
(1, 'feng_persons', 'People', 1, 0, 0, 1, 1, 0, 99, '{"useLangs":true,"defaultAjax":{"controller":"dashboard", "action": "main_dashboard"},"quickAdd":{"formAction":"?c=contact&a=quick_add"}}', 'not_mandatory', 0),
(2, 'workspaces', 'Workspaces', 1, 1, 0, 1, 1, 0, 2, '{"defaultAjax":{"controller":"dashboard", "action": "main_dashboard"}, "quickAdd":true,"showInPaths":true,"useLangs":true}', 'mandatory', 0),
(3, 'tags', 'Tags', 1, 1, 0, 0, 1, 0, 3, '{"defaultAjax":{"controller":"dashboard", "action": "main_dashboard"},"quickAdd":true,"showInPaths":true,"useLangs":true}', 'not_mandatory', 0);

-- --------------------------------------------------------

--
-- Table structure for table `fo_dimension_member_associations`
--

CREATE TABLE IF NOT EXISTS `fo_dimension_member_associations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dimension_id` int(10) unsigned NOT NULL,
  `object_type_id` int(10) unsigned NOT NULL,
  `associated_dimension_id` int(10) unsigned NOT NULL,
  `associated_object_type_id` int(10) unsigned NOT NULL,
  `is_required` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_multiple` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `keeps_record` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `by_associated` (`associated_dimension_id`,`associated_object_type_id`) USING HASH,
  KEY `by_dimension_objtype` (`dimension_id`,`object_type_id`) USING HASH
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `fo_dimension_member_associations`
--

INSERT INTO `fo_dimension_member_associations` (`id`, `dimension_id`, `object_type_id`, `associated_dimension_id`, `associated_object_type_id`, `is_required`, `is_multiple`, `keeps_record`) VALUES
(1, 2, 1, 1, 20, 0, 1, 0),
(2, 2, 1, 1, 21, 0, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `fo_dimension_member_restriction_definitions`
--

CREATE TABLE IF NOT EXISTS `fo_dimension_member_restriction_definitions` (
  `dimension_id` int(10) unsigned NOT NULL,
  `object_type_id` int(10) unsigned NOT NULL,
  `restricted_dimension_id` int(10) unsigned NOT NULL,
  `restricted_object_type_id` int(10) unsigned NOT NULL,
  `is_orderable` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `enforce_order_progression` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_required` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`dimension_id`,`object_type_id`,`restricted_dimension_id`,`restricted_object_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_dimension_object_types`
--

CREATE TABLE IF NOT EXISTS `fo_dimension_object_types` (
  `dimension_id` int(10) unsigned NOT NULL,
  `object_type_id` int(10) unsigned NOT NULL,
  `is_root` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `options` text COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`dimension_id`,`object_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `fo_dimension_object_types`
--

INSERT INTO `fo_dimension_object_types` (`dimension_id`, `object_type_id`, `is_root`, `options`, `enabled`) VALUES
(1, 20, 1, '{"defaultAjax":{"controller":"contact", "action": "card"}}', 1),
(1, 21, 1, '{"defaultAjax":{"controller":"contact", "action": "company_card"}}', 1),
(2, 1, 1, '{"defaultAjax":{"controller":"dashboard", "action": "main_dashboard"}}', 1),
(3, 2, 1, '{"defaultAjax":{"controller":"dashboard", "action": "main_dashboard"}}', 1);

-- --------------------------------------------------------

--
-- Table structure for table `fo_dimension_object_type_contents`
--

CREATE TABLE IF NOT EXISTS `fo_dimension_object_type_contents` (
  `dimension_id` int(10) unsigned NOT NULL,
  `dimension_object_type_id` int(10) unsigned NOT NULL,
  `content_object_type_id` int(10) unsigned NOT NULL,
  `is_required` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_multiple` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`dimension_id`,`dimension_object_type_id`,`content_object_type_id`),
  KEY `by_co_obj_type` (`content_object_type_id`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `fo_dimension_object_type_contents`
--

INSERT INTO `fo_dimension_object_type_contents` (`dimension_id`, `dimension_object_type_id`, `content_object_type_id`, `is_required`, `is_multiple`) VALUES
(1, 20, 3, 0, 1),
(1, 20, 4, 0, 1),
(1, 20, 5, 0, 1),
(1, 20, 6, 0, 1),
(1, 20, 9, 0, 1),
(1, 20, 10, 0, 1),
(1, 20, 11, 0, 1),
(1, 20, 12, 0, 1),
(1, 20, 13, 0, 1),
(1, 20, 15, 0, 1),
(1, 20, 16, 0, 1),
(1, 20, 17, 0, 1),
(1, 20, 18, 0, 1),
(1, 20, 19, 0, 1),
(1, 20, 22, 0, 1),
(1, 21, 3, 0, 1),
(1, 21, 4, 0, 1),
(1, 21, 5, 0, 1),
(1, 21, 6, 0, 1),
(1, 21, 9, 0, 1),
(1, 21, 10, 0, 1),
(1, 21, 11, 0, 1),
(1, 21, 12, 0, 1),
(1, 21, 13, 0, 1),
(1, 21, 15, 0, 1),
(1, 21, 16, 0, 1),
(1, 21, 17, 0, 1),
(1, 21, 18, 0, 1),
(1, 21, 19, 0, 1),
(1, 21, 22, 0, 1),
(2, 1, 3, 0, 1),
(2, 1, 4, 0, 1),
(2, 1, 5, 0, 1),
(2, 1, 6, 0, 1),
(2, 1, 9, 0, 1),
(2, 1, 10, 0, 1),
(2, 1, 11, 0, 1),
(2, 1, 12, 0, 1),
(2, 1, 13, 0, 1),
(2, 1, 15, 0, 1),
(2, 1, 16, 0, 1),
(2, 1, 17, 0, 1),
(2, 1, 18, 0, 1),
(2, 1, 19, 0, 1),
(2, 1, 22, 0, 1),
(3, 2, 3, 0, 1),
(3, 2, 4, 0, 1),
(3, 2, 5, 0, 1),
(3, 2, 6, 0, 1),
(3, 2, 9, 0, 1),
(3, 2, 10, 0, 1),
(3, 2, 11, 0, 1),
(3, 2, 12, 0, 1),
(3, 2, 13, 0, 1),
(3, 2, 15, 0, 1),
(3, 2, 16, 0, 1),
(3, 2, 17, 0, 1),
(3, 2, 18, 0, 1),
(3, 2, 19, 0, 1),
(3, 2, 22, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `fo_dimension_object_type_hierarchies`
--

CREATE TABLE IF NOT EXISTS `fo_dimension_object_type_hierarchies` (
  `dimension_id` int(10) unsigned NOT NULL,
  `parent_object_type_id` int(10) unsigned NOT NULL,
  `child_object_type_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`dimension_id`,`parent_object_type_id`,`child_object_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `fo_dimension_object_type_hierarchies`
--

INSERT INTO `fo_dimension_object_type_hierarchies` (`dimension_id`, `parent_object_type_id`, `child_object_type_id`) VALUES
(1, 21, 20),
(2, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `fo_dimension_object_type_options`
--

CREATE TABLE IF NOT EXISTS `fo_dimension_object_type_options` (
  `dimension_id` int(10) unsigned NOT NULL,
  `object_type_id` int(10) unsigned NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`dimension_id`,`object_type_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `fo_dimension_object_type_options`
--

INSERT INTO `fo_dimension_object_type_options` (`dimension_id`, `object_type_id`, `name`, `value`) VALUES
(2, 1, 'select_after_creation', '1'),
(3, 1, 'select_after_creation', '1');

-- --------------------------------------------------------

--
-- Table structure for table `fo_dimension_options`
--

CREATE TABLE IF NOT EXISTS `fo_dimension_options` (
  `dimension_id` int(10) unsigned NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`dimension_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `fo_dimension_options`
--

INSERT INTO `fo_dimension_options` (`dimension_id`, `name`, `value`) VALUES
(1, 'useLangs', '1'),
(2, 'showInPaths', '1'),
(2, 'useLangs', '1'),
(3, 'showInPaths', '1'),
(3, 'useLangs', '1');

-- --------------------------------------------------------

--
-- Table structure for table `fo_email_types`
--

CREATE TABLE IF NOT EXISTS `fo_email_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_system` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `fo_email_types`
--

INSERT INTO `fo_email_types` (`id`, `name`, `is_system`) VALUES
(1, 'user', 1),
(2, 'personal', 1),
(3, 'work', 1),
(4, 'other', 1);

-- --------------------------------------------------------

--
-- Table structure for table `fo_event_invitations`
--

CREATE TABLE IF NOT EXISTS `fo_event_invitations` (
  `event_id` int(10) unsigned NOT NULL DEFAULT '0',
  `contact_id` int(10) unsigned NOT NULL DEFAULT '0',
  `invitation_state` int(10) unsigned NOT NULL DEFAULT '0',
  `synced` int(1) DEFAULT '0',
  `special_id` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`event_id`,`contact_id`),
  KEY `contact_id` (`contact_id`,`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_external_calendars`
--

CREATE TABLE IF NOT EXISTS `fo_external_calendars` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ext_cal_user_id` int(10) unsigned NOT NULL,
  `original_calendar_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `calendar_visibility` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `calendar_name` text COLLATE utf8_unicode_ci NOT NULL,
  `calendar_feng` tinyint(1) NOT NULL DEFAULT '0',
  `sync` tinyint(1) NOT NULL DEFAULT '0',
  `related_to` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_external_calendar_properties`
--

CREATE TABLE IF NOT EXISTS `fo_external_calendar_properties` (
  `external_calendar_id` int(10) unsigned NOT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`external_calendar_id`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_external_calendar_users`
--

CREATE TABLE IF NOT EXISTS `fo_external_calendar_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contact_id` int(10) unsigned NOT NULL,
  `auth_user` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `auth_pass` text COLLATE utf8_unicode_ci NOT NULL,
  `type` text COLLATE utf8_unicode_ci NOT NULL,
  `sync` tinyint(1) DEFAULT '0',
  `related_to` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_file_repo`
--

CREATE TABLE IF NOT EXISTS `fo_file_repo` (
  `id` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `content` longblob NOT NULL,
  `order` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `order` (`order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_file_repo_attributes`
--

CREATE TABLE IF NOT EXISTS `fo_file_repo_attributes` (
  `id` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `attribute` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`,`attribute`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_file_types`
--

CREATE TABLE IF NOT EXISTS `fo_file_types` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `extension` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `icon` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_searchable` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_image` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_allow` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `extension` (`extension`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=36 ;

--
-- Dumping data for table `fo_file_types`
--

INSERT INTO `fo_file_types` (`id`, `extension`, `icon`, `is_searchable`, `is_image`, `is_allow`) VALUES
(1, 'zip', 'archive.png', 0, 0, 1),
(2, 'rar', 'archive.png', 0, 0, 1),
(3, 'bz', 'archive.png', 0, 0, 1),
(4, 'bz2', 'archive.png', 0, 0, 1),
(5, 'gz', 'archive.png', 0, 0, 1),
(6, 'ace', 'archive.png', 0, 0, 1),
(7, 'mp3', 'audio.png', 0, 0, 1),
(8, 'wma', 'audio.png', 0, 0, 1),
(9, 'ogg', 'audio.png', 0, 0, 1),
(10, 'doc', 'doc.png', 0, 0, 1),
(11, 'xls', 'xls.png', 0, 0, 1),
(12, 'docx', 'doc.png', 1, 0, 1),
(13, 'xlsx', 'xls.png', 0, 0, 1),
(14, 'gif', 'image.png', 0, 1, 1),
(15, 'jpg', 'image.png', 0, 1, 1),
(16, 'jpeg', 'image.png', 0, 1, 1),
(17, 'png', 'image.png', 0, 1, 1),
(18, 'mov', 'mov.png', 0, 0, 1),
(19, 'pdf', 'pdf.png', 1, 0, 1),
(20, 'psd', 'psd.png', 0, 0, 1),
(21, 'rm', 'rm.png', 0, 0, 1),
(22, 'svg', 'svg.png', 0, 0, 1),
(23, 'swf', 'swf.png', 0, 0, 1),
(24, 'avi', 'video.png', 0, 0, 1),
(25, 'mpeg', 'video.png', 0, 0, 1),
(26, 'mpg', 'video.png', 0, 0, 1),
(27, 'qt', 'mov.png', 0, 0, 1),
(28, 'vob', 'video.png', 0, 0, 1),
(29, 'txt', 'text.png', 1, 0, 1),
(30, 'html', 'html.png', 1, 0, 1),
(31, 'slim', 'ppt.png', 1, 0, 1),
(32, 'ppt', 'ppt.png', 0, 0, 1),
(33, 'webfile', 'webfile.png', 0, 0, 1),
(34, 'odt', 'doc.png', 0, 0, 1),
(35, 'fodt', 'doc.png', 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `fo_guistate`
--

CREATE TABLE IF NOT EXISTS `fo_guistate` (
  `contact_id` int(10) unsigned NOT NULL DEFAULT '1',
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`contact_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `fo_guistate`
--

INSERT INTO `fo_guistate` (`contact_id`, `name`, `value`) VALUES
(2, 'mails-manager', 'o%3Acolumns%3Da%253Ao%25253Aid%25253Ds%2525253Achecker%25255Ewidth%25253Dn%2525253A20%255Eo%25253Aid%25253Ds%2525253Aicon%25255Ewidth%25253Dn%2525253A28%255Eo%25253Aid%25253Ds%2525253AisRead%25255Ewidth%25253Dn%2525253A16%255Eo%25253Aid%25253Ds%2525253AhasAttachment%25255Ewidth%25253Dn%2525253A24%255Eo%25253Aid%25253Ds%2525253Afrom%25255Ewidth%25253Dn%2525253A172%255Eo%25253Aid%25253Ds%2525253Ato%25255Ewidth%25253Dn%2525253A200%25255Ehidden%25253Db%2525253A1%255Eo%25253Aid%25253Ds%2525253Asubject%25255Ewidth%25253Dn%2525253A359%255Eo%25253Aid%25253Ds%2525253Aaccount%25255Ewidth%25253Dn%2525253A86%255Eo%25253Aid%25253Ds%2525253Adate%25255Ewidth%25253Dn%2525253A86%255Eo%25253Aid%25253Ds%2525253Afolder%25255Ewidth%25253Dn%2525253A56%255Eo%25253Aid%25253Ds%2525253Aactions%25255Ewidth%25253Dn%2525253A60%255Eo%25253Aid%25253Ds%2525253Adim_2%25255Ewidth%25253Dn%2525253A143%255Eo%25253Aid%25253Ds%2525253Adim_3%25255Ewidth%25253Dn%2525253A143%5Esort%3Do%253Afield%253Ds%25253Adate%255Edirection%253Ds%25253ADESC'),
(2, 'menu-panel', 'o%3Acollapsed%3Db%253A1');

-- --------------------------------------------------------

--
-- Table structure for table `fo_historic_values`
--

CREATE TABLE IF NOT EXISTS `fo_historic_values` (
  `object_id` int(10) unsigned NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `value` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`object_id`,`created_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_im_types`
--

CREATE TABLE IF NOT EXISTS `fo_im_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `icon` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Dumping data for table `fo_im_types`
--

INSERT INTO `fo_im_types` (`id`, `name`, `icon`) VALUES
(1, 'ICQ', 'icq.gif'),
(2, 'AIM', 'aim.gif'),
(3, 'MSN', 'msn.gif'),
(4, 'Yahoo!', 'yahoo.gif'),
(5, 'Skype', 'skype.gif'),
(6, 'Jabber', 'jabber.gif');

-- --------------------------------------------------------

--
-- Table structure for table `fo_linked_objects`
--

CREATE TABLE IF NOT EXISTS `fo_linked_objects` (
  `rel_object_id` int(10) unsigned NOT NULL DEFAULT '0',
  `object_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`rel_object_id`,`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_mail_accounts`
--

CREATE TABLE IF NOT EXISTS `fo_mail_accounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contact_id` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `email` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `email_addr` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `password` varchar(40) COLLATE utf8_unicode_ci DEFAULT '',
  `server` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_imap` int(1) NOT NULL DEFAULT '0',
  `incoming_ssl` int(1) NOT NULL DEFAULT '0',
  `incoming_ssl_port` int(11) DEFAULT '995',
  `smtp_server` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `smtp_use_auth` int(10) unsigned NOT NULL DEFAULT '0',
  `smtp_username` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `smtp_password` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `smtp_port` int(10) unsigned NOT NULL DEFAULT '25',
  `del_from_server` int(11) NOT NULL DEFAULT '0',
  `mark_read_on_server` int(11) NOT NULL DEFAULT '1',
  `outgoing_transport_type` varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `last_checked` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `signature` text COLLATE utf8_unicode_ci NOT NULL,
  `sender_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `last_error_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_error_msg` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sync_addr` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `sync_pass` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `sync_server` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `sync_ssl` tinyint(1) NOT NULL DEFAULT '0',
  `sync_ssl_port` int(11) NOT NULL DEFAULT '993',
  `sync_folder` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `member_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `contact_id` (`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_mail_account_contacts`
--

CREATE TABLE IF NOT EXISTS `fo_mail_account_contacts` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `account_id` int(10) NOT NULL,
  `contact_id` int(10) NOT NULL,
  `can_edit` tinyint(1) NOT NULL DEFAULT '0',
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `signature` text COLLATE utf8_unicode_ci NOT NULL,
  `sender_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `last_error_state` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '0:no error,1:err unread, 2:err read',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_contactacc` (`account_id`,`contact_id`),
  KEY `ix_contact` (`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_mail_account_imap_folder`
--

CREATE TABLE IF NOT EXISTS `fo_mail_account_imap_folder` (
  `account_id` int(10) unsigned NOT NULL DEFAULT '0',
  `folder_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `check_folder` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`account_id`,`folder_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_mail_contents`
--

CREATE TABLE IF NOT EXISTS `fo_mail_contents` (
  `object_id` int(10) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL DEFAULT '0',
  `uid` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `from` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `from_name` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sent_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `received_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `has_attachments` int(1) NOT NULL DEFAULT '0',
  `size` int(10) NOT NULL DEFAULT '0',
  `state` int(1) NOT NULL DEFAULT '0' COMMENT '0:nothing, 1:sent, 2:draft',
  `is_deleted` int(1) NOT NULL DEFAULT '0',
  `is_shared` int(1) NOT NULL DEFAULT '0',
  `imap_folder_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `account_email` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `content_file_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `message_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Message-Id header',
  `in_reply_to_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Message-Id header of the previous email in the conversation',
  `conversation_id` int(10) unsigned NOT NULL DEFAULT '0',
  `conversation_last` int(1) NOT NULL DEFAULT '1',
  `sync` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`),
  KEY `account_id` (`account_id`,`uid`),
  KEY `sent_date` (`sent_date`),
  KEY `received_date` (`received_date`),
  KEY `uid` (`uid`),
  KEY `conversation_id` (`conversation_id`),
  KEY `message_id` (`message_id`),
  KEY `state` (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_mail_conversations`
--

CREATE TABLE IF NOT EXISTS `fo_mail_conversations` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_mail_datas`
--

CREATE TABLE IF NOT EXISTS `fo_mail_datas` (
  `id` int(10) unsigned NOT NULL,
  `to` text COLLATE utf8_unicode_ci NOT NULL,
  `cc` text COLLATE utf8_unicode_ci NOT NULL,
  `bcc` text COLLATE utf8_unicode_ci NOT NULL,
  `subject` text COLLATE utf8_unicode_ci,
  `content` text COLLATE utf8_unicode_ci,
  `body_plain` longtext COLLATE utf8_unicode_ci,
  `body_html` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_mail_spam_filters`
--

CREATE TABLE IF NOT EXISTS `fo_mail_spam_filters` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `text_type` enum('email_address','subject') COLLATE utf8_unicode_ci NOT NULL,
  `text` text COLLATE utf8_unicode_ci NOT NULL,
  `spam_state` enum('no spam','spam') COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_max_role_object_type_permissions`
--

CREATE TABLE IF NOT EXISTS `fo_max_role_object_type_permissions` (
  `role_id` int(10) unsigned NOT NULL,
  `object_type_id` int(10) unsigned NOT NULL,
  `can_delete` tinyint(1) NOT NULL,
  `can_write` tinyint(1) NOT NULL,
  PRIMARY KEY (`role_id`,`object_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `fo_max_role_object_type_permissions`
--

INSERT INTO `fo_max_role_object_type_permissions` (`role_id`, `object_type_id`, `can_delete`, `can_write`) VALUES
(1, 3, 1, 1),
(1, 4, 1, 1),
(1, 5, 1, 1),
(1, 6, 1, 1),
(1, 9, 1, 1),
(1, 10, 1, 1),
(1, 11, 1, 1),
(1, 15, 1, 1),
(1, 17, 1, 1),
(1, 22, 1, 1),
(2, 3, 1, 1),
(2, 4, 1, 1),
(2, 5, 1, 1),
(2, 6, 1, 1),
(2, 9, 1, 1),
(2, 10, 1, 1),
(2, 11, 1, 1),
(2, 15, 1, 1),
(2, 17, 1, 1),
(2, 22, 1, 1),
(3, 3, 1, 1),
(3, 4, 1, 1),
(3, 5, 1, 1),
(3, 6, 1, 1),
(3, 9, 1, 1),
(3, 10, 1, 1),
(3, 11, 1, 1),
(3, 15, 1, 1),
(3, 17, 1, 1),
(3, 22, 1, 1),
(4, 3, 1, 1),
(4, 4, 1, 1),
(4, 5, 1, 1),
(4, 6, 1, 1),
(4, 9, 1, 1),
(4, 10, 1, 1),
(4, 11, 1, 1),
(4, 15, 1, 1),
(4, 17, 1, 1),
(4, 22, 1, 1),
(5, 3, 0, 1),
(5, 4, 0, 1),
(5, 5, 0, 0),
(5, 6, 0, 1),
(5, 9, 0, 0),
(5, 10, 0, 0),
(5, 11, 0, 1),
(5, 15, 0, 1),
(5, 17, 0, 1),
(5, 22, 0, 0),
(6, 3, 0, 1),
(6, 4, 0, 1),
(6, 5, 0, 0),
(6, 6, 0, 1),
(6, 9, 0, 0),
(6, 10, 0, 0),
(6, 11, 0, 1),
(6, 15, 0, 1),
(6, 17, 0, 1),
(6, 22, 0, 0),
(7, 3, 0, 1),
(7, 4, 0, 1),
(7, 5, 0, 0),
(7, 6, 0, 1),
(7, 9, 0, 0),
(7, 10, 0, 0),
(7, 11, 0, 1),
(7, 15, 0, 1),
(7, 17, 0, 1),
(7, 22, 0, 0),
(11, 3, 0, 0),
(11, 4, 0, 0),
(11, 5, 0, 0),
(11, 6, 0, 0),
(11, 9, 0, 0),
(11, 10, 0, 0),
(11, 11, 0, 0),
(11, 15, 0, 0),
(11, 17, 0, 0),
(11, 22, 0, 0),
(12, 3, 0, 0),
(12, 4, 0, 0),
(12, 5, 0, 0),
(12, 6, 0, 0),
(12, 9, 0, 0),
(12, 10, 0, 0),
(12, 11, 0, 0),
(12, 15, 0, 0),
(12, 17, 0, 0),
(13, 3, 0, 0),
(13, 4, 0, 0),
(13, 5, 0, 0),
(13, 6, 0, 0),
(13, 9, 0, 0),
(13, 10, 0, 0),
(13, 11, 0, 0),
(13, 15, 0, 0),
(13, 17, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `fo_max_system_permissions`
--

CREATE TABLE IF NOT EXISTS `fo_max_system_permissions` (
  `permission_group_id` int(10) unsigned NOT NULL,
  `can_manage_security` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_manage_configuration` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_manage_templates` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_manage_time` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_add_mail_accounts` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_manage_dimensions` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_manage_dimension_members` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_manage_tasks` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_task_assignee` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_manage_billing` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_view_billing` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_see_assigned_to_other_tasks` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `can_manage_contacts` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_update_other_users_invitations` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_link_objects` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`permission_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `fo_max_system_permissions`
--

INSERT INTO `fo_max_system_permissions` (`permission_group_id`, `can_manage_security`, `can_manage_configuration`, `can_manage_templates`, `can_manage_time`, `can_add_mail_accounts`, `can_manage_dimensions`, `can_manage_dimension_members`, `can_manage_tasks`, `can_task_assignee`, `can_manage_billing`, `can_view_billing`, `can_see_assigned_to_other_tasks`, `can_manage_contacts`, `can_update_other_users_invitations`, `can_link_objects`) VALUES
(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(3, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(4, 1, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1),
(5, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1),
(6, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1),
(7, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1),
(11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0),
(12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0),
(13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `fo_members`
--

CREATE TABLE IF NOT EXISTS `fo_members` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dimension_id` int(10) unsigned NOT NULL,
  `object_type_id` int(10) unsigned NOT NULL,
  `parent_member_id` int(10) unsigned NOT NULL DEFAULT '0',
  `depth` int(2) unsigned NOT NULL,
  `name` varchar(160) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `object_id` int(10) unsigned DEFAULT NULL,
  `order` int(10) unsigned NOT NULL DEFAULT '0',
  `color` int(10) unsigned NOT NULL DEFAULT '0',
  `archived_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `archived_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `by_parent` (`parent_member_id`) USING HASH,
  KEY `by_dimension` (`dimension_id`,`parent_member_id`,`name`),
  KEY `by_object_id` (`object_id`),
  KEY `archived_on` (`archived_on`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `fo_members`
--

INSERT INTO `fo_members` (`id`, `dimension_id`, `object_type_id`, `parent_member_id`, `depth`, `name`, `description`, `object_id`, `order`, `color`, `archived_on`, `archived_by_id`) VALUES
(1, 1, 20, 0, 1, 'admin', '', 2, 0, 0, '0000-00-00 00:00:00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `fo_member_custom_properties`
--

CREATE TABLE IF NOT EXISTS `fo_member_custom_properties` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `object_type_id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `values` text COLLATE utf8_unicode_ci NOT NULL,
  `default_value` text COLLATE utf8_unicode_ci NOT NULL,
  `is_system` tinyint(1) NOT NULL,
  `is_required` tinyint(1) NOT NULL,
  `is_multiple_values` tinyint(1) NOT NULL,
  `property_order` int(10) NOT NULL,
  `visible_by_default` tinyint(1) NOT NULL,
  `is_special` tinyint(1) NOT NULL,
  `is_disabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Dumping data for table `fo_member_custom_properties`
--

INSERT INTO `fo_member_custom_properties` (`id`, `object_type_id`, `name`, `code`, `type`, `description`, `values`, `default_value`, `is_system`, `is_required`, `is_multiple_values`, `property_order`, `visible_by_default`, `is_special`, `is_disabled`) VALUES
(1, 2, 'Color', 'color_special', 'color', '', '', '', 0, 0, 0, 30, 1, 1, 0),
(2, 1, 'Color', 'color_special', 'color', '', '', '', 0, 0, 0, 30, 1, 1, 0),
(4, 2, 'Description', 'description_special', 'memo', '', '', '', 0, 0, 0, 31, 1, 1, 0),
(5, 1, 'Description', 'description_special', 'memo', '', '', '', 0, 0, 0, 31, 1, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `fo_member_custom_property_values`
--

CREATE TABLE IF NOT EXISTS `fo_member_custom_property_values` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `member_id` int(10) NOT NULL,
  `custom_property_id` int(10) NOT NULL,
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_member_property_members`
--

CREATE TABLE IF NOT EXISTS `fo_member_property_members` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `association_id` int(10) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `property_member_id` int(10) unsigned NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id_property_member_id` (`member_id`,`property_member_id`),
  KEY `is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_member_restrictions`
--

CREATE TABLE IF NOT EXISTS `fo_member_restrictions` (
  `member_id` int(10) unsigned NOT NULL,
  `restricted_member_id` int(10) unsigned NOT NULL,
  `order` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`member_id`,`restricted_member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_objects`
--

CREATE TABLE IF NOT EXISTS `fo_objects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `object_type_id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  `trashed_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `trashed_by_id` int(10) unsigned DEFAULT NULL,
  `archived_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `archived_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_on` (`created_on`),
  KEY `updated_on` (`updated_on`),
  KEY `trashed_on` (`trashed_on`),
  KEY `archived_on` (`archived_on`),
  KEY `object_type` (`object_type_id`),
  KEY `name` (`name`) USING HASH,
  KEY `type_trash_arch` (`object_type_id`,`trashed_on`,`archived_on`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `fo_objects`
--

INSERT INTO `fo_objects` (`id`, `object_type_id`, `name`, `created_on`, `created_by_id`, `updated_on`, `updated_by_id`, `trashed_on`, `trashed_by_id`, `archived_on`, `archived_by_id`) VALUES
(1, 15, 'avni', '2015-08-26 10:29:09', 2, '2015-08-26 10:29:09', 2, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0),
(2, 15, 'admin', '2015-08-26 10:29:09', 0, '2015-08-26 10:29:09', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `fo_object_contact_permissions`
--

CREATE TABLE IF NOT EXISTS `fo_object_contact_permissions` (
  `rel_object_id` int(10) unsigned NOT NULL,
  `contact_id` int(10) unsigned NOT NULL,
  `can_read` tinyint(1) unsigned NOT NULL,
  `can_write` tinyint(1) unsigned NOT NULL,
  `can_delete` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`rel_object_id`,`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_object_members`
--

CREATE TABLE IF NOT EXISTS `fo_object_members` (
  `object_id` int(10) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `is_optimization` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`,`member_id`),
  KEY `member_id` (`member_id`),
  KEY `is_optimization` (`is_optimization`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_object_properties`
--

CREATE TABLE IF NOT EXISTS `fo_object_properties` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rel_object_id` int(10) unsigned NOT NULL,
  `name` text COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ObjectID` (`rel_object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_object_reminders`
--

CREATE TABLE IF NOT EXISTS `fo_object_reminders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int(10) unsigned NOT NULL DEFAULT '0',
  `contact_id` int(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `context` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `minutes_before` int(10) DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `type_date` (`type`,`date`),
  KEY `obj_date` (`object_id`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_object_reminder_types`
--

CREATE TABLE IF NOT EXISTS `fo_object_reminder_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `fo_object_reminder_types`
--

INSERT INTO `fo_object_reminder_types` (`id`, `name`) VALUES
(1, 'reminder_email'),
(2, 'reminder_popup');

-- --------------------------------------------------------

--
-- Table structure for table `fo_object_subscriptions`
--

CREATE TABLE IF NOT EXISTS `fo_object_subscriptions` (
  `object_id` int(10) unsigned NOT NULL DEFAULT '0',
  `contact_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`,`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_object_types`
--

CREATE TABLE IF NOT EXISTS `fo_object_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `handler_class` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `table_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `type` enum('content_object','dimension_object','dimension_group','located','comment','') COLLATE utf8_unicode_ci DEFAULT NULL,
  `icon` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `plugin_id` int(10) unsigned NOT NULL DEFAULT '0',
  `uses_order` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `plugin_id` (`plugin_id`) USING HASH
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=23 ;

--
-- Dumping data for table `fo_object_types`
--

INSERT INTO `fo_object_types` (`id`, `name`, `handler_class`, `table_name`, `type`, `icon`, `plugin_id`, `uses_order`) VALUES
(1, 'workspace', 'Workspaces', 'workspaces', 'dimension_object', 'workspace', 0, 0),
(2, 'tag', '', '', 'dimension_group', 'tag', 0, 0),
(3, 'message', 'ProjectMessages', 'project_messages', 'content_object', 'message', 0, 0),
(4, 'weblink', 'ProjectWebpages', 'project_webpages', 'content_object', 'weblink', 0, 0),
(5, 'task', 'ProjectTasks', 'project_tasks', 'content_object', 'task', 0, 0),
(6, 'file', 'ProjectFiles', 'project_files', 'content_object', 'file', 0, 0),
(7, 'form', 'ProjectForms', 'project_forms', '', '', 0, 0),
(8, 'chart', 'ProjectCharts', 'project_charts', '', '', 0, 0),
(9, 'milestone', 'ProjectMilestones', 'project_milestones', 'content_object', 'milestone', 0, 0),
(10, 'event', 'ProjectEvents', 'project_events', 'content_object', 'event', 0, 0),
(11, 'report', 'Reports', 'reports', 'located', 'reporting', 0, 0),
(12, 'template', 'COTemplates', 'templates', 'located', 'template', 0, 0),
(13, 'comment', 'Comments', 'comments', 'comment', 'comment', 0, 0),
(14, 'billing', 'Billings', 'billings', '', '', 0, 0),
(15, 'contact', 'Contacts', 'contacts', 'content_object', 'contact', 0, 0),
(16, 'file revision', 'ProjectFileRevisions', 'file_revisions', 'content_object', 'file', 0, 0),
(17, 'timeslot', 'Timeslots', 'timeslots', 'located', 'time', 0, 0),
(18, 'template_task', 'TemplateTasks', 'template_tasks', 'content_object', 'task', 0, 0),
(19, 'template_milestone', 'TemplateMilestones', 'template_milestones', 'content_object', 'milestone', 0, 0),
(20, 'person', 'Contacts', 'contacts', 'dimension_object', 'contact', 1, 0),
(21, 'company', 'Contacts', 'contacts', 'dimension_object', 'company', 1, 0),
(22, 'mail', 'MailContents', 'mail_contents', 'content_object', 'mail', 3, 0);

-- --------------------------------------------------------

--
-- Table structure for table `fo_permission_contexts`
--

CREATE TABLE IF NOT EXISTS `fo_permission_contexts` (
  `contact_id` int(10) unsigned NOT NULL,
  `permission_group_id` int(10) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`contact_id`,`permission_group_id`,`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_permission_groups`
--

CREATE TABLE IF NOT EXISTS `fo_permission_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `contact_id` int(10) unsigned DEFAULT NULL,
  `is_context` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `plugin_id` int(10) unsigned NOT NULL DEFAULT '0',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `type` enum('roles','permission_groups','user_groups') COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=15 ;

--
-- Dumping data for table `fo_permission_groups`
--

INSERT INTO `fo_permission_groups` (`id`, `name`, `contact_id`, `is_context`, `plugin_id`, `parent_id`, `type`) VALUES
(1, 'Super Administrator', 0, 0, 0, 8, 'roles'),
(2, 'Administrator', 0, 0, 0, 8, 'roles'),
(3, 'Manager', 0, 0, 0, 8, 'roles'),
(4, 'Executive', 0, 0, 0, 8, 'roles'),
(5, 'Collaborator Customer', 0, 0, 0, 9, 'roles'),
(6, 'Internal Collaborator', 0, 0, 0, 9, 'roles'),
(7, 'External Collaborator', 0, 0, 0, 9, 'roles'),
(8, 'ExecutiveGroup', 0, 0, 0, 0, 'roles'),
(9, 'CollaboratorGroup', 0, 0, 0, 0, 'roles'),
(10, 'GuestGroup', 0, 0, 0, 0, 'roles'),
(11, 'Guest Customer', 0, 0, 0, 10, 'roles'),
(12, 'Guest', 0, 0, 0, 10, 'roles'),
(13, 'Non-Exec Director', 0, 0, 0, 10, 'roles'),
(14, 'Account Owner', 2, 0, 0, 0, 'permission_groups');

-- --------------------------------------------------------

--
-- Table structure for table `fo_plugins`
--

CREATE TABLE IF NOT EXISTS `fo_plugins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_installed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_activated` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `priority` smallint(5) unsigned NOT NULL DEFAULT '0',
  `activated_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `activated_by_id` int(10) unsigned DEFAULT NULL,
  `version` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `fo_plugins`
--

INSERT INTO `fo_plugins` (`id`, `name`, `is_installed`, `is_activated`, `priority`, `activated_on`, `activated_by_id`, `version`) VALUES
(1, 'core_dimensions', 1, 1, 0, '0000-00-00 00:00:00', NULL, 12),
(3, 'mail', 1, 1, 0, '0000-00-00 00:00:00', NULL, 16),
(4, 'workspaces', 1, 1, 0, '0000-00-00 00:00:00', NULL, 13);

-- --------------------------------------------------------

--
-- Table structure for table `fo_project_charts`
--

CREATE TABLE IF NOT EXISTS `fo_project_charts` (
  `object_id` int(10) unsigned NOT NULL,
  `type_id` int(10) unsigned DEFAULT NULL,
  `display_id` int(10) unsigned DEFAULT NULL,
  `show_in_project` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `show_in_parents` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_project_chart_params`
--

CREATE TABLE IF NOT EXISTS `fo_project_chart_params` (
  `id` int(10) unsigned NOT NULL,
  `chart_id` int(10) unsigned NOT NULL,
  `value` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`,`chart_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_project_co_types`
--

CREATE TABLE IF NOT EXISTS `fo_project_co_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `object_manager` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `created_by_id` int(10) unsigned NOT NULL,
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by_id` int(10) unsigned NOT NULL,
  `updated_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `object_manager` (`object_manager`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_project_events`
--

CREATE TABLE IF NOT EXISTS `fo_project_events` (
  `object_id` int(10) unsigned NOT NULL,
  `start` datetime DEFAULT NULL,
  `duration` datetime DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `private` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `repeat_end` date DEFAULT NULL,
  `repeat_forever` tinyint(1) unsigned NOT NULL,
  `repeat_num` mediumint(9) NOT NULL DEFAULT '0',
  `repeat_d` smallint(6) NOT NULL DEFAULT '0',
  `repeat_m` smallint(6) NOT NULL DEFAULT '0',
  `repeat_y` smallint(6) NOT NULL DEFAULT '0',
  `repeat_h` smallint(6) NOT NULL DEFAULT '0',
  `repeat_dow` int(10) unsigned NOT NULL DEFAULT '0',
  `repeat_wnum` int(10) unsigned NOT NULL DEFAULT '0',
  `repeat_mjump` int(10) unsigned NOT NULL DEFAULT '0',
  `type_id` int(11) NOT NULL DEFAULT '0',
  `special_id` text COLLATE utf8_unicode_ci,
  `update_sync` datetime DEFAULT NULL,
  `ext_cal_id` int(10) unsigned NOT NULL,
  `original_event_id` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`object_id`),
  KEY `start` (`start`),
  KEY `repeat_h` (`repeat_h`),
  KEY `type_id` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_project_files`
--

CREATE TABLE IF NOT EXISTS `fo_project_files` (
  `object_id` int(10) unsigned NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `is_locked` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_visible` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `expiration_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `checked_out_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `checked_out_by_id` int(10) unsigned DEFAULT '0',
  `was_auto_checked_out` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `type` int(1) NOT NULL DEFAULT '0',
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mail_id` int(10) unsigned NOT NULL DEFAULT '0',
  `attach_to_notification` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `default_subject` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_project_file_revisions`
--

CREATE TABLE IF NOT EXISTS `fo_project_file_revisions` (
  `object_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `file_id` int(10) unsigned NOT NULL DEFAULT '0',
  `file_type_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `repository_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `thumb_filename` varchar(44) COLLATE utf8_unicode_ci DEFAULT NULL,
  `revision_number` int(10) unsigned NOT NULL DEFAULT '0',
  `comment` text COLLATE utf8_unicode_ci,
  `type_string` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `filesize` int(10) unsigned NOT NULL DEFAULT '0',
  `hash` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`object_id`),
  KEY `filesize` (`filesize`),
  KEY `file_id` (`file_id`,`revision_number`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_project_forms`
--

CREATE TABLE IF NOT EXISTS `fo_project_forms` (
  `object_id` int(10) unsigned NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `success_message` text COLLATE utf8_unicode_ci NOT NULL,
  `action` enum('add_comment','add_task') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'add_comment',
  `in_object_id` int(10) unsigned NOT NULL DEFAULT '0',
  `is_visible` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `order` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_project_messages`
--

CREATE TABLE IF NOT EXISTS `fo_project_messages` (
  `object_id` int(10) unsigned NOT NULL,
  `text` text COLLATE utf8_unicode_ci,
  `type_content` enum('text','html') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'text',
  PRIMARY KEY (`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_project_milestones`
--

CREATE TABLE IF NOT EXISTS `fo_project_milestones` (
  `object_id` int(10) unsigned NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `due_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_urgent` tinyint(1) NOT NULL DEFAULT '0',
  `completed_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `completed_by_id` int(10) unsigned DEFAULT NULL,
  `is_template` tinyint(1) NOT NULL DEFAULT '0',
  `from_template_id` int(10) NOT NULL DEFAULT '0',
  `from_template_object_id` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`object_id`),
  KEY `due_date` (`due_date`),
  KEY `completed_on` (`completed_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_project_tasks`
--

CREATE TABLE IF NOT EXISTS `fo_project_tasks` (
  `object_id` int(10) unsigned NOT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `parents_path` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `depth` int(2) unsigned NOT NULL DEFAULT '0',
  `text` text COLLATE utf8_unicode_ci,
  `due_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `assigned_to_contact_id` int(10) unsigned DEFAULT NULL,
  `assigned_on` datetime DEFAULT NULL,
  `assigned_by_id` int(10) unsigned DEFAULT NULL,
  `time_estimate` int(10) unsigned NOT NULL DEFAULT '0',
  `completed_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `completed_by_id` int(10) unsigned DEFAULT NULL,
  `started_on` datetime DEFAULT NULL,
  `started_by_id` int(10) unsigned NOT NULL,
  `priority` int(10) unsigned DEFAULT '200',
  `state` int(10) unsigned DEFAULT NULL,
  `order` int(10) unsigned DEFAULT '0',
  `milestone_id` int(10) unsigned DEFAULT NULL,
  `is_template` tinyint(1) NOT NULL DEFAULT '0',
  `from_template_id` int(10) NOT NULL DEFAULT '0',
  `from_template_object_id` int(10) unsigned DEFAULT '0',
  `repeat_end` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `repeat_forever` tinyint(1) NOT NULL,
  `repeat_num` int(10) unsigned NOT NULL DEFAULT '0',
  `repeat_d` int(10) unsigned NOT NULL,
  `repeat_m` int(10) unsigned NOT NULL,
  `repeat_y` int(10) unsigned NOT NULL,
  `repeat_by` varchar(15) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `object_subtype` int(10) unsigned NOT NULL DEFAULT '0',
  `percent_completed` int(10) unsigned NOT NULL DEFAULT '0',
  `use_due_time` tinyint(1) DEFAULT '0',
  `use_start_time` tinyint(1) DEFAULT '0',
  `original_task_id` int(10) unsigned DEFAULT '0',
  `instantiation_id` int(10) unsigned NOT NULL DEFAULT '0',
  `type_content` enum('text','html') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'text',
  PRIMARY KEY (`object_id`),
  KEY `parent_id` (`parent_id`),
  KEY `completed_on` (`completed_on`),
  KEY `order` (`order`),
  KEY `milestone_id` (`milestone_id`),
  KEY `priority` (`priority`),
  KEY `assigned_to` (`assigned_to_contact_id`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_project_task_dependencies`
--

CREATE TABLE IF NOT EXISTS `fo_project_task_dependencies` (
  `previous_task_id` int(10) unsigned NOT NULL,
  `task_id` int(10) unsigned NOT NULL,
  `created_on` datetime NOT NULL,
  `created_by_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`previous_task_id`,`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_project_webpages`
--

CREATE TABLE IF NOT EXISTS `fo_project_webpages` (
  `object_id` int(10) unsigned NOT NULL,
  `url` text COLLATE utf8_unicode_ci,
  `description` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_queued_emails`
--

CREATE TABLE IF NOT EXISTS `fo_queued_emails` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `to` text COLLATE utf8_unicode_ci,
  `cc` text COLLATE utf8_unicode_ci,
  `bcc` text COLLATE utf8_unicode_ci,
  `from` text COLLATE utf8_unicode_ci,
  `subject` text COLLATE utf8_unicode_ci,
  `body` text COLLATE utf8_unicode_ci,
  `attachments` text COLLATE utf8_unicode_ci,
  `timestamp` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_read_objects`
--

CREATE TABLE IF NOT EXISTS `fo_read_objects` (
  `rel_object_id` int(10) unsigned NOT NULL DEFAULT '0',
  `contact_id` int(10) unsigned NOT NULL DEFAULT '0',
  `is_read` int(1) NOT NULL DEFAULT '0',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`rel_object_id`,`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_reports`
--

CREATE TABLE IF NOT EXISTS `fo_reports` (
  `object_id` int(10) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `report_object_type_id` int(10) unsigned NOT NULL,
  `order_by` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `is_order_by_asc` tinyint(1) NOT NULL,
  `ignore_context` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`object_id`),
  KEY `object_type` (`report_object_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_report_columns`
--

CREATE TABLE IF NOT EXISTS `fo_report_columns` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `report_id` int(10) NOT NULL,
  `custom_property_id` int(10) NOT NULL,
  `field_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_report_conditions`
--

CREATE TABLE IF NOT EXISTS `fo_report_conditions` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `report_id` int(10) NOT NULL,
  `custom_property_id` int(10) NOT NULL,
  `field_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `condition` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `is_parametrizable` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_role_object_type_permissions`
--

CREATE TABLE IF NOT EXISTS `fo_role_object_type_permissions` (
  `role_id` int(10) unsigned NOT NULL,
  `object_type_id` int(10) unsigned NOT NULL,
  `can_delete` tinyint(1) NOT NULL,
  `can_write` tinyint(1) NOT NULL,
  PRIMARY KEY (`role_id`,`object_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `fo_role_object_type_permissions`
--

INSERT INTO `fo_role_object_type_permissions` (`role_id`, `object_type_id`, `can_delete`, `can_write`) VALUES
(1, 3, 1, 1),
(1, 4, 1, 1),
(1, 5, 1, 1),
(1, 6, 1, 1),
(1, 9, 1, 1),
(1, 10, 1, 1),
(1, 11, 1, 1),
(1, 15, 1, 1),
(1, 17, 1, 1),
(1, 22, 1, 1),
(2, 3, 1, 1),
(2, 4, 1, 1),
(2, 5, 1, 1),
(2, 6, 1, 1),
(2, 9, 1, 1),
(2, 10, 1, 1),
(2, 11, 1, 1),
(2, 15, 1, 1),
(2, 17, 1, 1),
(2, 22, 1, 1),
(3, 3, 1, 1),
(3, 4, 1, 1),
(3, 5, 1, 1),
(3, 6, 1, 1),
(3, 9, 1, 1),
(3, 10, 1, 1),
(3, 11, 1, 1),
(3, 15, 1, 1),
(3, 17, 1, 1),
(3, 22, 1, 1),
(4, 3, 0, 1),
(4, 4, 0, 1),
(4, 5, 0, 1),
(4, 6, 0, 1),
(4, 9, 0, 1),
(4, 10, 0, 1),
(4, 11, 0, 1),
(4, 15, 0, 1),
(4, 17, 0, 1),
(4, 22, 0, 1),
(5, 5, 0, 0),
(5, 6, 0, 1),
(5, 9, 0, 0),
(5, 10, 0, 0),
(5, 11, 0, 0),
(5, 15, 0, 0),
(5, 17, 0, 1),
(6, 5, 0, 0),
(6, 6, 0, 1),
(6, 9, 0, 0),
(6, 10, 0, 0),
(6, 11, 0, 0),
(6, 15, 0, 0),
(6, 17, 0, 1),
(7, 5, 0, 0),
(7, 6, 0, 0),
(7, 9, 0, 0),
(7, 17, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `fo_searchable_objects`
--

CREATE TABLE IF NOT EXISTS `fo_searchable_objects` (
  `rel_object_id` int(10) unsigned NOT NULL DEFAULT '0',
  `column_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  `contact_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`rel_object_id`,`column_name`),
  KEY `rel_obj_id` (`rel_object_id`),
  FULLTEXT KEY `content` (`content`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `fo_searchable_objects`
--

INSERT INTO `fo_searchable_objects` (`rel_object_id`, `column_name`, `content`, `contact_id`) VALUES
(1, 'object_id', '1', 0),
(1, 'first_name', 'avni', 0),
(1, 'name', 'avni', 0),
(2, 'object_id', '2', 0),
(2, 'first_name', 'admin', 0),
(2, 'name', 'admin', 0),
(2, 'email_addres0', 'admin@admin.com', 0);

-- --------------------------------------------------------

--
-- Table structure for table `fo_sent_notifications`
--

CREATE TABLE IF NOT EXISTS `fo_sent_notifications` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `queued_email_id` int(10) NOT NULL DEFAULT '0',
  `sent_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `to` text COLLATE utf8_unicode_ci,
  `cc` text COLLATE utf8_unicode_ci,
  `bcc` text COLLATE utf8_unicode_ci,
  `from` text COLLATE utf8_unicode_ci,
  `subject` text COLLATE utf8_unicode_ci,
  `body` text COLLATE utf8_unicode_ci,
  `attachments` text COLLATE utf8_unicode_ci,
  `timestamp` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_sharing_table`
--

CREATE TABLE IF NOT EXISTS `fo_sharing_table` (
  `group_id` int(10) unsigned NOT NULL,
  `object_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`group_id`,`object_id`),
  KEY `object_id` (`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_sharing_table_flags`
--

CREATE TABLE IF NOT EXISTS `fo_sharing_table_flags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `permission_group_id` int(10) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `object_id` int(10) unsigned NOT NULL,
  `execution_date` datetime NOT NULL,
  `permission_string` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_by_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_specific_permissions`
--

CREATE TABLE IF NOT EXISTS `fo_specific_permissions` (
  `permission_group_id` int(10) unsigned NOT NULL,
  `can_change_project_status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_revert_project_status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_assign_supervisor` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_extend_quota` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`permission_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_system_permissions`
--

CREATE TABLE IF NOT EXISTS `fo_system_permissions` (
  `permission_group_id` int(10) unsigned NOT NULL,
  `can_manage_security` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_manage_configuration` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_manage_templates` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_manage_time` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_add_mail_accounts` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_manage_dimensions` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_manage_dimension_members` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_manage_tasks` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_task_assignee` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_manage_billing` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_view_billing` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_see_assigned_to_other_tasks` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `can_manage_contacts` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_update_other_users_invitations` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_link_objects` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`permission_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `fo_system_permissions`
--

INSERT INTO `fo_system_permissions` (`permission_group_id`, `can_manage_security`, `can_manage_configuration`, `can_manage_templates`, `can_manage_time`, `can_add_mail_accounts`, `can_manage_dimensions`, `can_manage_dimension_members`, `can_manage_tasks`, `can_task_assignee`, `can_manage_billing`, `can_view_billing`, `can_see_assigned_to_other_tasks`, `can_manage_contacts`, `can_update_other_users_invitations`, `can_link_objects`) VALUES
(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1),
(3, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1),
(4, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 0, 1),
(5, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1),
(6, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1),
(7, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1),
(11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0),
(12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0),
(14, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `fo_tab_panels`
--

CREATE TABLE IF NOT EXISTS `fo_tab_panels` (
  `id` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `icon_cls` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `refresh_on_context_change` tinyint(1) NOT NULL,
  `default_controller` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `default_action` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `initial_controller` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `initial_action` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `type` enum('system','plugin') COLLATE utf8_unicode_ci NOT NULL,
  `ordering` int(10) NOT NULL,
  `plugin_id` int(10) unsigned NOT NULL DEFAULT '0',
  `object_type_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `enabled` (`enabled`,`type`,`plugin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `fo_tab_panels`
--

INSERT INTO `fo_tab_panels` (`id`, `title`, `icon_cls`, `refresh_on_context_change`, `default_controller`, `default_action`, `initial_controller`, `initial_action`, `enabled`, `type`, `ordering`, `plugin_id`, `object_type_id`) VALUES
('calendar-panel', 'calendar', 'ico-calendar', 1, 'event', 'view_calendar', '', '', 0, 'system', 7, 0, 10),
('contacts-panel', 'contacts', 'ico-contacts', 1, 'contact', 'init', '', '', 0, 'system', 4, 0, 15),
('documents-panel', 'documents', 'ico-documents', 1, 'files', 'init', '', '', 1, 'system', 3, 0, 6),
('mails-panel', 'email tab', 'ico-mail', 1, 'mail', 'init', '', '', 1, 'system', 12, 3, 22),
('messages-panel', 'messages', 'ico-messages', 1, 'message', 'init', '', '', 0, 'system', 10, 0, 3),
('more-panel', 'getting started', 'ico-more-tab', 0, 'more', 'index', '', '', 1, 'system', 100, 0, 0),
('overview-panel', 'overview', 'ico-overview', 1, 'dashboard', 'main_dashboard', 'dashboard', 'main_dashboard', 1, 'system', 1, 0, 0),
('reporting-panel', 'reporting', 'ico-reporting', 1, 'reporting', 'index', '', '', 1, 'system', 8, 0, 11),
('tasks-panel', 'tasks', 'ico-tasks', 1, 'task', 'new_list_tasks', '', '', 1, 'system', 2, 0, 5),
('time-panel', 'time', 'ico-time-layout', 1, 'time', 'index', '', '', 1, 'system', 5, 0, 0),
('webpages-panel', 'web pages', 'ico-webpages', 1, 'webpage', 'init', '', '', 0, 'system', 9, 0, 4);

-- --------------------------------------------------------

--
-- Table structure for table `fo_tab_panel_permissions`
--

CREATE TABLE IF NOT EXISTS `fo_tab_panel_permissions` (
  `permission_group_id` int(10) unsigned NOT NULL,
  `tab_panel_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`permission_group_id`,`tab_panel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `fo_tab_panel_permissions`
--

INSERT INTO `fo_tab_panel_permissions` (`permission_group_id`, `tab_panel_id`) VALUES
(1, 'calendar-panel'),
(1, 'contacts-panel'),
(1, 'documents-panel'),
(1, 'mails-panel'),
(1, 'messages-panel'),
(1, 'more-panel'),
(1, 'overview-panel'),
(1, 'reporting-panel'),
(1, 'tasks-panel'),
(1, 'time-panel'),
(1, 'webpages-panel'),
(2, 'calendar-panel'),
(2, 'contacts-panel'),
(2, 'documents-panel'),
(2, 'mails-panel'),
(2, 'messages-panel'),
(2, 'more-panel'),
(2, 'overview-panel'),
(2, 'reporting-panel'),
(2, 'tasks-panel'),
(2, 'time-panel'),
(2, 'webpages-panel'),
(3, 'calendar-panel'),
(3, 'contacts-panel'),
(3, 'documents-panel'),
(3, 'mails-panel'),
(3, 'messages-panel'),
(3, 'more-panel'),
(3, 'overview-panel'),
(3, 'reporting-panel'),
(3, 'tasks-panel'),
(3, 'time-panel'),
(3, 'webpages-panel'),
(4, 'calendar-panel'),
(4, 'contacts-panel'),
(4, 'documents-panel'),
(4, 'mails-panel'),
(4, 'messages-panel'),
(4, 'more-panel'),
(4, 'overview-panel'),
(4, 'reporting-panel'),
(4, 'tasks-panel'),
(4, 'time-panel'),
(4, 'webpages-panel'),
(5, 'calendar-panel'),
(5, 'contacts-panel'),
(5, 'documents-panel'),
(5, 'messages-panel'),
(5, 'more-panel'),
(5, 'overview-panel'),
(5, 'reporting-panel'),
(5, 'tasks-panel'),
(5, 'time-panel'),
(5, 'webpages-panel'),
(6, 'calendar-panel'),
(6, 'documents-panel'),
(6, 'messages-panel'),
(6, 'more-panel'),
(6, 'overview-panel'),
(6, 'tasks-panel'),
(6, 'time-panel'),
(6, 'webpages-panel'),
(7, 'calendar-panel'),
(7, 'documents-panel'),
(7, 'messages-panel'),
(7, 'more-panel'),
(7, 'overview-panel'),
(7, 'tasks-panel'),
(7, 'time-panel'),
(7, 'webpages-panel'),
(11, 'calendar-panel'),
(11, 'documents-panel'),
(11, 'messages-panel'),
(11, 'overview-panel'),
(11, 'webpages-panel'),
(12, 'calendar-panel'),
(12, 'messages-panel'),
(12, 'overview-panel'),
(12, 'webpages-panel'),
(13, 'calendar-panel'),
(13, 'contacts-panel'),
(13, 'documents-panel'),
(13, 'messages-panel'),
(13, 'more-panel'),
(13, 'overview-panel'),
(13, 'reporting-panel'),
(13, 'tasks-panel'),
(13, 'time-panel'),
(13, 'webpages-panel'),
(14, 'calendar-panel'),
(14, 'contacts-panel'),
(14, 'documents-panel'),
(14, 'mails-panel'),
(14, 'messages-panel'),
(14, 'more-panel'),
(14, 'overview-panel'),
(14, 'reporting-panel'),
(14, 'tasks-panel'),
(14, 'time-panel'),
(14, 'webpages-panel');

-- --------------------------------------------------------

--
-- Table structure for table `fo_telephone_types`
--

CREATE TABLE IF NOT EXISTS `fo_telephone_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_system` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

--
-- Dumping data for table `fo_telephone_types`
--

INSERT INTO `fo_telephone_types` (`id`, `name`, `is_system`) VALUES
(1, 'home', 1),
(2, 'work', 1),
(3, 'other', 1),
(4, 'assistant', 0),
(5, 'callback', 0),
(6, 'mobile', 1),
(7, 'pager', 0),
(8, 'fax', 0);

-- --------------------------------------------------------

--
-- Table structure for table `fo_templates`
--

CREATE TABLE IF NOT EXISTS `fo_templates` (
  `object_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` text COLLATE utf8_unicode_ci,
  `can_instance_from_mail` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_template_instantiated_parameters`
--

CREATE TABLE IF NOT EXISTS `fo_template_instantiated_parameters` (
  `template_id` int(10) unsigned NOT NULL,
  `instantiation_id` int(10) unsigned NOT NULL,
  `parameter_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`template_id`,`instantiation_id`,`parameter_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_template_milestones`
--

CREATE TABLE IF NOT EXISTS `fo_template_milestones` (
  `template_id` int(10) unsigned DEFAULT NULL,
  `session_id` int(10) DEFAULT NULL,
  `object_id` int(10) unsigned NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `due_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_urgent` tinyint(1) NOT NULL DEFAULT '0',
  `completed_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `completed_by_id` int(10) unsigned DEFAULT NULL,
  `is_template` tinyint(1) NOT NULL DEFAULT '0',
  `from_template_id` int(10) NOT NULL DEFAULT '0',
  `from_template_object_id` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`object_id`),
  KEY `due_date` (`due_date`),
  KEY `completed_on` (`completed_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_template_objects`
--

CREATE TABLE IF NOT EXISTS `fo_template_objects` (
  `template_id` int(10) unsigned NOT NULL DEFAULT '0',
  `object_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  PRIMARY KEY (`template_id`,`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_template_object_properties`
--

CREATE TABLE IF NOT EXISTS `fo_template_object_properties` (
  `template_id` int(10) NOT NULL,
  `object_id` int(10) NOT NULL,
  `property` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`template_id`,`object_id`,`property`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_template_parameters`
--

CREATE TABLE IF NOT EXISTS `fo_template_parameters` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `template_id` int(10) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `default_value` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_template_tasks`
--

CREATE TABLE IF NOT EXISTS `fo_template_tasks` (
  `template_id` int(10) unsigned DEFAULT NULL,
  `session_id` int(10) DEFAULT NULL,
  `object_id` int(10) unsigned NOT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `parents_path` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `depth` int(2) unsigned NOT NULL DEFAULT '0',
  `text` text COLLATE utf8_unicode_ci,
  `due_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `assigned_to_contact_id` int(10) unsigned DEFAULT NULL,
  `assigned_on` datetime DEFAULT NULL,
  `assigned_by_id` int(10) unsigned DEFAULT NULL,
  `time_estimate` int(10) unsigned NOT NULL DEFAULT '0',
  `completed_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `completed_by_id` int(10) unsigned DEFAULT NULL,
  `started_on` datetime DEFAULT NULL,
  `started_by_id` int(10) unsigned NOT NULL,
  `priority` int(10) unsigned DEFAULT '200',
  `state` int(10) unsigned DEFAULT NULL,
  `order` int(10) unsigned DEFAULT '0',
  `milestone_id` int(10) unsigned DEFAULT NULL,
  `is_template` tinyint(1) NOT NULL DEFAULT '0',
  `from_template_id` int(10) NOT NULL DEFAULT '0',
  `from_template_object_id` int(10) unsigned DEFAULT '0',
  `repeat_end` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `repeat_forever` tinyint(1) NOT NULL,
  `repeat_num` int(10) unsigned NOT NULL DEFAULT '0',
  `repeat_d` int(10) unsigned NOT NULL,
  `repeat_m` int(10) unsigned NOT NULL,
  `repeat_y` int(10) unsigned NOT NULL,
  `repeat_by` varchar(15) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `object_subtype` int(10) unsigned NOT NULL DEFAULT '0',
  `percent_completed` int(10) unsigned NOT NULL DEFAULT '0',
  `use_due_time` tinyint(1) DEFAULT '0',
  `use_start_time` tinyint(1) DEFAULT '0',
  `original_task_id` int(10) unsigned DEFAULT '0',
  `type_content` enum('text','html') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'text',
  PRIMARY KEY (`object_id`),
  KEY `parent_id` (`parent_id`),
  KEY `completed_on` (`completed_on`),
  KEY `order` (`order`),
  KEY `milestone_id` (`milestone_id`),
  KEY `priority` (`priority`),
  KEY `assigned_to` (`assigned_to_contact_id`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fo_timeslots`
--

CREATE TABLE IF NOT EXISTS `fo_timeslots` (
  `object_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rel_object_id` int(10) unsigned NOT NULL,
  `start_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `contact_id` int(10) unsigned NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `paused_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `subtract` int(10) unsigned NOT NULL DEFAULT '0',
  `fixed_billing` float NOT NULL DEFAULT '0',
  `hourly_billing` float NOT NULL DEFAULT '0',
  `is_fixed_billing` float NOT NULL DEFAULT '0',
  `billing_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`),
  KEY `rel_obj_id` (`rel_object_id`) USING BTREE,
  KEY `end_time` (`end_time`),
  KEY `contact_end` (`contact_id`,`end_time`),
  KEY `contact_start` (`contact_id`,`start_time`),
  KEY `start_time` (`start_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fo_webpage_types`
--

CREATE TABLE IF NOT EXISTS `fo_webpage_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_system` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `fo_webpage_types`
--

INSERT INTO `fo_webpage_types` (`id`, `name`, `is_system`) VALUES
(1, 'personal', 1),
(2, 'work', 1),
(3, 'other', 1);

-- --------------------------------------------------------

--
-- Table structure for table `fo_widgets`
--

CREATE TABLE IF NOT EXISTS `fo_widgets` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `plugin_id` int(10) unsigned NOT NULL DEFAULT '0',
  `path` varchar(512) COLLATE utf8_unicode_ci NOT NULL,
  `default_options` text COLLATE utf8_unicode_ci NOT NULL,
  `default_section` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `default_order` int(10) NOT NULL,
  `icon_cls` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `fo_widgets`
--

INSERT INTO `fo_widgets` (`name`, `title`, `plugin_id`, `path`, `default_options`, `default_section`, `default_order`, `icon_cls`) VALUES
('active_context_info', 'active_context_info', 0, '', '', 'left', 1, 'ico-summary'),
('activity_feed', 'activity_feed', 0, '', '', 'left', 10, 'ico-properties'),
('calendar', 'upcoming events milestones and tasks', 0, '', '', 'top', 0, 'ico-event'),
('comments', 'comments', 0, '', '', 'left', 15, 'ico-comment'),
('completed_tasks_list', 'completed tasks list', 0, '', '', 'right', 150, 'ico-task'),
('documents', 'documents', 0, '', '', 'right', 1100, 'ico-file'),
('emails', 'emails', 0, '', '', 'right', 10, 'ico-email'),
('messages', 'notes', 0, '', '', 'right', 1000, 'ico-message'),
('overdue_upcoming', 'overdue and upcoming', 0, '', '', 'left', 3, 'ico-task'),
('people', 'people', 0, '', '', 'right', -1, 'ico-contact'),
('workspaces', 'workspaces', 4, '', '', 'left', 3, 'ico-workspace');

-- --------------------------------------------------------

--
-- Table structure for table `fo_workspaces`
--

CREATE TABLE IF NOT EXISTS `fo_workspaces` (
  `object_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` text COLLATE utf8_unicode_ci,
  `show_description_in_overview` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `color` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
