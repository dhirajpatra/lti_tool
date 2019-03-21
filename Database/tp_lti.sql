-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 09, 2016 at 08:33 PM
-- Server version: 5.5.49-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tp_lti`
--

-- --------------------------------------------------------

--
-- Table structure for table `lti_capability`
--

CREATE TABLE IF NOT EXISTS `lti_capability` (
  `capability_id` int(11) NOT NULL AUTO_INCREMENT,
  `capability_name` varchar(100) NOT NULL,
  `capability_status` enum('1','2') NOT NULL,
  PRIMARY KEY (`capability_id`),
  UNIQUE KEY `capability_name` (`capability_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `lti_capability`
--

INSERT INTO `lti_capability` (`capability_id`, `capability_name`, `capability_status`) VALUES
(1, 'user.id', '1'),
(2, 'user.username', '1'),
(3, 'coursesection.sourcedid', '1'),
(4, 'person.sourcedid', '1'),
(5, 'person.name.full', '1'),
(6, 'membership.role', '1'),
(7, 'person.name.given', '1'),
(8, 'person.name.family', '1'),
(9, 'person.email.primary', '1'),
(10, 'user.image', '1'),
(11, 'result.sourcedid', '1'),
(12, 'result.autocreate', '1');

-- --------------------------------------------------------

--
-- Table structure for table `lti_consumer_secret`
--

CREATE TABLE IF NOT EXISTS `lti_consumer_secret` (
  `lti_consumer_secret_id` int(11) NOT NULL AUTO_INCREMENT,
  `lti_consumer_secret_key` varchar(100) NOT NULL,
  `lti_consumer_email` varchar(100) NOT NULL,
  `lti_consumer_domain` varchar(100) NOT NULL,
  `lti_consumer_access_level` enum('d','s','m') NOT NULL DEFAULT 'd' COMMENT 'd->domain level access, s->specific link level access, m->multiple link level access',
  `lti_consumer_valid_from` date NOT NULL,
  `lti_consumer_valid_till` date NOT NULL,
  `lti_consumer_created_dts` datetime NOT NULL,
  `lti_consumer_status` enum('1','2') NOT NULL,
  `tp_profile_temp_data` text NOT NULL,
  PRIMARY KEY (`lti_consumer_secret_id`),
  KEY `lti_consumer_secret_key` (`lti_consumer_secret_key`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `lti_consumer_secret`
--

INSERT INTO `lti_consumer_secret` (`lti_consumer_secret_id`, `lti_consumer_secret_key`, `lti_consumer_email`, `lti_consumer_domain`, `lti_consumer_access_level`, `lti_consumer_valid_from`, `lti_consumer_valid_till`, `lti_consumer_created_dts`, `lti_consumer_status`, `tp_profile_temp_data`) VALUES
(1, 'secret', 'support@sakaiproject.org', 'http://www.sakaiproject.org/', 's', '2016-05-25', '2016-05-31', '2016-05-25 00:00:00', '1', '{\r\n  "@context": "http://www.imsglobal.org/imspurl/lti/v2/ctx/ToolProxy",\r\n  "@type": "ToolProxy",\r\n  "lti_version": "LTI-2p0",\r\n  "tool_consumer_profile": "__TODO_SHOULD_THIS_BE_THE_WHOLE_PROFILE_OR_JUST_A_URL_SEE_5_6__",\r\n  "nasty_json": "How do you handle these characters < > & '' ",\r\n  "evil_json": "</script><script>alert(''evil'');</script>",\r\n  "evil_json2": "\\"</script><script>alert(''evil'');</script>",\r\n  "tool_profile": {\r\n    "product_instance": {\r\n      "product_info": {\r\n        "product_version": "0.3",\r\n        "technical_description": {\r\n          "default_value": "Simple LTI 2 PHP Implementation",\r\n          "key": "tool.technical"\r\n        },\r\n        "product_name": {\r\n          "default_value": "LTI2 PHP Test",\r\n          "key": "tool.name"\r\n        },\r\n        "product_family": {\r\n          "code": "assessment-tool",\r\n          "vendor": {\r\n            "website": "__REPLACE__",\r\n            "code": "sakaiproject.org",\r\n            "name": {\r\n              "default_value": "Sakai",\r\n              "key": "tool.vendor.name"\r\n            },\r\n            "timestamp": "2013-05-13T09:08:16-04:00",\r\n            "contact": {\r\n              "email": "info@sakaiproject.org"\r\n            },\r\n            "description": {\r\n              "default_value": "Sakai does many awesome things that are open source.",\r\n              "key": "tool.vendor.description"\r\n            }\r\n          }\r\n        },\r\n        "description": {\r\n          "default_value": "This tool produces mostly debugging output and sample code.",\r\n          "key": "tool.description"\r\n        }\r\n      },\r\n      "support": {\r\n        "email": "helpdesk@sakaiproject.org"\r\n      },\r\n      "guid": "fd75124a-140e-470f-944c-114d2d92bb40",\r\n      "service_provider": {\r\n        "support": {\r\n          "email": "support@sakaiproject.org"\r\n        },\r\n        "provider_name": {\r\n          "default_value": "Dr. Chuck",\r\n          "key": "service_provider.name"\r\n        },\r\n        "guid": "18e7ea50-3d6d-4f6b-aff2-ed3ab577716c",\r\n        "description": {\r\n          "default_value": "An inexpensive PHP hosting environment from 1and1.",\r\n          "key": "service_provider.description"\r\n        },\r\n        "timestamp": "2013-05-13T09:08:16-04:00"\r\n      }\r\n    },\r\n    "lti_version": "LTI-2p0",\r\n    "message": [\r\n      {\r\n        "message_type": [\r\n          "ToolProxyRegistrationRequest",\r\n          "ToolProxyReregistrationRequest"\r\n        ],\r\n        "path": "__LAUNCH_REGISTRATION__",\r\n        "parameter": [\r\n          {\r\n            "variable": "ToolConsumerProfile.url",\r\n            "name": "tc_profile_url"\r\n          }\r\n        ]\r\n      }\r\n    ],\r\n    "resource_handler": [\r\n      {\r\n        "resource_type": {\r\n			"code" : "__REPLACE__urn:lti:ResourceType:acme.example.com/nitrolab/homework"\r\n		},\r\n        "message": [\r\n          {\r\n            "path": "__LAUNCH_PATH__",\r\n            "parameter": [\r\n              {\r\n                "name": "theanswer",\r\n                "fixed": "42"\r\n              },\r\n              {\r\n                "name": "ltilink_custom_url",\r\n                "variable": "LtiLink.custom.url"\r\n              },\r\n              {\r\n                "name": "toolproxy_custom_url",\r\n                "variable": "ToolProxy.custom.url"\r\n              },\r\n              {\r\n                "name": "toolproxybinding_custom_url",\r\n                "variable": "ToolProxyBinding.custom.url"\r\n              },\r\n              {\r\n                "name": "result_url",\r\n                "variable": "Result.url"\r\n              },\r\n              {\r\n                "name": "person_email_primary",\r\n                "variable": "Person.email.primary"\r\n              },\r\n              {\r\n                "name": "person_name_full",\r\n                "variable": "Person.name.full"\r\n              },\r\n              {\r\n                "name": "person_name_given",\r\n                "variable": "Person.name.given"\r\n              },\r\n              {\r\n                "name": "person_name_family",\r\n                "variable": "Person.name.family"\r\n              },\r\n              {\r\n                "name": "user_id",\r\n                "variable": "User.id"\r\n              },\r\n              {\r\n                "name": "user_image",\r\n                "variable": "User.image"\r\n              },\r\n              {\r\n                "name": "membership_role",\r\n                "variable": "Membership.role"\r\n              }\r\n            ],\r\n            "message_type": "basic-lti-launch-request",\r\n            "enabled_capability" : [ "User.id" ]\r\n          }\r\n        ],\r\n        "name": {\r\n          "default_value": "Sakai PHP Unit Test",\r\n          "key": "resource.name"\r\n        },\r\n        "short_name": {\r\n          "default_value": "Sakai Unit",\r\n          "key": "resource.name"\r\n        },\r\n        "description": {\r\n          "default_value": "Sakai PHP Unit Test Decription",\r\n          "key": "resource.description"\r\n        }\r\n      }\r\n    ],\r\n    "base_url_choice": [\r\n      {\r\n        "selector": {\r\n          "applies_to": [\r\n            "IconEndpoint",\r\n            "MessageHandler"\r\n          ]\r\n        },\r\n        "secure_base_url": "http://localhost:5000",\r\n        "default_base_url": "http://localhost:5000"\r\n      }\r\n    ]\r\n  },\r\n  "custom" : {\r\n     "id" : "xkcd123"\r\n  },\r\n  "security_contract": {\r\n    "shared_secret": "__SECRET__",\r\n    "tool_service": [\r\n      {\r\n        "@type": "RestService",\r\n        "@id": "ltitcp:ToolProxy.collection",\r\n        "service": "__TODOFROM_ID_INTC_PROFILE__http://localhost:4000/tools",\r\n        "action": "POST",\r\n        "format": "application/vnd.ims.lti.v2.ToolProxy+json"\r\n      }\r\n    ]\r\n  }\r\n}');

-- --------------------------------------------------------

--
-- Table structure for table `lti_link_level_access`
--

CREATE TABLE IF NOT EXISTS `lti_link_level_access` (
  `lti_link_level_access_id` int(11) NOT NULL AUTO_INCREMENT,
  `lti_consumer_secret_id` int(11) NOT NULL,
  `lti_resource_info_id` int(11) NOT NULL,
  `lti_link_level_access_dts` datetime NOT NULL,
  PRIMARY KEY (`lti_link_level_access_id`),
  KEY `lti_consumer_secret_id` (`lti_consumer_secret_id`,`lti_resource_info_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `lti_link_level_access`
--

INSERT INTO `lti_link_level_access` (`lti_link_level_access_id`, `lti_consumer_secret_id`, `lti_resource_info_id`, `lti_link_level_access_dts`) VALUES
(1, 1, 2, '2016-06-09 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `lti_resource_access`
--

CREATE TABLE IF NOT EXISTS `lti_resource_access` (
  `lti_resource_handler_id` int(11) NOT NULL AUTO_INCREMENT,
  `lti_resource_info_id` int(11) NOT NULL,
  `lti_user_role_id` int(11) NOT NULL,
  `lti_resource_handler_default` enum('1','2') NOT NULL DEFAULT '1' COMMENT '1->access, 2->denied. Access to resource by default if no user role is defined',
  PRIMARY KEY (`lti_resource_handler_id`),
  KEY `lti_resource_handler_id` (`lti_resource_handler_id`,`lti_resource_info_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `lti_resource_access`
--

INSERT INTO `lti_resource_access` (`lti_resource_handler_id`, `lti_resource_info_id`, `lti_user_role_id`, `lti_resource_handler_default`) VALUES
(1, 1, 2, '1');

-- --------------------------------------------------------

--
-- Table structure for table `lti_resource_info`
--

CREATE TABLE IF NOT EXISTS `lti_resource_info` (
  `lti_resource_info_id` int(11) NOT NULL AUTO_INCREMENT,
  `lti_resource_info_type` varchar(100) NOT NULL,
  `lti_resource_info_link` varchar(100) NOT NULL,
  `lti_resource_info_uniq_id` varchar(100) NOT NULL COMMENT 'Resource unique id to identify the resource',
  `lti_resource_info_status` enum('1','2') NOT NULL DEFAULT '1' COMMENT '1->Active, 2->Inactive',
  `lti_resource_info_req_role` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Is role required for thisresource',
  PRIMARY KEY (`lti_resource_info_id`),
  KEY `lti_resource_info_id` (`lti_resource_info_id`),
  KEY `lti_resource_info_uniq_id` (`lti_resource_info_uniq_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `lti_resource_info`
--

INSERT INTO `lti_resource_info` (`lti_resource_info_id`, `lti_resource_info_type`, `lti_resource_info_link`, `lti_resource_info_uniq_id`, `lti_resource_info_status`, `lti_resource_info_req_role`) VALUES
(1, 'PDF', 'http://172.16.1.55/lti_v2/tp/tp_registration.php?action=course_1', 'course_1', '1', 1),
(2, 'PDF', 'http://172.16.1.55/lti_v2/tp/tp_registration.php?action=course_2', 'course_2', '1', 1),
(3, 'PDF', 'http://172.16.1.55/lti_v2/tp/tp_registration.php?action=course_3', 'course_3', '1', 1),
(4, 'PDF', 'http://172.16.1.55/lti_v2/tp/tp_registration.php?action=course_4', 'course_4', '1', 0);

-- --------------------------------------------------------

--
-- Table structure for table `lti_tc_capability`
--

CREATE TABLE IF NOT EXISTS `lti_tc_capability` (
  `lti_tc_capability_id` int(11) NOT NULL AUTO_INCREMENT,
  `tool_proxy_reg_id` int(11) NOT NULL COMMENT 'Foreign key from lti_tool_proxy_reg table',
  `lti_consumer_secret_id` int(11) NOT NULL COMMENT 'foreign key from table `lti_consumer_secret` ',
  `capability_id` int(11) NOT NULL COMMENT 'foreign key from  lti_capabilities',
  `lti_tc_capability_insert_dts` datetime NOT NULL,
  PRIMARY KEY (`lti_tc_capability_id`),
  KEY `lti_tc_capability_id` (`lti_tc_capability_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=235 ;

--
-- Dumping data for table `lti_tc_capability`
--

INSERT INTO `lti_tc_capability` (`lti_tc_capability_id`, `tool_proxy_reg_id`, `lti_consumer_secret_id`, `capability_id`, `lti_tc_capability_insert_dts`) VALUES
(1, 1, 1, 1, '2016-05-26 20:45:32'),
(2, 1, 1, 2, '2016-05-26 20:45:32'),
(3, 1, 1, 3, '2016-05-26 20:45:32'),
(4, 1, 1, 4, '2016-05-26 20:45:32'),
(5, 1, 1, 5, '2016-05-26 20:45:32'),
(6, 1, 1, 6, '2016-05-26 20:45:32'),
(7, 1, 1, 7, '2016-05-26 20:45:32'),
(8, 1, 1, 8, '2016-05-26 20:45:32'),
(9, 1, 1, 9, '2016-05-26 20:45:32'),
(10, 1, 1, 10, '2016-05-26 20:45:32'),
(11, 1, 1, 11, '2016-05-26 20:45:32'),
(12, 1, 1, 12, '2016-05-26 20:45:32'),
(13, 1, 1, 11, '2016-05-26 20:45:32'),
(14, 7, 1, 1, '2016-05-30 16:41:22'),
(15, 7, 1, 2, '2016-05-30 16:41:22'),
(16, 7, 1, 3, '2016-05-30 16:41:22'),
(17, 7, 1, 4, '2016-05-30 16:41:22'),
(18, 7, 1, 5, '2016-05-30 16:41:22'),
(19, 7, 1, 6, '2016-05-30 16:41:22'),
(20, 7, 1, 7, '2016-05-30 16:41:22'),
(21, 7, 1, 8, '2016-05-30 16:41:22'),
(22, 7, 1, 9, '2016-05-30 16:41:22'),
(23, 7, 1, 10, '2016-05-30 16:41:22'),
(24, 7, 1, 11, '2016-05-30 16:41:22'),
(25, 7, 1, 12, '2016-05-30 16:41:22'),
(26, 7, 1, 11, '2016-05-30 16:41:22'),
(27, 9, 1, 1, '2016-05-30 18:38:04'),
(28, 9, 1, 2, '2016-05-30 18:38:04'),
(29, 9, 1, 3, '2016-05-30 18:38:04'),
(30, 9, 1, 4, '2016-05-30 18:38:04'),
(31, 9, 1, 5, '2016-05-30 18:38:04'),
(32, 9, 1, 6, '2016-05-30 18:38:04'),
(33, 9, 1, 7, '2016-05-30 18:38:04'),
(34, 9, 1, 8, '2016-05-30 18:38:04'),
(35, 9, 1, 9, '2016-05-30 18:38:04'),
(36, 9, 1, 10, '2016-05-30 18:38:04'),
(37, 9, 1, 11, '2016-05-30 18:38:04'),
(38, 9, 1, 12, '2016-05-30 18:38:04'),
(39, 9, 1, 11, '2016-05-30 18:38:04'),
(40, 10, 1, 1, '2016-05-30 18:40:16'),
(41, 10, 1, 2, '2016-05-30 18:40:16'),
(42, 10, 1, 3, '2016-05-30 18:40:16'),
(43, 10, 1, 4, '2016-05-30 18:40:16'),
(44, 10, 1, 5, '2016-05-30 18:40:16'),
(45, 10, 1, 6, '2016-05-30 18:40:16'),
(46, 10, 1, 7, '2016-05-30 18:40:16'),
(47, 10, 1, 8, '2016-05-30 18:40:16'),
(48, 10, 1, 9, '2016-05-30 18:40:16'),
(49, 10, 1, 10, '2016-05-30 18:40:16'),
(50, 10, 1, 11, '2016-05-30 18:40:16'),
(51, 10, 1, 12, '2016-05-30 18:40:16'),
(52, 10, 1, 11, '2016-05-30 18:40:16'),
(53, 11, 1, 1, '2016-05-30 18:40:42'),
(54, 11, 1, 2, '2016-05-30 18:40:42'),
(55, 11, 1, 3, '2016-05-30 18:40:42'),
(56, 11, 1, 4, '2016-05-30 18:40:42'),
(57, 11, 1, 5, '2016-05-30 18:40:42'),
(58, 11, 1, 6, '2016-05-30 18:40:42'),
(59, 11, 1, 7, '2016-05-30 18:40:42'),
(60, 11, 1, 8, '2016-05-30 18:40:42'),
(61, 11, 1, 9, '2016-05-30 18:40:42'),
(62, 11, 1, 10, '2016-05-30 18:40:42'),
(63, 11, 1, 11, '2016-05-30 18:40:42'),
(64, 11, 1, 12, '2016-05-30 18:40:42'),
(65, 11, 1, 11, '2016-05-30 18:40:42'),
(66, 12, 1, 1, '2016-05-30 18:40:54'),
(67, 12, 1, 2, '2016-05-30 18:40:54'),
(68, 12, 1, 3, '2016-05-30 18:40:54'),
(69, 12, 1, 4, '2016-05-30 18:40:54'),
(70, 12, 1, 5, '2016-05-30 18:40:54'),
(71, 12, 1, 6, '2016-05-30 18:40:54'),
(72, 12, 1, 7, '2016-05-30 18:40:54'),
(73, 12, 1, 8, '2016-05-30 18:40:54'),
(74, 12, 1, 9, '2016-05-30 18:40:54'),
(75, 12, 1, 10, '2016-05-30 18:40:54'),
(76, 12, 1, 11, '2016-05-30 18:40:54'),
(77, 12, 1, 12, '2016-05-30 18:40:54'),
(78, 12, 1, 11, '2016-05-30 18:40:54'),
(79, 13, 1, 1, '2016-05-30 18:41:21'),
(80, 13, 1, 2, '2016-05-30 18:41:21'),
(81, 13, 1, 3, '2016-05-30 18:41:21'),
(82, 13, 1, 4, '2016-05-30 18:41:21'),
(83, 13, 1, 5, '2016-05-30 18:41:21'),
(84, 13, 1, 6, '2016-05-30 18:41:21'),
(85, 13, 1, 7, '2016-05-30 18:41:21'),
(86, 13, 1, 8, '2016-05-30 18:41:21'),
(87, 13, 1, 9, '2016-05-30 18:41:21'),
(88, 13, 1, 10, '2016-05-30 18:41:21'),
(89, 13, 1, 11, '2016-05-30 18:41:21'),
(90, 13, 1, 12, '2016-05-30 18:41:21'),
(91, 13, 1, 11, '2016-05-30 18:41:21'),
(92, 1, 1, 1, '2016-05-30 18:42:57'),
(93, 1, 1, 2, '2016-05-30 18:42:57'),
(94, 1, 1, 3, '2016-05-30 18:42:57'),
(95, 1, 1, 4, '2016-05-30 18:42:57'),
(96, 1, 1, 5, '2016-05-30 18:42:57'),
(97, 1, 1, 6, '2016-05-30 18:42:57'),
(98, 1, 1, 7, '2016-05-30 18:42:57'),
(99, 1, 1, 8, '2016-05-30 18:42:57'),
(100, 1, 1, 9, '2016-05-30 18:42:57'),
(101, 1, 1, 10, '2016-05-30 18:42:57'),
(102, 1, 1, 11, '2016-05-30 18:42:57'),
(103, 1, 1, 12, '2016-05-30 18:42:57'),
(104, 1, 1, 11, '2016-05-30 18:42:57'),
(105, 2, 1, 1, '2016-06-01 20:21:02'),
(106, 2, 1, 2, '2016-06-01 20:21:02'),
(107, 2, 1, 3, '2016-06-01 20:21:02'),
(108, 2, 1, 4, '2016-06-01 20:21:02'),
(109, 2, 1, 5, '2016-06-01 20:21:02'),
(110, 2, 1, 6, '2016-06-01 20:21:02'),
(111, 2, 1, 7, '2016-06-01 20:21:02'),
(112, 2, 1, 8, '2016-06-01 20:21:02'),
(113, 2, 1, 9, '2016-06-01 20:21:02'),
(114, 2, 1, 10, '2016-06-01 20:21:02'),
(115, 2, 1, 11, '2016-06-01 20:21:02'),
(116, 2, 1, 12, '2016-06-01 20:21:02'),
(117, 2, 1, 11, '2016-06-01 20:21:02'),
(118, 3, 1, 1, '2016-06-03 11:30:04'),
(119, 3, 1, 2, '2016-06-03 11:30:04'),
(120, 3, 1, 3, '2016-06-03 11:30:04'),
(121, 3, 1, 4, '2016-06-03 11:30:04'),
(122, 3, 1, 5, '2016-06-03 11:30:04'),
(123, 3, 1, 6, '2016-06-03 11:30:04'),
(124, 3, 1, 7, '2016-06-03 11:30:04'),
(125, 3, 1, 8, '2016-06-03 11:30:04'),
(126, 3, 1, 9, '2016-06-03 11:30:04'),
(127, 3, 1, 10, '2016-06-03 11:30:04'),
(128, 3, 1, 11, '2016-06-03 11:30:04'),
(129, 3, 1, 12, '2016-06-03 11:30:04'),
(130, 3, 1, 11, '2016-06-03 11:30:04'),
(131, 3, 1, 1, '2016-06-03 18:04:16'),
(132, 3, 1, 2, '2016-06-03 18:04:16'),
(133, 3, 1, 3, '2016-06-03 18:04:16'),
(134, 3, 1, 4, '2016-06-03 18:04:16'),
(135, 3, 1, 5, '2016-06-03 18:04:16'),
(136, 3, 1, 6, '2016-06-03 18:04:16'),
(137, 3, 1, 7, '2016-06-03 18:04:16'),
(138, 3, 1, 8, '2016-06-03 18:04:16'),
(139, 3, 1, 9, '2016-06-03 18:04:16'),
(140, 3, 1, 10, '2016-06-03 18:04:16'),
(141, 3, 1, 11, '2016-06-03 18:04:16'),
(142, 3, 1, 12, '2016-06-03 18:04:16'),
(143, 3, 1, 11, '2016-06-03 18:04:16'),
(144, 4, 1, 1, '2016-06-03 18:05:37'),
(145, 4, 1, 2, '2016-06-03 18:05:37'),
(146, 4, 1, 3, '2016-06-03 18:05:37'),
(147, 4, 1, 4, '2016-06-03 18:05:37'),
(148, 4, 1, 5, '2016-06-03 18:05:37'),
(149, 4, 1, 6, '2016-06-03 18:05:37'),
(150, 4, 1, 7, '2016-06-03 18:05:37'),
(151, 4, 1, 8, '2016-06-03 18:05:37'),
(152, 4, 1, 9, '2016-06-03 18:05:37'),
(153, 4, 1, 10, '2016-06-03 18:05:37'),
(154, 4, 1, 11, '2016-06-03 18:05:37'),
(155, 4, 1, 12, '2016-06-03 18:05:37'),
(156, 4, 1, 11, '2016-06-03 18:05:37'),
(157, 5, 1, 1, '2016-06-03 18:41:13'),
(158, 5, 1, 2, '2016-06-03 18:41:13'),
(159, 5, 1, 3, '2016-06-03 18:41:13'),
(160, 5, 1, 4, '2016-06-03 18:41:13'),
(161, 5, 1, 5, '2016-06-03 18:41:13'),
(162, 5, 1, 6, '2016-06-03 18:41:13'),
(163, 5, 1, 7, '2016-06-03 18:41:13'),
(164, 5, 1, 8, '2016-06-03 18:41:13'),
(165, 5, 1, 9, '2016-06-03 18:41:13'),
(166, 5, 1, 10, '2016-06-03 18:41:13'),
(167, 5, 1, 11, '2016-06-03 18:41:13'),
(168, 5, 1, 12, '2016-06-03 18:41:13'),
(169, 5, 1, 11, '2016-06-03 18:41:13'),
(170, 6, 1, 1, '2016-06-03 19:37:29'),
(171, 6, 1, 2, '2016-06-03 19:37:29'),
(172, 6, 1, 3, '2016-06-03 19:37:29'),
(173, 6, 1, 4, '2016-06-03 19:37:29'),
(174, 6, 1, 5, '2016-06-03 19:37:29'),
(175, 6, 1, 6, '2016-06-03 19:37:29'),
(176, 6, 1, 7, '2016-06-03 19:37:29'),
(177, 6, 1, 8, '2016-06-03 19:37:29'),
(178, 6, 1, 9, '2016-06-03 19:37:29'),
(179, 6, 1, 10, '2016-06-03 19:37:29'),
(180, 6, 1, 11, '2016-06-03 19:37:29'),
(181, 6, 1, 12, '2016-06-03 19:37:29'),
(182, 6, 1, 11, '2016-06-03 19:37:29'),
(183, 7, 1, 1, '2016-06-03 19:53:32'),
(184, 7, 1, 2, '2016-06-03 19:53:32'),
(185, 7, 1, 3, '2016-06-03 19:53:32'),
(186, 7, 1, 4, '2016-06-03 19:53:32'),
(187, 7, 1, 5, '2016-06-03 19:53:32'),
(188, 7, 1, 6, '2016-06-03 19:53:32'),
(189, 7, 1, 7, '2016-06-03 19:53:32'),
(190, 7, 1, 8, '2016-06-03 19:53:32'),
(191, 7, 1, 9, '2016-06-03 19:53:32'),
(192, 7, 1, 10, '2016-06-03 19:53:32'),
(193, 7, 1, 11, '2016-06-03 19:53:32'),
(194, 7, 1, 12, '2016-06-03 19:53:32'),
(195, 7, 1, 11, '2016-06-03 19:53:32'),
(196, 8, 1, 1, '2016-06-03 19:55:39'),
(197, 8, 1, 2, '2016-06-03 19:55:39'),
(198, 8, 1, 3, '2016-06-03 19:55:39'),
(199, 8, 1, 4, '2016-06-03 19:55:39'),
(200, 8, 1, 5, '2016-06-03 19:55:39'),
(201, 8, 1, 6, '2016-06-03 19:55:39'),
(202, 8, 1, 7, '2016-06-03 19:55:39'),
(203, 8, 1, 8, '2016-06-03 19:55:39'),
(204, 8, 1, 9, '2016-06-03 19:55:39'),
(205, 8, 1, 10, '2016-06-03 19:55:39'),
(206, 8, 1, 11, '2016-06-03 19:55:39'),
(207, 8, 1, 12, '2016-06-03 19:55:39'),
(208, 8, 1, 11, '2016-06-03 19:55:39'),
(209, 9, 1, 1, '2016-06-09 12:35:41'),
(210, 9, 1, 2, '2016-06-09 12:35:41'),
(211, 9, 1, 3, '2016-06-09 12:35:41'),
(212, 9, 1, 4, '2016-06-09 12:35:41'),
(213, 9, 1, 5, '2016-06-09 12:35:41'),
(214, 9, 1, 6, '2016-06-09 12:35:41'),
(215, 9, 1, 7, '2016-06-09 12:35:41'),
(216, 9, 1, 8, '2016-06-09 12:35:41'),
(217, 9, 1, 9, '2016-06-09 12:35:41'),
(218, 9, 1, 10, '2016-06-09 12:35:41'),
(219, 9, 1, 11, '2016-06-09 12:35:41'),
(220, 9, 1, 12, '2016-06-09 12:35:41'),
(221, 9, 1, 11, '2016-06-09 12:35:41'),
(222, 10, 1, 1, '2016-06-09 17:06:34'),
(223, 10, 1, 2, '2016-06-09 17:06:34'),
(224, 10, 1, 3, '2016-06-09 17:06:34'),
(225, 10, 1, 4, '2016-06-09 17:06:34'),
(226, 10, 1, 5, '2016-06-09 17:06:34'),
(227, 10, 1, 6, '2016-06-09 17:06:34'),
(228, 10, 1, 7, '2016-06-09 17:06:34'),
(229, 10, 1, 8, '2016-06-09 17:06:34'),
(230, 10, 1, 9, '2016-06-09 17:06:34'),
(231, 10, 1, 10, '2016-06-09 17:06:34'),
(232, 10, 1, 11, '2016-06-09 17:06:34'),
(233, 10, 1, 12, '2016-06-09 17:06:34'),
(234, 10, 1, 11, '2016-06-09 17:06:34');

-- --------------------------------------------------------

--
-- Table structure for table `lti_tc_launch_detail`
--

CREATE TABLE IF NOT EXISTS `lti_tc_launch_detail` (
  `lti_tc_launch_id` int(11) NOT NULL AUTO_INCREMENT,
  `tool_proxy_reg_id` int(11) NOT NULL COMMENT 'PK from table  `lti_tool_proxy_reg`',
  `lti_tc_launch_context_id` varchar(100) NOT NULL,
  `lti_tc_launch_context_label` varchar(100) NOT NULL,
  `lti_tc_launch_context_title` varchar(100) NOT NULL,
  `lti_tc_launch_context_type` varchar(100) NOT NULL,
  `lti_tc_launch_presentation_css_url` varchar(200) NOT NULL,
  `lti_tc_launch_presentation_document_target` varchar(50) NOT NULL,
  `lti_tc_launch_presentation_locale` varchar(10) NOT NULL,
  `lti_tc_launch_presentation_return_url` varchar(200) NOT NULL,
  `lti_tc_launch_lis_outcome_service_url` varchar(200) NOT NULL,
  `lti_tc_launch_lis_person_contact_email_primary` varchar(100) NOT NULL,
  `lti_tc_launch_lis_person_name_family` varchar(100) NOT NULL,
  `lti_tc_launch_lis_person_name_full` varchar(100) NOT NULL,
  `lti_tc_launch_lis_person_name_given` varchar(100) NOT NULL,
  `lti_tc_launch_lis_person_sourcedid` varchar(100) NOT NULL,
  `lti_tc_launch_lis_result_sourcedid` varchar(100) NOT NULL,
  `lti_tc_launch_lti_version` varchar(100) NOT NULL,
  `lti_tc_launch_oauth_consumer_key` varchar(100) NOT NULL,
  `lti_tc_launch_oauth_signature` varchar(100) NOT NULL,
  `lti_tc_launch_oauth_callback` varchar(100) NOT NULL,
  `lti_tc_launch_oauth_nonce` varchar(100) NOT NULL,
  `lti_tc_launch_oauth_signature_method` varchar(100) NOT NULL,
  `lti_tc_launch_oauth_timestamp` varchar(100) NOT NULL,
  `lti_tc_launch_oauth_version` varchar(100) NOT NULL,
  `lti_tc_launch_resource_link_description` varchar(100) NOT NULL,
  `lti_tc_launch_resource_link_id` varchar(100) NOT NULL,
  `lti_tc_launch_resource_link_title` varchar(100) NOT NULL,
  `lti_tc_launch_roles` varchar(50) NOT NULL,
  `lti_tc_launch_tc_info_product_family_code` varchar(100) NOT NULL,
  `lti_tc_launch_tc_info_version` varchar(100) NOT NULL,
  `lti_tc_launch_tc_instance_contact_email` varchar(100) NOT NULL,
  `lti_tc_launch_tc_instance_description` varchar(200) NOT NULL,
  `lti_tc_launch_tc_instance_guid` varchar(100) NOT NULL,
  `lti_tc_launch_user_id` int(11) NOT NULL,
  `lti_tc_launch_user_image` varchar(200) NOT NULL,
  `lti_tc_launch_lis_course_offering_sourcedid` varchar(100) NOT NULL,
  `lti_tc_launch_lis_course_section_sourcedid` varchar(100) NOT NULL,
  `lti_tc_launch_tc_instance_name` varchar(100) NOT NULL,
  `lti_tc_launch_tc_instance_url` varchar(100) NOT NULL,
  `lti_tc_launch_insert_dts` datetime NOT NULL,
  PRIMARY KEY (`lti_tc_launch_id`),
  KEY `tool_proxy_reg_id` (`tool_proxy_reg_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=38 ;

--
-- Dumping data for table `lti_tc_launch_detail`
--

INSERT INTO `lti_tc_launch_detail` (`lti_tc_launch_id`, `tool_proxy_reg_id`, `lti_tc_launch_context_id`, `lti_tc_launch_context_label`, `lti_tc_launch_context_title`, `lti_tc_launch_context_type`, `lti_tc_launch_presentation_css_url`, `lti_tc_launch_presentation_document_target`, `lti_tc_launch_presentation_locale`, `lti_tc_launch_presentation_return_url`, `lti_tc_launch_lis_outcome_service_url`, `lti_tc_launch_lis_person_contact_email_primary`, `lti_tc_launch_lis_person_name_family`, `lti_tc_launch_lis_person_name_full`, `lti_tc_launch_lis_person_name_given`, `lti_tc_launch_lis_person_sourcedid`, `lti_tc_launch_lis_result_sourcedid`, `lti_tc_launch_lti_version`, `lti_tc_launch_oauth_consumer_key`, `lti_tc_launch_oauth_signature`, `lti_tc_launch_oauth_callback`, `lti_tc_launch_oauth_nonce`, `lti_tc_launch_oauth_signature_method`, `lti_tc_launch_oauth_timestamp`, `lti_tc_launch_oauth_version`, `lti_tc_launch_resource_link_description`, `lti_tc_launch_resource_link_id`, `lti_tc_launch_resource_link_title`, `lti_tc_launch_roles`, `lti_tc_launch_tc_info_product_family_code`, `lti_tc_launch_tc_info_version`, `lti_tc_launch_tc_instance_contact_email`, `lti_tc_launch_tc_instance_description`, `lti_tc_launch_tc_instance_guid`, `lti_tc_launch_user_id`, `lti_tc_launch_user_image`, `lti_tc_launch_lis_course_offering_sourcedid`, `lti_tc_launch_lis_course_section_sourcedid`, `lti_tc_launch_tc_instance_name`, `lti_tc_launch_tc_instance_url`, `lti_tc_launch_insert_dts`) VALUES
(1, 2, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '20d54297e081f2f12d8586f37edf2146:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '574ef657a561f', 'fgxh+PsXfoSTaK73jcWfE3me8B0=', 'about:blank', 'b7fecdab7cd81e1ed3ceb1efc1bbb2ef', 'HMAC-SHA1', '1464868322', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-02 17:20:43'),
(2, 2, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '20d54297e081f2f12d8586f37edf2146:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '574ef657a561f', 'i88W6nIZEFKkh8wzmacinpKDbt8=', 'about:blank', '6ee15e4c61f59c7e261e570af3095447', 'HMAC-SHA1', '1464869907', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-02 17:47:07'),
(3, 2, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '20d54297e081f2f12d8586f37edf2146:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '574ef657a561f', 'h9suOXrwrazeQ8PyMnoIPQ9JpEA=', 'about:blank', '17d56e878d5a5fad8fc481932c235638', 'HMAC-SHA1', '1464877234', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-02 19:49:15'),
(4, 2, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '20d54297e081f2f12d8586f37edf2146:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '574ef657a561f', 'ZdRHEfEFhihLdP4yR51ccW12wqw=', 'about:blank', '3d40a74d73ae584880923298d3a531ff', 'HMAC-SHA1', '1464881216', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-02 20:55:38'),
(5, 2, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'iframe', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '3cdf23aeb3daedf771c0309f9f8c9af5:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '574ef657a561f', 'bJZ3hYKyMEhbm2vXx1DWICJuWrs=', 'about:blank', '20dd78a791415dd9a055a74aeb3c7913', 'HMAC-SHA1', '1464945838', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-03 14:52:39'),
(6, 2, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', '_iframe', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '3cdf23aeb3daedf771c0309f9f8c9af5:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '574ef657a561f', 'Y3iBRkHGQEBnEtxWxZ/FQJ98xjs=', 'about:blank', '3b15e20f0dfdc1cf837db14e6ee51d7e', 'HMAC-SHA1', '1464945910', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-03 14:53:53'),
(7, 2, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '3cdf23aeb3daedf771c0309f9f8c9af5:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '574ef657a561f', 'Nr5Fa6jlsUW2yfzz+l4rQ1T9UvE=', 'about:blank', 'd616d1fdc3ab9a86d97f5f514d1e49b9', 'HMAC-SHA1', '1464945936', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-03 14:54:15'),
(8, 2, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '3cdf23aeb3daedf771c0309f9f8c9af5:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '574ef657a561f', 'DLcw4tPD/Fe66xLNlic/usS2RwM=', 'about:blank', '7f1686e450e42c6fc578866a7d60174f', 'HMAC-SHA1', '1464945945', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-03 14:54:27'),
(9, 2, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '3cdf23aeb3daedf771c0309f9f8c9af5:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '574ef657a561f', 'FbcmmhBvNuUuuLbeNIhTt/Higbc=', 'about:blank', '36f80da73bc2e6a7e952be422cc5868d', 'HMAC-SHA1', '1464949695', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-03 15:56:56'),
(10, 2, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '3cdf23aeb3daedf771c0309f9f8c9af5:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '574ef657a561f', 'FbcmmhBvNuUuuLbeNIhTt/Higbc=', 'about:blank', '36f80da73bc2e6a7e952be422cc5868d', 'HMAC-SHA1', '1464949695', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-03 16:01:12'),
(11, 2, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '3cdf23aeb3daedf771c0309f9f8c9af5:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '574ef657a561f', 'VihJoz06AQNlK6R2kgUY7mC+kYg=', 'about:blank', 'a1885f9a304d758027493631c07063df', 'HMAC-SHA1', '1464949997', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-03 16:01:57'),
(12, 2, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '3cdf23aeb3daedf771c0309f9f8c9af5:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '574ef657a561f', 'm/sJdbFdNUqs0Hfb2/RKzHWymsQ=', 'about:blank', '7697507722c59ce46543efd9a55fddbf', 'HMAC-SHA1', '1464951248', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-03 16:22:49'),
(13, 2, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '3cdf23aeb3daedf771c0309f9f8c9af5:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '574ef657a561f', 'cCvbBmDdVphBnbUeChYoeugSyJo=', 'about:blank', '2febf46df5f6a8ba3c43e023d5cebc6c', 'HMAC-SHA1', '1464951263', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-03 16:23:04'),
(14, 2, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '3cdf23aeb3daedf771c0309f9f8c9af5:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '574ef657a561f', 'cCvbBmDdVphBnbUeChYoeugSyJo=', 'about:blank', '2febf46df5f6a8ba3c43e023d5cebc6c', 'HMAC-SHA1', '1464951263', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-03 16:23:17'),
(15, 2, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '3cdf23aeb3daedf771c0309f9f8c9af5:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '574ef657a561f', 'vAvGoNRnBMMGuDej2sC7iSKk+tQ=', 'about:blank', '054c8962843943ecb41aea81d21f3f40', 'HMAC-SHA1', '1464951971', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-03 16:34:54'),
(16, 2, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '3cdf23aeb3daedf771c0309f9f8c9af5:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '574ef657a561f', 'ctQ5fJ0y1Lo04MPtsGV/zWzBNb0=', 'about:blank', 'c318c86d1c9493acfa4731f6491968a8', 'HMAC-SHA1', '1464952076', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-03 16:36:43'),
(17, 2, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '3cdf23aeb3daedf771c0309f9f8c9af5:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '574ef657a561f', 'yJpFcFbUwaL/5ToNxx2xmQ76eLM=', 'about:blank', '0b09e32d26187859f703fc4995980b58', 'HMAC-SHA1', '1464952183', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-03 16:38:24'),
(18, 2, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '3cdf23aeb3daedf771c0309f9f8c9af5:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '574ef657a561f', 'qtaIK6SvyL2xN3mwCMjKGjbTGDU=', 'about:blank', '434cfce107d8e954c9245faf9c49a22f', 'HMAC-SHA1', '1464952220', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-03 16:39:00'),
(19, 2, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '3cdf23aeb3daedf771c0309f9f8c9af5:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '574ef657a561f', 'hHa3pj3IZZ2IIaSQxN77EgRQ5tE=', 'about:blank', '00f842c91247c605b28fcac78a31e021', 'HMAC-SHA1', '1464952230', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-03 16:39:10'),
(20, 2, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '3cdf23aeb3daedf771c0309f9f8c9af5:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '574ef657a561f', '+QGSQce1ia1kWCwhvxvTy9ZFDCo=', 'about:blank', '54e791ef45ca9b299e95c18870f997ae', 'HMAC-SHA1', '1464952247', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-03 16:39:28'),
(21, 2, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '3cdf23aeb3daedf771c0309f9f8c9af5:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '574ef657a561f', 'TG1gLNqAYnt1XW5/rIq8c5AdZeg=', 'about:blank', '08f5983371efe35dee2ed12033c4cc93', 'HMAC-SHA1', '1464952281', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-03 16:40:02'),
(22, 2, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '3cdf23aeb3daedf771c0309f9f8c9af5:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '574ef657a561f', 'N+3fH0y6NXk1+4a/jxu0qz02JIs=', 'about:blank', 'f35dcd3d3fc0e07099ff4149c2284374', 'HMAC-SHA1', '1464952338', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-03 16:41:02'),
(23, 2, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '3cdf23aeb3daedf771c0309f9f8c9af5:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '574ef657a561f', 'PqB3M9y8B50UBHvBYNltenO5h18=', 'about:blank', 'ffb83579d62d16b0f55bd2b086ff4955', 'HMAC-SHA1', '1464952374', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-03 16:41:35'),
(24, 3, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '3cdf23aeb3daedf771c0309f9f8c9af5:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '575179493f4f3', 'spEzwWvr63SwDGClg8DNkfKqDqY=', 'about:blank', '4583c0811f6e7bf8c5bcf8295cbaed8b', 'HMAC-SHA1', '1464958690', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-03 18:26:51'),
(25, 3, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '3cdf23aeb3daedf771c0309f9f8c9af5:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '575179493f4f3', '0ZmMPaKWz1AUXXFv7mlhOqNrTlU=', 'about:blank', 'e15f6fc08a1420691f4057cbf5b12869', 'HMAC-SHA1', '1464960092', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-03 18:50:12'),
(26, 3, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '3cdf23aeb3daedf771c0309f9f8c9af5:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '575179493f4f3', 'bq2EQuJeVT9HGcA24TeYOVBR280=', 'about:blank', 'd635a4018d1098e09f5e5d129a826ac8', 'HMAC-SHA1', '1464962939', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-03 19:37:40'),
(27, 3, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '3cdf23aeb3daedf771c0309f9f8c9af5:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '575179493f4f3', 'GK2C1zPZu6KjpdzmlQ7xEmFoPWk=', 'about:blank', 'e64ca92ea2cf4e2914548a7a8a5560f1', 'HMAC-SHA1', '1464963923', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-03 19:54:04'),
(28, 3, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', '3cdf23aeb3daedf771c0309f9f8c9af5:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '575179493f4f3', '5wPzRzOgex+ZpSfBPcUia/Ug2K0=', 'about:blank', 'e852f7cbf48999507b3cbf700be67e2d', 'HMAC-SHA1', '1464964083', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-03 19:56:43'),
(29, 9, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', 'eba12f2ee6c60fff3302118fedd34d99:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '575915468696d', 'L5uJsMtCsWa3bc9ED563xRvgeaI=', 'about:blank', 'c7e8742d57eb3346a2ecac13c585a23d', 'HMAC-SHA1', '1465456124', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-09 12:37:22'),
(30, 9, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', 'eba12f2ee6c60fff3302118fedd34d99:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '575915468696d', '6ri/MF4j4+0r/jQr4Auqqs5T1U8=', 'about:blank', '37ff3f9bcdcc9b4b3e5f678550965c5b', 'HMAC-SHA1', '1465456159', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-09 12:37:57'),
(31, 9, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', 'eba12f2ee6c60fff3302118fedd34d99:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '575915468696d', '3itWGjunjDSyzzR8LfHQM3mPYwA=', 'about:blank', '6cdb627a9766031712b368c95cefe39a', 'HMAC-SHA1', '1465471857', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-09 16:59:34'),
(32, 9, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', 'eba12f2ee6c60fff3302118fedd34d99:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '575915468696d', 'ELzM4q3EYtM1XAFCpJRJ03QVn3E=', 'about:blank', '08ff01d993c46a1f4fc799ff3484a530', 'HMAC-SHA1', '1465471875', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-09 16:59:51'),
(33, 9, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', 'eba12f2ee6c60fff3302118fedd34d99:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '575915468696d', 'nfHxJv+lN4mmURW8BFZ/foAcep8=', 'about:blank', 'd5af89dc941d729ebc427998038425be', 'HMAC-SHA1', '1465471895', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-09 17:00:12'),
(34, 9, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', 'eba12f2ee6c60fff3302118fedd34d99:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '575915468696d', 'SEskbhVpcLMvbNA6UlP5AlVfJNQ=', 'about:blank', '719ce75c3c1d539786a6eca0dab7b1c7', 'HMAC-SHA1', '1465472502', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-09 17:11:10'),
(35, 9, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', 'eba12f2ee6c60fff3302118fedd34d99:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '575915468696d', '3lZRyg/9xQ4+Arc62PoJuKPo5LY=', 'about:blank', '2a331185dc0cc0002ccf998a55d7fd02', 'HMAC-SHA1', '1465472589', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-09 17:11:46'),
(36, 9, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', 'eba12f2ee6c60fff3302118fedd34d99:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '575915468696d', 'soZBdpT1YyTX/AXEa3ucqf7QMzk=', 'about:blank', 'd6c8c84fc683da822e88d297d61cb0f8', 'HMAC-SHA1', '1465472663', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-09 17:12:59'),
(37, 9, 'S3294476', 'ST101', 'Telecommuncations 101', 'CourseSection', 'http://ltiapps.net/test/css/tc.css', 'frame', 'en-GB', 'http://ltiapps.net/test/tc-return.php', 'http://ltiapps.net/test/tc-outcomes.php', 'jbaird@uni.ac.uk', 'Baird', 'John Logie Baird', 'John', 'sis:942a8dd9', 'eba12f2ee6c60fff3302118fedd34d99:::S3294476:::29123:::dyJ86SiwwA9', 'LTI-2p0', '575915468696d', 'CCmaXFUAYqUfRs+eBPJp6mvcoFY=', 'about:blank', '8cc2f0d64b13b7722700d62bef895d0b', 'HMAC-SHA1', '1465476169', '1.0', 'Will ET phone home, or not; click to discover more.', '429785226', 'Phone home', 'Instructor', 'jisc', '1.2', 'vle@uni.ac.uk', 'A Higher Education establishment in a land far, far away.', 'vle.uni.ac.uk', 29123, 'http://ltiapps.net/test/images/lti.gif', 'DD-ST101', 'DD-ST101:C1', 'University of JISC', 'https://vle.uni.ac.uk/', '2016-06-09 18:11:25');

-- --------------------------------------------------------

--
-- Table structure for table `lti_tc_service`
--

CREATE TABLE IF NOT EXISTS `lti_tc_service` (
  `lti_tc_services_id` int(11) NOT NULL AUTO_INCREMENT,
  `tool_proxy_reg_id` int(11) NOT NULL,
  `lti_consumer_secret_id` int(11) NOT NULL,
  `lti_tc_services_type` varchar(50) NOT NULL,
  `lti_tc_services_id_val` varchar(100) NOT NULL,
  `lti_tc_services_endpoint` varchar(100) NOT NULL,
  `lti_tc_services_format` varchar(200) NOT NULL,
  `lti_tc_services_action` varchar(20) NOT NULL,
  `lti_tc_services_created_dts` datetime NOT NULL,
  PRIMARY KEY (`lti_tc_services_id`),
  KEY `tool_proxy_reg_id` (`tool_proxy_reg_id`,`lti_consumer_secret_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Holds the Tool Consumer Services provided during tool regist' AUTO_INCREMENT=127 ;

--
-- Dumping data for table `lti_tc_service`
--

INSERT INTO `lti_tc_service` (`lti_tc_services_id`, `tool_proxy_reg_id`, `lti_consumer_secret_id`, `lti_tc_services_type`, `lti_tc_services_id_val`, `lti_tc_services_endpoint`, `lti_tc_services_format`, `lti_tc_services_action`, `lti_tc_services_created_dts`) VALUES
(1, 1, 1, 'RestService', 'tcp:ToolProxy.collection', 'http://mylocal/lti_v2/tc/tc_register.php', 'application/vnd.ims.lti.v2.toolproxy+json', 'POST', '2016-05-26 20:45:33'),
(2, 1, 1, 'RestService', 'tcp:ToolProxy.item', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}', 'application/vnd.ims.lti.v2.toolproxy+json', 'GET & PUT', '2016-05-26 20:45:33'),
(3, 1, 1, 'RestService', 'tcp:Result.item', 'http://lms.example.com/resources/Result/{sourcedId}', 'application/vnd.ims.lis.v2.result+json', 'GET & PUT', '2016-05-26 20:45:33'),
(4, 1, 1, 'RestService', 'tcp:LtiLinkSettings', 'http://lms.example.com/resources/links/{link_id}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-05-26 20:45:33'),
(5, 1, 1, 'RestService', 'tcp:ToolProxyBindingSettings', 'http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_cod', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-05-26 20:45:33'),
(6, 1, 1, 'RestService', 'tcp:ToolProxySettings', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-05-26 20:45:33'),
(7, 1, 1, 'RestService', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'application/vnd.ims.lti.v1.outcome+xml', 'POST', '2016-05-26 20:45:33'),
(8, 7, 1, 'RestService', 'tcp:ToolProxy.collection', 'http://mylocal/lti_v2/tc/tc_register.php', 'application/vnd.ims.lti.v2.toolproxy+json', 'POST', '2016-05-30 16:41:22'),
(9, 7, 1, 'RestService', 'tcp:ToolProxy.item', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}', 'application/vnd.ims.lti.v2.toolproxy+json', 'GET & PUT', '2016-05-30 16:41:22'),
(10, 7, 1, 'RestService', 'tcp:Result.item', 'http://lms.example.com/resources/Result/{sourcedId}', 'application/vnd.ims.lis.v2.result+json', 'GET & PUT', '2016-05-30 16:41:22'),
(11, 7, 1, 'RestService', 'tcp:LtiLinkSettings', 'http://lms.example.com/resources/links/{link_id}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-05-30 16:41:22'),
(12, 7, 1, 'RestService', 'tcp:ToolProxyBindingSettings', 'http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_cod', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-05-30 16:41:22'),
(13, 7, 1, 'RestService', 'tcp:ToolProxySettings', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-05-30 16:41:22'),
(14, 7, 1, 'RestService', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'application/vnd.ims.lti.v1.outcome+xml', 'POST', '2016-05-30 16:41:22'),
(15, 9, 1, 'RestService', 'tcp:ToolProxy.collection', 'http://mylocal/lti_v2/tc/tc_register.php', 'application/vnd.ims.lti.v2.toolproxy+json', 'POST', '2016-05-30 18:38:04'),
(16, 9, 1, 'RestService', 'tcp:ToolProxy.item', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}', 'application/vnd.ims.lti.v2.toolproxy+json', 'GET & PUT', '2016-05-30 18:38:04'),
(17, 9, 1, 'RestService', 'tcp:Result.item', 'http://lms.example.com/resources/Result/{sourcedId}', 'application/vnd.ims.lis.v2.result+json', 'GET & PUT', '2016-05-30 18:38:04'),
(18, 9, 1, 'RestService', 'tcp:LtiLinkSettings', 'http://lms.example.com/resources/links/{link_id}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-05-30 18:38:04'),
(19, 9, 1, 'RestService', 'tcp:ToolProxyBindingSettings', 'http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_cod', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-05-30 18:38:04'),
(20, 9, 1, 'RestService', 'tcp:ToolProxySettings', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-05-30 18:38:04'),
(21, 9, 1, 'RestService', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'application/vnd.ims.lti.v1.outcome+xml', 'POST', '2016-05-30 18:38:04'),
(22, 10, 1, 'RestService', 'tcp:ToolProxy.collection', 'http://mylocal/lti_v2/tc/tc_register.php', 'application/vnd.ims.lti.v2.toolproxy+json', 'POST', '2016-05-30 18:40:17'),
(23, 10, 1, 'RestService', 'tcp:ToolProxy.item', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}', 'application/vnd.ims.lti.v2.toolproxy+json', 'GET & PUT', '2016-05-30 18:40:17'),
(24, 10, 1, 'RestService', 'tcp:Result.item', 'http://lms.example.com/resources/Result/{sourcedId}', 'application/vnd.ims.lis.v2.result+json', 'GET & PUT', '2016-05-30 18:40:17'),
(25, 10, 1, 'RestService', 'tcp:LtiLinkSettings', 'http://lms.example.com/resources/links/{link_id}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-05-30 18:40:17'),
(26, 10, 1, 'RestService', 'tcp:ToolProxyBindingSettings', 'http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_cod', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-05-30 18:40:17'),
(27, 10, 1, 'RestService', 'tcp:ToolProxySettings', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-05-30 18:40:17'),
(28, 10, 1, 'RestService', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'application/vnd.ims.lti.v1.outcome+xml', 'POST', '2016-05-30 18:40:17'),
(29, 11, 1, 'RestService', 'tcp:ToolProxy.collection', 'http://mylocal/lti_v2/tc/tc_register.php', 'application/vnd.ims.lti.v2.toolproxy+json', 'POST', '2016-05-30 18:40:43'),
(30, 11, 1, 'RestService', 'tcp:ToolProxy.item', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}', 'application/vnd.ims.lti.v2.toolproxy+json', 'GET & PUT', '2016-05-30 18:40:43'),
(31, 11, 1, 'RestService', 'tcp:Result.item', 'http://lms.example.com/resources/Result/{sourcedId}', 'application/vnd.ims.lis.v2.result+json', 'GET & PUT', '2016-05-30 18:40:43'),
(32, 11, 1, 'RestService', 'tcp:LtiLinkSettings', 'http://lms.example.com/resources/links/{link_id}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-05-30 18:40:43'),
(33, 11, 1, 'RestService', 'tcp:ToolProxyBindingSettings', 'http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_cod', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-05-30 18:40:43'),
(34, 11, 1, 'RestService', 'tcp:ToolProxySettings', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-05-30 18:40:43'),
(35, 11, 1, 'RestService', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'application/vnd.ims.lti.v1.outcome+xml', 'POST', '2016-05-30 18:40:43'),
(36, 12, 1, 'RestService', 'tcp:ToolProxy.collection', 'http://mylocal/lti_v2/tc/tc_register.php', 'application/vnd.ims.lti.v2.toolproxy+json', 'POST', '2016-05-30 18:40:55'),
(37, 12, 1, 'RestService', 'tcp:ToolProxy.item', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}', 'application/vnd.ims.lti.v2.toolproxy+json', 'GET & PUT', '2016-05-30 18:40:55'),
(38, 12, 1, 'RestService', 'tcp:Result.item', 'http://lms.example.com/resources/Result/{sourcedId}', 'application/vnd.ims.lis.v2.result+json', 'GET & PUT', '2016-05-30 18:40:55'),
(39, 12, 1, 'RestService', 'tcp:LtiLinkSettings', 'http://lms.example.com/resources/links/{link_id}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-05-30 18:40:55'),
(40, 12, 1, 'RestService', 'tcp:ToolProxyBindingSettings', 'http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_cod', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-05-30 18:40:55'),
(41, 12, 1, 'RestService', 'tcp:ToolProxySettings', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-05-30 18:40:55'),
(42, 12, 1, 'RestService', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'application/vnd.ims.lti.v1.outcome+xml', 'POST', '2016-05-30 18:40:55'),
(43, 13, 1, 'RestService', 'tcp:ToolProxy.collection', 'http://mylocal/lti_v2/tc/tc_register.php', 'application/vnd.ims.lti.v2.toolproxy+json', 'POST', '2016-05-30 18:41:21'),
(44, 13, 1, 'RestService', 'tcp:ToolProxy.item', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}', 'application/vnd.ims.lti.v2.toolproxy+json', 'GET & PUT', '2016-05-30 18:41:21'),
(45, 13, 1, 'RestService', 'tcp:Result.item', 'http://lms.example.com/resources/Result/{sourcedId}', 'application/vnd.ims.lis.v2.result+json', 'GET & PUT', '2016-05-30 18:41:21'),
(46, 13, 1, 'RestService', 'tcp:LtiLinkSettings', 'http://lms.example.com/resources/links/{link_id}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-05-30 18:41:21'),
(47, 13, 1, 'RestService', 'tcp:ToolProxyBindingSettings', 'http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_cod', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-05-30 18:41:21'),
(48, 13, 1, 'RestService', 'tcp:ToolProxySettings', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-05-30 18:41:21'),
(49, 13, 1, 'RestService', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'application/vnd.ims.lti.v1.outcome+xml', 'POST', '2016-05-30 18:41:21'),
(50, 1, 1, 'RestService', 'tcp:ToolProxy.collection', 'http://mylocal/lti_v2/tc/tc_register.php', 'application/vnd.ims.lti.v2.toolproxy+json', 'POST', '2016-05-30 18:42:57'),
(51, 1, 1, 'RestService', 'tcp:ToolProxy.item', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}', 'application/vnd.ims.lti.v2.toolproxy+json', 'GET & PUT', '2016-05-30 18:42:57'),
(52, 1, 1, 'RestService', 'tcp:Result.item', 'http://lms.example.com/resources/Result/{sourcedId}', 'application/vnd.ims.lis.v2.result+json', 'GET & PUT', '2016-05-30 18:42:57'),
(53, 1, 1, 'RestService', 'tcp:LtiLinkSettings', 'http://lms.example.com/resources/links/{link_id}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-05-30 18:42:57'),
(54, 1, 1, 'RestService', 'tcp:ToolProxyBindingSettings', 'http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_cod', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-05-30 18:42:57'),
(55, 1, 1, 'RestService', 'tcp:ToolProxySettings', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-05-30 18:42:57'),
(56, 1, 1, 'RestService', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'application/vnd.ims.lti.v1.outcome+xml', 'POST', '2016-05-30 18:42:57'),
(57, 2, 1, 'RestService', 'tcp:ToolProxy.collection', 'http://mylocal/lti_v2/tc/tc_register.php', 'application/vnd.ims.lti.v2.toolproxy+json', 'POST', '2016-06-01 20:21:03'),
(58, 2, 1, 'RestService', 'tcp:ToolProxy.item', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}', 'application/vnd.ims.lti.v2.toolproxy+json', 'GET & PUT', '2016-06-01 20:21:03'),
(59, 2, 1, 'RestService', 'tcp:Result.item', 'http://lms.example.com/resources/Result/{sourcedId}', 'application/vnd.ims.lis.v2.result+json', 'GET & PUT', '2016-06-01 20:21:03'),
(60, 2, 1, 'RestService', 'tcp:LtiLinkSettings', 'http://lms.example.com/resources/links/{link_id}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-01 20:21:03'),
(61, 2, 1, 'RestService', 'tcp:ToolProxyBindingSettings', 'http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_cod', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-01 20:21:03'),
(62, 2, 1, 'RestService', 'tcp:ToolProxySettings', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-01 20:21:03'),
(63, 2, 1, 'RestService', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'application/vnd.ims.lti.v1.outcome+xml', 'POST', '2016-06-01 20:21:03'),
(64, 3, 1, 'RestService', 'tcp:ToolProxy.collection', 'http://mylocal/lti_v2/tc/tc_register.php', 'application/vnd.ims.lti.v2.toolproxy+json', 'POST', '2016-06-03 11:30:05'),
(65, 3, 1, 'RestService', 'tcp:ToolProxy.item', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}', 'application/vnd.ims.lti.v2.toolproxy+json', 'GET & PUT', '2016-06-03 11:30:05'),
(66, 3, 1, 'RestService', 'tcp:Result.item', 'http://lms.example.com/resources/Result/{sourcedId}', 'application/vnd.ims.lis.v2.result+json', 'GET & PUT', '2016-06-03 11:30:05'),
(67, 3, 1, 'RestService', 'tcp:LtiLinkSettings', 'http://lms.example.com/resources/links/{link_id}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-03 11:30:05'),
(68, 3, 1, 'RestService', 'tcp:ToolProxyBindingSettings', 'http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_cod', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-03 11:30:05'),
(69, 3, 1, 'RestService', 'tcp:ToolProxySettings', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-03 11:30:05'),
(70, 3, 1, 'RestService', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'application/vnd.ims.lti.v1.outcome+xml', 'POST', '2016-06-03 11:30:05'),
(71, 3, 1, 'RestService', 'tcp:ToolProxy.collection', 'http://mylocal/lti_v2/tc/tc_register.php', 'application/vnd.ims.lti.v2.toolproxy+json', 'POST', '2016-06-03 18:04:16'),
(72, 3, 1, 'RestService', 'tcp:ToolProxy.item', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}', 'application/vnd.ims.lti.v2.toolproxy+json', 'GET & PUT', '2016-06-03 18:04:16'),
(73, 3, 1, 'RestService', 'tcp:Result.item', 'http://lms.example.com/resources/Result/{sourcedId}', 'application/vnd.ims.lis.v2.result+json', 'GET & PUT', '2016-06-03 18:04:16'),
(74, 3, 1, 'RestService', 'tcp:LtiLinkSettings', 'http://lms.example.com/resources/links/{link_id}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-03 18:04:16'),
(75, 3, 1, 'RestService', 'tcp:ToolProxyBindingSettings', 'http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_cod', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-03 18:04:16'),
(76, 3, 1, 'RestService', 'tcp:ToolProxySettings', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-03 18:04:16'),
(77, 3, 1, 'RestService', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'application/vnd.ims.lti.v1.outcome+xml', 'POST', '2016-06-03 18:04:16'),
(78, 4, 1, 'RestService', 'tcp:ToolProxy.collection', 'http://mylocal/lti_v2/tc/tc_register.php', 'application/vnd.ims.lti.v2.toolproxy+json', 'POST', '2016-06-03 18:05:37'),
(79, 4, 1, 'RestService', 'tcp:ToolProxy.item', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}', 'application/vnd.ims.lti.v2.toolproxy+json', 'GET & PUT', '2016-06-03 18:05:37'),
(80, 4, 1, 'RestService', 'tcp:Result.item', 'http://lms.example.com/resources/Result/{sourcedId}', 'application/vnd.ims.lis.v2.result+json', 'GET & PUT', '2016-06-03 18:05:37'),
(81, 4, 1, 'RestService', 'tcp:LtiLinkSettings', 'http://lms.example.com/resources/links/{link_id}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-03 18:05:37'),
(82, 4, 1, 'RestService', 'tcp:ToolProxyBindingSettings', 'http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_cod', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-03 18:05:37'),
(83, 4, 1, 'RestService', 'tcp:ToolProxySettings', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-03 18:05:37'),
(84, 4, 1, 'RestService', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'application/vnd.ims.lti.v1.outcome+xml', 'POST', '2016-06-03 18:05:37'),
(85, 5, 1, 'RestService', 'tcp:ToolProxy.collection', 'http://mylocal/lti_v2/tc/tc_register.php', 'application/vnd.ims.lti.v2.toolproxy+json', 'POST', '2016-06-03 18:41:13'),
(86, 5, 1, 'RestService', 'tcp:ToolProxy.item', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}', 'application/vnd.ims.lti.v2.toolproxy+json', 'GET & PUT', '2016-06-03 18:41:13'),
(87, 5, 1, 'RestService', 'tcp:Result.item', 'http://lms.example.com/resources/Result/{sourcedId}', 'application/vnd.ims.lis.v2.result+json', 'GET & PUT', '2016-06-03 18:41:13'),
(88, 5, 1, 'RestService', 'tcp:LtiLinkSettings', 'http://lms.example.com/resources/links/{link_id}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-03 18:41:13'),
(89, 5, 1, 'RestService', 'tcp:ToolProxyBindingSettings', 'http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_cod', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-03 18:41:13'),
(90, 5, 1, 'RestService', 'tcp:ToolProxySettings', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-03 18:41:13'),
(91, 5, 1, 'RestService', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'application/vnd.ims.lti.v1.outcome+xml', 'POST', '2016-06-03 18:41:13'),
(92, 6, 1, 'RestService', 'tcp:ToolProxy.collection', 'http://mylocal/lti_v2/tc/tc_register.php', 'application/vnd.ims.lti.v2.toolproxy+json', 'POST', '2016-06-03 19:37:29'),
(93, 6, 1, 'RestService', 'tcp:ToolProxy.item', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}', 'application/vnd.ims.lti.v2.toolproxy+json', 'GET & PUT', '2016-06-03 19:37:29'),
(94, 6, 1, 'RestService', 'tcp:Result.item', 'http://lms.example.com/resources/Result/{sourcedId}', 'application/vnd.ims.lis.v2.result+json', 'GET & PUT', '2016-06-03 19:37:29'),
(95, 6, 1, 'RestService', 'tcp:LtiLinkSettings', 'http://lms.example.com/resources/links/{link_id}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-03 19:37:29'),
(96, 6, 1, 'RestService', 'tcp:ToolProxyBindingSettings', 'http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_cod', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-03 19:37:29'),
(97, 6, 1, 'RestService', 'tcp:ToolProxySettings', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-03 19:37:29'),
(98, 6, 1, 'RestService', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'application/vnd.ims.lti.v1.outcome+xml', 'POST', '2016-06-03 19:37:29'),
(99, 7, 1, 'RestService', 'tcp:ToolProxy.collection', 'http://mylocal/lti_v2/tc/tc_register.php', 'application/vnd.ims.lti.v2.toolproxy+json', 'POST', '2016-06-03 19:53:32'),
(100, 7, 1, 'RestService', 'tcp:ToolProxy.item', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}', 'application/vnd.ims.lti.v2.toolproxy+json', 'GET & PUT', '2016-06-03 19:53:32'),
(101, 7, 1, 'RestService', 'tcp:Result.item', 'http://lms.example.com/resources/Result/{sourcedId}', 'application/vnd.ims.lis.v2.result+json', 'GET & PUT', '2016-06-03 19:53:32'),
(102, 7, 1, 'RestService', 'tcp:LtiLinkSettings', 'http://lms.example.com/resources/links/{link_id}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-03 19:53:32'),
(103, 7, 1, 'RestService', 'tcp:ToolProxyBindingSettings', 'http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_cod', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-03 19:53:32'),
(104, 7, 1, 'RestService', 'tcp:ToolProxySettings', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-03 19:53:32'),
(105, 7, 1, 'RestService', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'application/vnd.ims.lti.v1.outcome+xml', 'POST', '2016-06-03 19:53:32'),
(106, 8, 1, 'RestService', 'tcp:ToolProxy.collection', 'http://mylocal/lti_v2/tc/tc_register.php', 'application/vnd.ims.lti.v2.toolproxy+json', 'POST', '2016-06-03 19:55:40'),
(107, 8, 1, 'RestService', 'tcp:ToolProxy.item', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}', 'application/vnd.ims.lti.v2.toolproxy+json', 'GET & PUT', '2016-06-03 19:55:40'),
(108, 8, 1, 'RestService', 'tcp:Result.item', 'http://lms.example.com/resources/Result/{sourcedId}', 'application/vnd.ims.lis.v2.result+json', 'GET & PUT', '2016-06-03 19:55:40'),
(109, 8, 1, 'RestService', 'tcp:LtiLinkSettings', 'http://lms.example.com/resources/links/{link_id}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-03 19:55:40'),
(110, 8, 1, 'RestService', 'tcp:ToolProxyBindingSettings', 'http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_cod', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-03 19:55:40'),
(111, 8, 1, 'RestService', 'tcp:ToolProxySettings', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-03 19:55:40'),
(112, 8, 1, 'RestService', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'application/vnd.ims.lti.v1.outcome+xml', 'POST', '2016-06-03 19:55:40'),
(113, 9, 1, 'RestService', 'tcp:ToolProxy.collection', 'http://mylocal/lti_v2/tc/tc_register.php', 'application/vnd.ims.lti.v2.toolproxy+json', 'POST', '2016-06-09 12:35:42'),
(114, 9, 1, 'RestService', 'tcp:ToolProxy.item', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}', 'application/vnd.ims.lti.v2.toolproxy+json', 'GET & PUT', '2016-06-09 12:35:42'),
(115, 9, 1, 'RestService', 'tcp:Result.item', 'http://lms.example.com/resources/Result/{sourcedId}', 'application/vnd.ims.lis.v2.result+json', 'GET & PUT', '2016-06-09 12:35:42'),
(116, 9, 1, 'RestService', 'tcp:LtiLinkSettings', 'http://lms.example.com/resources/links/{link_id}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-09 12:35:42'),
(117, 9, 1, 'RestService', 'tcp:ToolProxyBindingSettings', 'http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_cod', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-09 12:35:42'),
(118, 9, 1, 'RestService', 'tcp:ToolProxySettings', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-09 12:35:42'),
(119, 9, 1, 'RestService', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'application/vnd.ims.lti.v1.outcome+xml', 'POST', '2016-06-09 12:35:42'),
(120, 10, 1, 'RestService', 'tcp:ToolProxy.collection', 'http://mylocal/lti_v2/tc/tc_register.php', 'application/vnd.ims.lti.v2.toolproxy+json', 'POST', '2016-06-09 17:06:35'),
(121, 10, 1, 'RestService', 'tcp:ToolProxy.item', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}', 'application/vnd.ims.lti.v2.toolproxy+json', 'GET & PUT', '2016-06-09 17:06:35'),
(122, 10, 1, 'RestService', 'tcp:Result.item', 'http://lms.example.com/resources/Result/{sourcedId}', 'application/vnd.ims.lis.v2.result+json', 'GET & PUT', '2016-06-09 17:06:35'),
(123, 10, 1, 'RestService', 'tcp:LtiLinkSettings', 'http://lms.example.com/resources/links/{link_id}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-09 17:06:35'),
(124, 10, 1, 'RestService', 'tcp:ToolProxyBindingSettings', 'http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_cod', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-09 17:06:35'),
(125, 10, 1, 'RestService', 'tcp:ToolProxySettings', 'http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom', 'application/vnd.ims.lti.v2.toolsettings+json # application/vnd.ims.lti.v2.toolsettings.simple+json', 'GET & PUT', '2016-06-09 17:06:35'),
(126, 10, 1, 'RestService', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php', 'application/vnd.ims.lti.v1.outcome+xml', 'POST', '2016-06-09 17:06:35');

-- --------------------------------------------------------

--
-- Table structure for table `lti_tool_proxy_reg`
--

CREATE TABLE IF NOT EXISTS `lti_tool_proxy_reg` (
  `tool_proxy_reg_id` int(11) NOT NULL AUTO_INCREMENT,
  `lti_consumer_secret_id` int(11) NOT NULL COMMENT 'PK from  `lti_consumer_secret` ',
  `tool_proxy_reg_lti_version` varchar(50) NOT NULL,
  `tool_proxy_reg_key` varchar(100) NOT NULL COMMENT 'This is the reg key provided by the TC during registration request',
  `tool_proxy_reg_password` varchar(100) NOT NULL COMMENT 'This is the reg password provided by the TC during registration request',
  `tool_consumer_profile` text NOT NULL COMMENT 'Tool consumer profile data returned from the REST Http GET request',
  `tool_proxy_id` varchar(100) NOT NULL COMMENT 'This is the tool proxy registration id that is been generated during the registration process',
  `tool_proxy_return_url` varchar(100) NOT NULL COMMENT 'tool consumer provided return url to return after registration process is completed',
  `tool_proxy_reg_date` datetime NOT NULL,
  `tool_proxy_update_date` datetime NOT NULL,
  `tool_proxy_reg_status` enum('I','S','F') NOT NULL DEFAULT 'I' COMMENT 'Status of the overall registration process - I->initialized, S-> Success, F->Failed',
  `tool_proxy_prod_guid` varchar(100) NOT NULL COMMENT 'Stores the TC profile Product Instance GUID',
  `tool_proxy_user_guid` varchar(100) NOT NULL COMMENT 'Stores the TC profile GUID',
  `tool_proxy_error_msg` varchar(200) NOT NULL,
  PRIMARY KEY (`tool_proxy_reg_id`),
  UNIQUE KEY `tool_proxy_id` (`tool_proxy_id`),
  KEY `tool_proxy_reg_id` (`tool_proxy_reg_id`,`lti_consumer_secret_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `lti_tool_proxy_reg`
--

INSERT INTO `lti_tool_proxy_reg` (`tool_proxy_reg_id`, `lti_consumer_secret_id`, `tool_proxy_reg_lti_version`, `tool_proxy_reg_key`, `tool_proxy_reg_password`, `tool_consumer_profile`, `tool_proxy_id`, `tool_proxy_return_url`, `tool_proxy_reg_date`, `tool_proxy_update_date`, `tool_proxy_reg_status`, `tool_proxy_prod_guid`, `tool_proxy_user_guid`, `tool_proxy_error_msg`) VALUES
(3, 1, 'lti-2p0', 'sunday', 'sunday', '{\n  "@context": [\n    "http://purl.imsglobal.org/ctx/lti/v2/ToolConsumerProfile",\n    {\n      "tcp": "http://mylocal/sakai-lti-test-master/106aff6"\n    }\n  ],\n  "@type": "ToolConsumerProfile",\n  "@id": "http://mylocal/sakai-lti-test-master/106aff6",\n  "lti_version": "LTI-2p0",\n  "guid": "106aff6",\n  "product_instance": {\n    "guid": "dcddf9808107-81ea-eaa4-1edf-5d24568c",\n    "product_info": {\n      "product_name": {\n        "default_value": "Sakai LTI 2.0 Test Harness",\n        "key": "product.name"\n      },\n      "product_version": "0.1",\n      "description": {\n        "default_value": "Dr. Chuck Online",\n        "key": "product.version"\n      },\n      "technical_description": {\n        "default_value": "LTI 1, 1.1 and 2.0 compliant",\n        "key": "product.technicalDescription"\n      },\n      "product_family": {\n        "code": "SakaiTestOs",\n        "vendor": {\n          "code": "www.sakaiproject.org",\n          "vendor_name": {\n            "default_value": "Sakai",\n            "key": "product.vendor.name"\n          },\n          "description": {\n            "default_value": "Sakai is an Open Source Learning Environment",\n            "key": "product.vendor.description"\n          },\n          "website": "http://www.sakaiproject.org/",\n          "timestamp": "2012-07-09T012:08:16-04:00",\n          "contact": {\n            "email": "support@sakaiproject.org"\n          }\n        }\n      }\n    },\n    "support": {\n      "email": "drchuck@gmail.com"\n    },\n    "service_owner" : {\n      "@id" : "http://state.university.edu/",\n      "timestamp" : "2012-03-28T09:08:16-04:00",\n      "service_owner_name" : {\n        "default_value" : "State University",\n        "key" : "service_owner.name"\n      },\n      "description" : {\n        "default_value" : "A fictitious university.",\n        "key" : "service_owner.description"\n      },\n      "support" : {\n        "email" : "techsupport@university.edu"\n      }\n    },\n    "service_provider" : {\n      "@id" : "http://yasp.example.com/ServiceProvider",\n      "guid" : "yasp.example.com",\n      "timestamp" : "2012-03-28T09:08:16-04:00",\n      "service_provider_name" : {\n        "default_value" : "Your Application Service Provider",\n        "key" : "service_provider.name"\n      },\n      "description" : {\n        "default_value" : "YASP is a fictitious application service provider",\n        "key" : "service_provider.description"\n      },\n      "support" : {\n        "email" : "support@yasp.example.com"\n      }\n    }\n  },\n  "capability_offered": [\n        "User.id",\n        "User.username",\n        "CourseSection.sourcedId",\n        "Person.sourcedId",\n        "Person.name.full",\n        "Membership.role",\n       "Person.name.given" ,\n       "Person.name.family" ,\n       "Person.email.primary" ,\n       "User.image" ,\n       "Result.sourcedId" ,\n       "Result.autocreate",\n       "Result.sourcedId"\n  ],\n  "service_offered": [\n    {\n      "@type": "RestService",\n      "@id": "tcp:ToolProxy.collection",\n      "endpoint": "http://mylocal/lti_v2/tc/tc_register.php",\n      "format": ["application/vnd.ims.lti.v2.toolproxy+json"],\n      "action": [ "POST" ]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:ToolProxy.item",\n      "endpoint" : "http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}",\n      "format" : ["application/vnd.ims.lti.v2.toolproxy+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:Result.item",\n      "endpoint" : "http://lms.example.com/resources/Result/{sourcedId}",\n      "format" : ["application/vnd.ims.lis.v2.result+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:LtiLinkSettings",\n      "endpoint" : "http://lms.example.com/resources/links/{link_id}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:ToolProxyBindingSettings",\n      "endpoint" : "http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_code}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type":"RestService",\n      "@id" : "tcp:ToolProxySettings",\n      "endpoint" : "http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type": "RestService",\n      "@id": "http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php",\n      "endpoint": "http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php",\n      "format": ["application/vnd.ims.lti.v1.outcome+xml"],\n      "action": [ "POST" ]\n    }\n  ]\n}', '575179493f4f3', 'http://mylocal/lti_v2/tc/tc.php?action=finalReturnPath', '2016-06-03 18:04:15', '2016-06-03 18:04:16', 'S', 'dcddf9808107-81ea-eaa4-1edf-5d24568c', '106aff6', ''),
(4, 1, 'lti-2p0', 'sunday123', 'sunday123', '{\n  "@context": [\n    "http://purl.imsglobal.org/ctx/lti/v2/ToolConsumerProfile",\n    {\n      "tcp": "http://mylocal/sakai-lti-test-master/106aff6"\n    }\n  ],\n  "@type": "ToolConsumerProfile",\n  "@id": "http://mylocal/sakai-lti-test-master/106aff6",\n  "lti_version": "LTI-2p0",\n  "guid": "106aff6",\n  "product_instance": {\n    "guid": "dcddf9808107-81ea-eaa4-1edf-5d24568c",\n    "product_info": {\n      "product_name": {\n        "default_value": "Sakai LTI 2.0 Test Harness",\n        "key": "product.name"\n      },\n      "product_version": "0.1",\n      "description": {\n        "default_value": "Dr. Chuck Online",\n        "key": "product.version"\n      },\n      "technical_description": {\n        "default_value": "LTI 1, 1.1 and 2.0 compliant",\n        "key": "product.technicalDescription"\n      },\n      "product_family": {\n        "code": "SakaiTestOs",\n        "vendor": {\n          "code": "www.sakaiproject.org",\n          "vendor_name": {\n            "default_value": "Sakai",\n            "key": "product.vendor.name"\n          },\n          "description": {\n            "default_value": "Sakai is an Open Source Learning Environment",\n            "key": "product.vendor.description"\n          },\n          "website": "http://www.sakaiproject.org/",\n          "timestamp": "2012-07-09T012:08:16-04:00",\n          "contact": {\n            "email": "support@sakaiproject.org"\n          }\n        }\n      }\n    },\n    "support": {\n      "email": "drchuck@gmail.com"\n    },\n    "service_owner" : {\n      "@id" : "http://state.university.edu/",\n      "timestamp" : "2012-03-28T09:08:16-04:00",\n      "service_owner_name" : {\n        "default_value" : "State University",\n        "key" : "service_owner.name"\n      },\n      "description" : {\n        "default_value" : "A fictitious university.",\n        "key" : "service_owner.description"\n      },\n      "support" : {\n        "email" : "techsupport@university.edu"\n      }\n    },\n    "service_provider" : {\n      "@id" : "http://yasp.example.com/ServiceProvider",\n      "guid" : "yasp.example.com",\n      "timestamp" : "2012-03-28T09:08:16-04:00",\n      "service_provider_name" : {\n        "default_value" : "Your Application Service Provider",\n        "key" : "service_provider.name"\n      },\n      "description" : {\n        "default_value" : "YASP is a fictitious application service provider",\n        "key" : "service_provider.description"\n      },\n      "support" : {\n        "email" : "support@yasp.example.com"\n      }\n    }\n  },\n  "capability_offered": [\n        "User.id",\n        "User.username",\n        "CourseSection.sourcedId",\n        "Person.sourcedId",\n        "Person.name.full",\n        "Membership.role",\n       "Person.name.given" ,\n       "Person.name.family" ,\n       "Person.email.primary" ,\n       "User.image" ,\n       "Result.sourcedId" ,\n       "Result.autocreate",\n       "Result.sourcedId"\n  ],\n  "service_offered": [\n    {\n      "@type": "RestService",\n      "@id": "tcp:ToolProxy.collection",\n      "endpoint": "http://mylocal/lti_v2/tc/tc_register.php",\n      "format": ["application/vnd.ims.lti.v2.toolproxy+json"],\n      "action": [ "POST" ]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:ToolProxy.item",\n      "endpoint" : "http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}",\n      "format" : ["application/vnd.ims.lti.v2.toolproxy+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:Result.item",\n      "endpoint" : "http://lms.example.com/resources/Result/{sourcedId}",\n      "format" : ["application/vnd.ims.lis.v2.result+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:LtiLinkSettings",\n      "endpoint" : "http://lms.example.com/resources/links/{link_id}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:ToolProxyBindingSettings",\n      "endpoint" : "http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_code}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type":"RestService",\n      "@id" : "tcp:ToolProxySettings",\n      "endpoint" : "http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type": "RestService",\n      "@id": "http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php",\n      "endpoint": "http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php",\n      "format": ["application/vnd.ims.lti.v1.outcome+xml"],\n      "action": [ "POST" ]\n    }\n  ]\n}', '5751799a02115', 'http://mylocal/lti_v2/tc/tc.php?action=finalReturnPath', '2016-06-03 18:05:36', '2016-06-03 18:05:37', 'S', 'dcddf9808107-81ea-eaa4-1edf-5d24568c', '106aff6', ''),
(5, 1, 'lti-2p0', 'monday', 'monday', '{\n  "@context": [\n    "http://purl.imsglobal.org/ctx/lti/v2/ToolConsumerProfile",\n    {\n      "tcp": "http://mylocal/sakai-lti-test-master/106aff6"\n    }\n  ],\n  "@type": "ToolConsumerProfile",\n  "@id": "http://mylocal/sakai-lti-test-master/106aff6",\n  "lti_version": "LTI-2p0",\n  "guid": "106aff6",\n  "product_instance": {\n    "guid": "dcddf9808107-81ea-eaa4-1edf-5d24568c",\n    "product_info": {\n      "product_name": {\n        "default_value": "Sakai LTI 2.0 Test Harness",\n        "key": "product.name"\n      },\n      "product_version": "0.1",\n      "description": {\n        "default_value": "Dr. Chuck Online",\n        "key": "product.version"\n      },\n      "technical_description": {\n        "default_value": "LTI 1, 1.1 and 2.0 compliant",\n        "key": "product.technicalDescription"\n      },\n      "product_family": {\n        "code": "SakaiTestOs",\n        "vendor": {\n          "code": "www.sakaiproject.org",\n          "vendor_name": {\n            "default_value": "Sakai",\n            "key": "product.vendor.name"\n          },\n          "description": {\n            "default_value": "Sakai is an Open Source Learning Environment",\n            "key": "product.vendor.description"\n          },\n          "website": "http://www.sakaiproject.org/",\n          "timestamp": "2012-07-09T012:08:16-04:00",\n          "contact": {\n            "email": "support@sakaiproject.org"\n          }\n        }\n      }\n    },\n    "support": {\n      "email": "drchuck@gmail.com"\n    },\n    "service_owner" : {\n      "@id" : "http://state.university.edu/",\n      "timestamp" : "2012-03-28T09:08:16-04:00",\n      "service_owner_name" : {\n        "default_value" : "State University",\n        "key" : "service_owner.name"\n      },\n      "description" : {\n        "default_value" : "A fictitious university.",\n        "key" : "service_owner.description"\n      },\n      "support" : {\n        "email" : "techsupport@university.edu"\n      }\n    },\n    "service_provider" : {\n      "@id" : "http://yasp.example.com/ServiceProvider",\n      "guid" : "yasp.example.com",\n      "timestamp" : "2012-03-28T09:08:16-04:00",\n      "service_provider_name" : {\n        "default_value" : "Your Application Service Provider",\n        "key" : "service_provider.name"\n      },\n      "description" : {\n        "default_value" : "YASP is a fictitious application service provider",\n        "key" : "service_provider.description"\n      },\n      "support" : {\n        "email" : "support@yasp.example.com"\n      }\n    }\n  },\n  "capability_offered": [\n        "User.id",\n        "User.username",\n        "CourseSection.sourcedId",\n        "Person.sourcedId",\n        "Person.name.full",\n        "Membership.role",\n       "Person.name.given" ,\n       "Person.name.family" ,\n       "Person.email.primary" ,\n       "User.image" ,\n       "Result.sourcedId" ,\n       "Result.autocreate",\n       "Result.sourcedId"\n  ],\n  "service_offered": [\n    {\n      "@type": "RestService",\n      "@id": "tcp:ToolProxy.collection",\n      "endpoint": "http://mylocal/lti_v2/tc/tc_register.php",\n      "format": ["application/vnd.ims.lti.v2.toolproxy+json"],\n      "action": [ "POST" ]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:ToolProxy.item",\n      "endpoint" : "http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}",\n      "format" : ["application/vnd.ims.lti.v2.toolproxy+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:Result.item",\n      "endpoint" : "http://lms.example.com/resources/Result/{sourcedId}",\n      "format" : ["application/vnd.ims.lis.v2.result+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:LtiLinkSettings",\n      "endpoint" : "http://lms.example.com/resources/links/{link_id}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:ToolProxyBindingSettings",\n      "endpoint" : "http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_code}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type":"RestService",\n      "@id" : "tcp:ToolProxySettings",\n      "endpoint" : "http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type": "RestService",\n      "@id": "http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php",\n      "endpoint": "http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php",\n      "format": ["application/vnd.ims.lti.v1.outcome+xml"],\n      "action": [ "POST" ]\n    }\n  ]\n}', '575181f206537', 'http://mylocal/lti_v2/tc/tc.php?action=finalReturnPath', '2016-06-03 18:41:12', '2016-06-03 18:41:12', 'S', 'dcddf9808107-81ea-eaa4-1edf-5d24568c', '106aff6', ''),
(6, 1, 'lti-2p0', 'monday123', 'monday123', '{\n  "@context": [\n    "http://purl.imsglobal.org/ctx/lti/v2/ToolConsumerProfile",\n    {\n      "tcp": "http://mylocal/sakai-lti-test-master/106aff6"\n    }\n  ],\n  "@type": "ToolConsumerProfile",\n  "@id": "http://mylocal/sakai-lti-test-master/106aff6",\n  "lti_version": "LTI-2p0",\n  "guid": "106aff6",\n  "product_instance": {\n    "guid": "dcddf9808107-81ea-eaa4-1edf-5d24568c",\n    "product_info": {\n      "product_name": {\n        "default_value": "Sakai LTI 2.0 Test Harness",\n        "key": "product.name"\n      },\n      "product_version": "0.1",\n      "description": {\n        "default_value": "Dr. Chuck Online",\n        "key": "product.version"\n      },\n      "technical_description": {\n        "default_value": "LTI 1, 1.1 and 2.0 compliant",\n        "key": "product.technicalDescription"\n      },\n      "product_family": {\n        "code": "SakaiTestOs",\n        "vendor": {\n          "code": "www.sakaiproject.org",\n          "vendor_name": {\n            "default_value": "Sakai",\n            "key": "product.vendor.name"\n          },\n          "description": {\n            "default_value": "Sakai is an Open Source Learning Environment",\n            "key": "product.vendor.description"\n          },\n          "website": "http://www.sakaiproject.org/",\n          "timestamp": "2012-07-09T012:08:16-04:00",\n          "contact": {\n            "email": "support@sakaiproject.org"\n          }\n        }\n      }\n    },\n    "support": {\n      "email": "drchuck@gmail.com"\n    },\n    "service_owner" : {\n      "@id" : "http://state.university.edu/",\n      "timestamp" : "2012-03-28T09:08:16-04:00",\n      "service_owner_name" : {\n        "default_value" : "State University",\n        "key" : "service_owner.name"\n      },\n      "description" : {\n        "default_value" : "A fictitious university.",\n        "key" : "service_owner.description"\n      },\n      "support" : {\n        "email" : "techsupport@university.edu"\n      }\n    },\n    "service_provider" : {\n      "@id" : "http://yasp.example.com/ServiceProvider",\n      "guid" : "yasp.example.com",\n      "timestamp" : "2012-03-28T09:08:16-04:00",\n      "service_provider_name" : {\n        "default_value" : "Your Application Service Provider",\n        "key" : "service_provider.name"\n      },\n      "description" : {\n        "default_value" : "YASP is a fictitious application service provider",\n        "key" : "service_provider.description"\n      },\n      "support" : {\n        "email" : "support@yasp.example.com"\n      }\n    }\n  },\n  "capability_offered": [\n        "User.id",\n        "User.username",\n        "CourseSection.sourcedId",\n        "Person.sourcedId",\n        "Person.name.full",\n        "Membership.role",\n       "Person.name.given" ,\n       "Person.name.family" ,\n       "Person.email.primary" ,\n       "User.image" ,\n       "Result.sourcedId" ,\n       "Result.autocreate",\n       "Result.sourcedId"\n  ],\n  "service_offered": [\n    {\n      "@type": "RestService",\n      "@id": "tcp:ToolProxy.collection",\n      "endpoint": "http://mylocal/lti_v2/tc/tc_register.php",\n      "format": ["application/vnd.ims.lti.v2.toolproxy+json"],\n      "action": [ "POST" ]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:ToolProxy.item",\n      "endpoint" : "http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}",\n      "format" : ["application/vnd.ims.lti.v2.toolproxy+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:Result.item",\n      "endpoint" : "http://lms.example.com/resources/Result/{sourcedId}",\n      "format" : ["application/vnd.ims.lis.v2.result+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:LtiLinkSettings",\n      "endpoint" : "http://lms.example.com/resources/links/{link_id}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:ToolProxyBindingSettings",\n      "endpoint" : "http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_code}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type":"RestService",\n      "@id" : "tcp:ToolProxySettings",\n      "endpoint" : "http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type": "RestService",\n      "@id": "http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php",\n      "endpoint": "http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php",\n      "format": ["application/vnd.ims.lti.v1.outcome+xml"],\n      "action": [ "POST" ]\n    }\n  ]\n}', '57518f223eea9', 'http://mylocal/lti_v2/tc/tc.php?action=finalReturnPath', '2016-06-03 19:37:29', '2016-06-03 19:37:29', 'S', 'dcddf9808107-81ea-eaa4-1edf-5d24568c', '106aff6', ''),
(7, 1, 'lti-2p0', 'monday1234', 'monday1234', '{\n  "@context": [\n    "http://purl.imsglobal.org/ctx/lti/v2/ToolConsumerProfile",\n    {\n      "tcp": "http://mylocal/sakai-lti-test-master/106aff6"\n    }\n  ],\n  "@type": "ToolConsumerProfile",\n  "@id": "http://mylocal/sakai-lti-test-master/106aff6",\n  "lti_version": "LTI-2p0",\n  "guid": "106aff6",\n  "product_instance": {\n    "guid": "dcddf9808107-81ea-eaa4-1edf-5d24568c",\n    "product_info": {\n      "product_name": {\n        "default_value": "Sakai LTI 2.0 Test Harness",\n        "key": "product.name"\n      },\n      "product_version": "0.1",\n      "description": {\n        "default_value": "Dr. Chuck Online",\n        "key": "product.version"\n      },\n      "technical_description": {\n        "default_value": "LTI 1, 1.1 and 2.0 compliant",\n        "key": "product.technicalDescription"\n      },\n      "product_family": {\n        "code": "SakaiTestOs",\n        "vendor": {\n          "code": "www.sakaiproject.org",\n          "vendor_name": {\n            "default_value": "Sakai",\n            "key": "product.vendor.name"\n          },\n          "description": {\n            "default_value": "Sakai is an Open Source Learning Environment",\n            "key": "product.vendor.description"\n          },\n          "website": "http://www.sakaiproject.org/",\n          "timestamp": "2012-07-09T012:08:16-04:00",\n          "contact": {\n            "email": "support@sakaiproject.org"\n          }\n        }\n      }\n    },\n    "support": {\n      "email": "drchuck@gmail.com"\n    },\n    "service_owner" : {\n      "@id" : "http://state.university.edu/",\n      "timestamp" : "2012-03-28T09:08:16-04:00",\n      "service_owner_name" : {\n        "default_value" : "State University",\n        "key" : "service_owner.name"\n      },\n      "description" : {\n        "default_value" : "A fictitious university.",\n        "key" : "service_owner.description"\n      },\n      "support" : {\n        "email" : "techsupport@university.edu"\n      }\n    },\n    "service_provider" : {\n      "@id" : "http://yasp.example.com/ServiceProvider",\n      "guid" : "yasp.example.com",\n      "timestamp" : "2012-03-28T09:08:16-04:00",\n      "service_provider_name" : {\n        "default_value" : "Your Application Service Provider",\n        "key" : "service_provider.name"\n      },\n      "description" : {\n        "default_value" : "YASP is a fictitious application service provider",\n        "key" : "service_provider.description"\n      },\n      "support" : {\n        "email" : "support@yasp.example.com"\n      }\n    }\n  },\n  "capability_offered": [\n        "User.id",\n        "User.username",\n        "CourseSection.sourcedId",\n        "Person.sourcedId",\n        "Person.name.full",\n        "Membership.role",\n       "Person.name.given" ,\n       "Person.name.family" ,\n       "Person.email.primary" ,\n       "User.image" ,\n       "Result.sourcedId" ,\n       "Result.autocreate",\n       "Result.sourcedId"\n  ],\n  "service_offered": [\n    {\n      "@type": "RestService",\n      "@id": "tcp:ToolProxy.collection",\n      "endpoint": "http://mylocal/lti_v2/tc/tc_register.php",\n      "format": ["application/vnd.ims.lti.v2.toolproxy+json"],\n      "action": [ "POST" ]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:ToolProxy.item",\n      "endpoint" : "http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}",\n      "format" : ["application/vnd.ims.lti.v2.toolproxy+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:Result.item",\n      "endpoint" : "http://lms.example.com/resources/Result/{sourcedId}",\n      "format" : ["application/vnd.ims.lis.v2.result+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:LtiLinkSettings",\n      "endpoint" : "http://lms.example.com/resources/links/{link_id}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:ToolProxyBindingSettings",\n      "endpoint" : "http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_code}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type":"RestService",\n      "@id" : "tcp:ToolProxySettings",\n      "endpoint" : "http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type": "RestService",\n      "@id": "http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php",\n      "endpoint": "http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php",\n      "format": ["application/vnd.ims.lti.v1.outcome+xml"],\n      "action": [ "POST" ]\n    }\n  ]\n}', '575192e50649d', 'http://mylocal/lti_v2/tc/tc.php?action=finalReturnPath', '2016-06-03 19:53:31', '2016-06-03 19:53:32', 'S', 'dcddf9808107-81ea-eaa4-1edf-5d24568c', '106aff6', ''),
(8, 1, 'lti-2p0', 'monday12346', 'monday12346', '{\n  "@context": [\n    "http://purl.imsglobal.org/ctx/lti/v2/ToolConsumerProfile",\n    {\n      "tcp": "http://mylocal/sakai-lti-test-master/106aff6"\n    }\n  ],\n  "@type": "ToolConsumerProfile",\n  "@id": "http://mylocal/sakai-lti-test-master/106aff6",\n  "lti_version": "LTI-2p0",\n  "guid": "106aff6",\n  "product_instance": {\n    "guid": "dcddf9808107-81ea-eaa4-1edf-5d24568c",\n    "product_info": {\n      "product_name": {\n        "default_value": "Sakai LTI 2.0 Test Harness",\n        "key": "product.name"\n      },\n      "product_version": "0.1",\n      "description": {\n        "default_value": "Dr. Chuck Online",\n        "key": "product.version"\n      },\n      "technical_description": {\n        "default_value": "LTI 1, 1.1 and 2.0 compliant",\n        "key": "product.technicalDescription"\n      },\n      "product_family": {\n        "code": "SakaiTestOs",\n        "vendor": {\n          "code": "www.sakaiproject.org",\n          "vendor_name": {\n            "default_value": "Sakai",\n            "key": "product.vendor.name"\n          },\n          "description": {\n            "default_value": "Sakai is an Open Source Learning Environment",\n            "key": "product.vendor.description"\n          },\n          "website": "http://www.sakaiproject.org/",\n          "timestamp": "2012-07-09T012:08:16-04:00",\n          "contact": {\n            "email": "support@sakaiproject.org"\n          }\n        }\n      }\n    },\n    "support": {\n      "email": "drchuck@gmail.com"\n    },\n    "service_owner" : {\n      "@id" : "http://state.university.edu/",\n      "timestamp" : "2012-03-28T09:08:16-04:00",\n      "service_owner_name" : {\n        "default_value" : "State University",\n        "key" : "service_owner.name"\n      },\n      "description" : {\n        "default_value" : "A fictitious university.",\n        "key" : "service_owner.description"\n      },\n      "support" : {\n        "email" : "techsupport@university.edu"\n      }\n    },\n    "service_provider" : {\n      "@id" : "http://yasp.example.com/ServiceProvider",\n      "guid" : "yasp.example.com",\n      "timestamp" : "2012-03-28T09:08:16-04:00",\n      "service_provider_name" : {\n        "default_value" : "Your Application Service Provider",\n        "key" : "service_provider.name"\n      },\n      "description" : {\n        "default_value" : "YASP is a fictitious application service provider",\n        "key" : "service_provider.description"\n      },\n      "support" : {\n        "email" : "support@yasp.example.com"\n      }\n    }\n  },\n  "capability_offered": [\n        "User.id",\n        "User.username",\n        "CourseSection.sourcedId",\n        "Person.sourcedId",\n        "Person.name.full",\n        "Membership.role",\n       "Person.name.given" ,\n       "Person.name.family" ,\n       "Person.email.primary" ,\n       "User.image" ,\n       "Result.sourcedId" ,\n       "Result.autocreate",\n       "Result.sourcedId"\n  ],\n  "service_offered": [\n    {\n      "@type": "RestService",\n      "@id": "tcp:ToolProxy.collection",\n      "endpoint": "http://mylocal/lti_v2/tc/tc_register.php",\n      "format": ["application/vnd.ims.lti.v2.toolproxy+json"],\n      "action": [ "POST" ]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:ToolProxy.item",\n      "endpoint" : "http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}",\n      "format" : ["application/vnd.ims.lti.v2.toolproxy+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:Result.item",\n      "endpoint" : "http://lms.example.com/resources/Result/{sourcedId}",\n      "format" : ["application/vnd.ims.lis.v2.result+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:LtiLinkSettings",\n      "endpoint" : "http://lms.example.com/resources/links/{link_id}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:ToolProxyBindingSettings",\n      "endpoint" : "http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_code}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type":"RestService",\n      "@id" : "tcp:ToolProxySettings",\n      "endpoint" : "http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type": "RestService",\n      "@id": "http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php",\n      "endpoint": "http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php",\n      "format": ["application/vnd.ims.lti.v1.outcome+xml"],\n      "action": [ "POST" ]\n    }\n  ]\n}', '57519364504c4', 'http://mylocal/lti_v2/tc/tc.php?action=finalReturnPath', '2016-06-03 19:55:39', '2016-06-03 19:55:39', 'S', 'dcddf9808107-81ea-eaa4-1edf-5d24568c', '106aff6', ''),
(9, 1, 'lti-2p0', 'thrusday', 'thrusday', '{\n  "@context": [\n    "http://purl.imsglobal.org/ctx/lti/v2/ToolConsumerProfile",\n    {\n      "tcp": "http://mylocal/sakai-lti-test-master/106aff6"\n    }\n  ],\n  "@type": "ToolConsumerProfile",\n  "@id": "http://mylocal/sakai-lti-test-master/106aff6",\n  "lti_version": "LTI-2p0",\n  "guid": "106aff6",\n  "product_instance": {\n    "guid": "dcddf9808107-81ea-eaa4-1edf-5d24568c",\n    "product_info": {\n      "product_name": {\n        "default_value": "Sakai LTI 2.0 Test Harness",\n        "key": "product.name"\n      },\n      "product_version": "0.1",\n      "description": {\n        "default_value": "Dr. Chuck Online",\n        "key": "product.version"\n      },\n      "technical_description": {\n        "default_value": "LTI 1, 1.1 and 2.0 compliant",\n        "key": "product.technicalDescription"\n      },\n      "product_family": {\n        "code": "SakaiTestOs",\n        "vendor": {\n          "code": "www.sakaiproject.org",\n          "vendor_name": {\n            "default_value": "Sakai",\n            "key": "product.vendor.name"\n          },\n          "description": {\n            "default_value": "Sakai is an Open Source Learning Environment",\n            "key": "product.vendor.description"\n          },\n          "website": "http://www.sakaiproject.org/",\n          "timestamp": "2012-07-09T012:08:16-04:00",\n          "contact": {\n            "email": "support@sakaiproject.org"\n          }\n        }\n      }\n    },\n    "support": {\n      "email": "drchuck@gmail.com"\n    },\n    "service_owner" : {\n      "@id" : "http://state.university.edu/",\n      "timestamp" : "2012-03-28T09:08:16-04:00",\n      "service_owner_name" : {\n        "default_value" : "State University",\n        "key" : "service_owner.name"\n      },\n      "description" : {\n        "default_value" : "A fictitious university.",\n        "key" : "service_owner.description"\n      },\n      "support" : {\n        "email" : "techsupport@university.edu"\n      }\n    },\n    "service_provider" : {\n      "@id" : "http://yasp.example.com/ServiceProvider",\n      "guid" : "yasp.example.com",\n      "timestamp" : "2012-03-28T09:08:16-04:00",\n      "service_provider_name" : {\n        "default_value" : "Your Application Service Provider",\n        "key" : "service_provider.name"\n      },\n      "description" : {\n        "default_value" : "YASP is a fictitious application service provider",\n        "key" : "service_provider.description"\n      },\n      "support" : {\n        "email" : "support@yasp.example.com"\n      }\n    }\n  },\n  "capability_offered": [\n        "User.id",\n        "User.username",\n        "CourseSection.sourcedId",\n        "Person.sourcedId",\n        "Person.name.full",\n        "Membership.role",\n       "Person.name.given" ,\n       "Person.name.family" ,\n       "Person.email.primary" ,\n       "User.image" ,\n       "Result.sourcedId" ,\n       "Result.autocreate",\n       "Result.sourcedId"\n  ],\n  "service_offered": [\n    {\n      "@type": "RestService",\n      "@id": "tcp:ToolProxy.collection",\n      "endpoint": "http://mylocal/lti_v2/tc/tc_register.php",\n      "format": ["application/vnd.ims.lti.v2.toolproxy+json"],\n      "action": [ "POST" ]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:ToolProxy.item",\n      "endpoint" : "http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}",\n      "format" : ["application/vnd.ims.lti.v2.toolproxy+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:Result.item",\n      "endpoint" : "http://lms.example.com/resources/Result/{sourcedId}",\n      "format" : ["application/vnd.ims.lis.v2.result+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:LtiLinkSettings",\n      "endpoint" : "http://lms.example.com/resources/links/{link_id}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:ToolProxyBindingSettings",\n      "endpoint" : "http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_code}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type":"RestService",\n      "@id" : "tcp:ToolProxySettings",\n      "endpoint" : "http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type": "RestService",\n      "@id": "http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php",\n      "endpoint": "http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php",\n      "format": ["application/vnd.ims.lti.v1.outcome+xml"],\n      "action": [ "POST" ]\n    }\n  ]\n}', '575915468696d', 'http://mylocal/lti_v2/tc/tc.php?action=finalReturnPath', '2016-06-09 12:35:41', '2016-06-09 12:35:41', 'S', 'dcddf9808107-81ea-eaa4-1edf-5d24568c', '106aff6', ''),
(10, 1, 'lti-2p0', 'thrusday', 'thrusday', '{\n  "@context": [\n    "http://purl.imsglobal.org/ctx/lti/v2/ToolConsumerProfile",\n    {\n      "tcp": "http://mylocal/sakai-lti-test-master/106aff6"\n    }\n  ],\n  "@type": "ToolConsumerProfile",\n  "@id": "http://mylocal/sakai-lti-test-master/106aff6",\n  "lti_version": "LTI-2p0",\n  "guid": "106aff6",\n  "product_instance": {\n    "guid": "dcddf9808107-81ea-eaa4-1edf-5d24568c",\n    "product_info": {\n      "product_name": {\n        "default_value": "Sakai LTI 2.0 Test Harness",\n        "key": "product.name"\n      },\n      "product_version": "0.1",\n      "description": {\n        "default_value": "Dr. Chuck Online",\n        "key": "product.version"\n      },\n      "technical_description": {\n        "default_value": "LTI 1, 1.1 and 2.0 compliant",\n        "key": "product.technicalDescription"\n      },\n      "product_family": {\n        "code": "SakaiTestOs",\n        "vendor": {\n          "code": "www.sakaiproject.org",\n          "vendor_name": {\n            "default_value": "Sakai",\n            "key": "product.vendor.name"\n          },\n          "description": {\n            "default_value": "Sakai is an Open Source Learning Environment",\n            "key": "product.vendor.description"\n          },\n          "website": "http://www.sakaiproject.org/",\n          "timestamp": "2012-07-09T012:08:16-04:00",\n          "contact": {\n            "email": "support@sakaiproject.org"\n          }\n        }\n      }\n    },\n    "support": {\n      "email": "drchuck@gmail.com"\n    },\n    "service_owner" : {\n      "@id" : "http://state.university.edu/",\n      "timestamp" : "2012-03-28T09:08:16-04:00",\n      "service_owner_name" : {\n        "default_value" : "State University",\n        "key" : "service_owner.name"\n      },\n      "description" : {\n        "default_value" : "A fictitious university.",\n        "key" : "service_owner.description"\n      },\n      "support" : {\n        "email" : "techsupport@university.edu"\n      }\n    },\n    "service_provider" : {\n      "@id" : "http://yasp.example.com/ServiceProvider",\n      "guid" : "yasp.example.com",\n      "timestamp" : "2012-03-28T09:08:16-04:00",\n      "service_provider_name" : {\n        "default_value" : "Your Application Service Provider",\n        "key" : "service_provider.name"\n      },\n      "description" : {\n        "default_value" : "YASP is a fictitious application service provider",\n        "key" : "service_provider.description"\n      },\n      "support" : {\n        "email" : "support@yasp.example.com"\n      }\n    }\n  },\n  "capability_offered": [\n        "User.id",\n        "User.username",\n        "CourseSection.sourcedId",\n        "Person.sourcedId",\n        "Person.name.full",\n        "Membership.role",\n       "Person.name.given" ,\n       "Person.name.family" ,\n       "Person.email.primary" ,\n       "User.image" ,\n       "Result.sourcedId" ,\n       "Result.autocreate",\n       "Result.sourcedId"\n  ],\n  "service_offered": [\n    {\n      "@type": "RestService",\n      "@id": "tcp:ToolProxy.collection",\n      "endpoint": "http://mylocal/lti_v2/tc/tc_register.php",\n      "format": ["application/vnd.ims.lti.v2.toolproxy+json"],\n      "action": [ "POST" ]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:ToolProxy.item",\n      "endpoint" : "http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}",\n      "format" : ["application/vnd.ims.lti.v2.toolproxy+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:Result.item",\n      "endpoint" : "http://lms.example.com/resources/Result/{sourcedId}",\n      "format" : ["application/vnd.ims.lis.v2.result+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:LtiLinkSettings",\n      "endpoint" : "http://lms.example.com/resources/links/{link_id}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:ToolProxyBindingSettings",\n      "endpoint" : "http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_code}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type":"RestService",\n      "@id" : "tcp:ToolProxySettings",\n      "endpoint" : "http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type": "RestService",\n      "@id": "http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php",\n      "endpoint": "http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php",\n      "format": ["application/vnd.ims.lti.v1.outcome+xml"],\n      "action": [ "POST" ]\n    }\n  ]\n}', '575954c366b53', 'http://mylocal/lti_v2/tc/tc.php?action=finalReturnPath', '2016-06-09 17:06:34', '2016-06-09 17:06:34', 'S', 'dcddf9808107-81ea-eaa4-1edf-5d24568c', '106aff6', '');

-- --------------------------------------------------------

--
-- Table structure for table `lti_user_roles`
--

CREATE TABLE IF NOT EXISTS `lti_user_roles` (
  `lti_user_role_id` int(11) NOT NULL AUTO_INCREMENT,
  `lti_user_role_name` varchar(50) NOT NULL,
  `lti_user_role_urn_name` varchar(100) NOT NULL,
  `lti_user_role_status` enum('1','2') NOT NULL DEFAULT '1' COMMENT '1-> Active, 2->Inactive',
  PRIMARY KEY (`lti_user_role_id`),
  KEY `lti_user_role_id` (`lti_user_role_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `lti_user_roles`
--

INSERT INTO `lti_user_roles` (`lti_user_role_id`, `lti_user_role_name`, `lti_user_role_urn_name`, `lti_user_role_status`) VALUES
(1, 'administrator', 'http://purl.imsglobal.org/vocab/lis/v2/person#Administrator', '1'),
(2, 'instructor', 'http://purl.imsglobal.org/vocab/lis/v2/person#Instructor', '1'),
(3, 'learner', 'http://purl.imsglobal.org/vocab/lis/v2/person#Learner', '1'),
(4, 'student', 'http://purl.imsglobal.org/vocab/lis/v2/person#Student', '1'),
(5, 'faculty', 'http://purl.imsglobal.org/vocab/lis/v2/person#Faculty', '1'),
(6, 'member', 'http://purl.imsglobal.org/vocab/lis/v2/person#Member', '1'),
(7, 'mentor', 'http://purl.imsglobal.org/vocab/lis/v2/person#Mentor', '1'),
(8, 'staff', 'http://purl.imsglobal.org/vocab/lis/v2/person#Staff', '1'),
(9, 'alumni', 'http://purl.imsglobal.org/vocab/lis/v2/person#Alumni', '1'),
(10, 'prospectivestudent', 'http://purl.imsglobal.org/vocab/lis/v2/person#ProspectiveStudent', '1'),
(11, 'guest', 'http://purl.imsglobal.org/vocab/lis/v2/person#Guest', '1'),
(12, 'other', 'http://purl.imsglobal.org/vocab/lis/v2/person#Other', '1'),
(13, 'observer', 'http://purl.imsglobal.org/vocab/lis/v2/person#Observer', '1');

-- --------------------------------------------------------

--
-- Table structure for table `not_used_lti_consumer`
--

CREATE TABLE IF NOT EXISTS `not_used_lti_consumer` (
  `consumer_key` varchar(255) NOT NULL,
  `name` varchar(45) NOT NULL,
  `secret` varchar(32) NOT NULL,
  `lti_version` varchar(12) DEFAULT NULL,
  `consumer_name` varchar(255) DEFAULT NULL,
  `consumer_version` varchar(255) DEFAULT NULL,
  `consumer_guid` varchar(255) DEFAULT NULL,
  `css_path` varchar(255) DEFAULT NULL,
  `protected` tinyint(1) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `enable_from` datetime DEFAULT NULL,
  `enable_until` datetime DEFAULT NULL,
  `last_access` date DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`consumer_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `not_used_lti_context`
--

CREATE TABLE IF NOT EXISTS `not_used_lti_context` (
  `consumer_key` varchar(255) NOT NULL,
  `context_id` varchar(255) NOT NULL,
  `lti_context_id` varchar(255) DEFAULT NULL,
  `lti_resource_id` varchar(255) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `settings` text,
  `primary_consumer_key` varchar(255) DEFAULT NULL,
  `primary_context_id` varchar(255) DEFAULT NULL,
  `share_approved` tinyint(1) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`consumer_key`,`context_id`),
  KEY `lti_context_context_FK1` (`primary_consumer_key`,`primary_context_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `not_used_lti_nonce`
--

CREATE TABLE IF NOT EXISTS `not_used_lti_nonce` (
  `consumer_key` varchar(255) NOT NULL,
  `value` varchar(32) NOT NULL,
  `expires` datetime NOT NULL,
  PRIMARY KEY (`consumer_key`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `not_used_lti_share_key`
--

CREATE TABLE IF NOT EXISTS `not_used_lti_share_key` (
  `share_key_id` varchar(32) NOT NULL,
  `primary_consumer_key` varchar(255) NOT NULL,
  `primary_context_id` varchar(255) NOT NULL,
  `auto_approve` tinyint(1) NOT NULL,
  `expires` datetime NOT NULL,
  PRIMARY KEY (`share_key_id`),
  KEY `lti_share_key_context_FK1` (`primary_consumer_key`,`primary_context_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `not_used_lti_user`
--

CREATE TABLE IF NOT EXISTS `not_used_lti_user` (
  `consumer_key` varchar(255) NOT NULL,
  `context_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `lti_result_sourcedid` varchar(255) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`consumer_key`,`context_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `not_used_tp_users`
--

CREATE TABLE IF NOT EXISTS `not_used_tp_users` (
  `tp_users_id` int(11) NOT NULL AUTO_INCREMENT,
  `consumer_user_id` varchar(100) NOT NULL,
  `tc_reg_key` varchar(100) NOT NULL,
  `tc_reg_password` varchar(100) NOT NULL,
  `tc_insert_dts` datetime NOT NULL,
  PRIMARY KEY (`tp_users_id`),
  KEY `tc_user_id` (`consumer_user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `not_used_tp_users`
--

INSERT INTO `not_used_tp_users` (`tp_users_id`, `consumer_user_id`, `tc_reg_key`, `tc_reg_password`, `tc_insert_dts`) VALUES
(1, 'tc.php?action=profile&userid=12321', '69e5ce5-214c-4e85-86c6-b99e8458a592', 'e9fd6071-0641-4101-b814-9a088c445292', '0000-00-00 00:00:00');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `not_used_lti_context`
--
ALTER TABLE `not_used_lti_context`
  ADD CONSTRAINT `lti_context_consumer_FK1` FOREIGN KEY (`consumer_key`) REFERENCES `not_used_lti_consumer` (`consumer_key`),
  ADD CONSTRAINT `lti_context_context_FK1` FOREIGN KEY (`primary_consumer_key`, `primary_context_id`) REFERENCES `not_used_lti_context` (`consumer_key`, `context_id`);

--
-- Constraints for table `not_used_lti_nonce`
--
ALTER TABLE `not_used_lti_nonce`
  ADD CONSTRAINT `lti_nonce_consumer_FK1` FOREIGN KEY (`consumer_key`) REFERENCES `not_used_lti_consumer` (`consumer_key`);

--
-- Constraints for table `not_used_lti_share_key`
--
ALTER TABLE `not_used_lti_share_key`
  ADD CONSTRAINT `lti_share_key_context_FK1` FOREIGN KEY (`primary_consumer_key`, `primary_context_id`) REFERENCES `not_used_lti_context` (`consumer_key`, `context_id`);

--
-- Constraints for table `not_used_lti_user`
--
ALTER TABLE `not_used_lti_user`
  ADD CONSTRAINT `lti_user_context_FK1` FOREIGN KEY (`consumer_key`, `context_id`) REFERENCES `not_used_lti_context` (`consumer_key`, `context_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
