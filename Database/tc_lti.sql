-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 09, 2016 at 08:34 PM
-- Server version: 5.5.49-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tc_lti`
--

-- --------------------------------------------------------

--
-- Table structure for table `tc_proxy_credentials`
--

CREATE TABLE IF NOT EXISTS `tc_proxy_credentials` (
  `tc_proxy_cred_id` int(11) NOT NULL AUTO_INCREMENT,
  `tc_proxy_reg_key` varchar(100) NOT NULL,
  `tc_proxy_reg_password` varchar(100) NOT NULL,
  `tc_oauth_signature` varchar(100) NOT NULL,
  `tc_oauth_consumer_key` varchar(100) NOT NULL,
  `tool_proxy_guid` varchar(100) NOT NULL,
  PRIMARY KEY (`tc_proxy_cred_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=60 ;

--
-- Dumping data for table `tc_proxy_credentials`
--

INSERT INTO `tc_proxy_credentials` (`tc_proxy_cred_id`, `tc_proxy_reg_key`, `tc_proxy_reg_password`, `tc_oauth_signature`, `tc_oauth_consumer_key`, `tool_proxy_guid`) VALUES
(1, 'registrationKey', 'registrationPassword', '', '', '574ef657a561f'),
(2, 'registrationKey', 'registrationPassword', '', '', '574ef657a561f'),
(3, 'registrationKey', 'registrationPassword', '', '', '574ef657a561f'),
(4, 'registrationKey', 'registrationPassword', '', '', '574ef657a561f'),
(5, 'registrationKey', 'registrationPassword', '', '', '574ef657a561f'),
(6, 'registrationKey', 'registrationPassword', '', '', '574ef657a561f'),
(7, 'registrationKey', 'registrationPassword', '', '', '574ef657a561f'),
(8, 'registrationKey', 'registrationPassword', '', '', '574ef657a561f'),
(9, 'registrationKey', 'registrationPassword', '', '', '574ef657a561f'),
(10, 'registrationKey', 'registrationPassword', '', '', '574ef657a561f'),
(11, 'registrationKey', 'registrationPassword', '', '', '574ef657a561f'),
(12, 'registrationKey', 'registrationPassword', '', '', '574ef657a561f'),
(13, 'registrationKey', 'registrationPassword', '', '', '574ef657a561f'),
(14, 'registrationKey', 'registrationPassword', '', '', '574ef657a561f'),
(15, 'registrationKey', 'registrationPassword', '', '', '574ef657a561f'),
(16, 'registrationKey', 'registrationPassword', '', '', '574ef657a561f'),
(17, 'registrationKey', 'registrationPassword', '', '', '574ef657a561f'),
(18, 'registrationKey', 'registrationPassword', '', '', '574ef657a561f'),
(19, 'friday', 'friday', '', '', '57511ce55ac69'),
(20, 'saturday', 'saturday', '', '', ''),
(21, 'saturday', 'saturday', '', '', ''),
(22, 'saturday', 'saturday', '', '', ''),
(23, 'sunday', 'sunday', '', '', '575179493f4f3'),
(24, 'sunday', 'sunday', '', '', '575179493f4f3'),
(25, 'sunday', 'sunday', '', '', '575179493f4f3'),
(26, 'sunday', 'sunday', '', '', '575179493f4f3'),
(27, 'sunday', 'sunday', '', '', '575179493f4f3'),
(28, 'sunday', 'sunday', '', '', '575179493f4f3'),
(29, 'sunday', 'sunday', '', '', '575179493f4f3'),
(30, 'sunday', 'sunday', '', '', '575179493f4f3'),
(31, 'sunday', 'sunday', '', '', '575179493f4f3'),
(32, 'sunday', 'sunday', '', '', '575179493f4f3'),
(33, 'sunday', 'sunday', '', '', '575179493f4f3'),
(34, 'sunday', 'sunday', '', '', '575179493f4f3'),
(35, 'sunday', 'sunday', '', '', '575179493f4f3'),
(36, 'sunday', 'sunday', '', '', '575179493f4f3'),
(37, 'sunday', 'sunday', '', '', '575179493f4f3'),
(38, 'sunday', 'sunday', '', '', '575179493f4f3'),
(39, 'sunday', 'sunday', '', '', '575179493f4f3'),
(40, 'sunday', 'sunday', '', '', '575179493f4f3'),
(41, 'sunday', 'sunday', '', '', '575179493f4f3'),
(42, 'sunday', 'sunday', '', '', '575179493f4f3'),
(43, 'sunday', 'sunday', '', '', '575179493f4f3'),
(44, 'sunday', 'sunday', '', '', '575179493f4f3'),
(45, 'sunday', 'sunday', '', '', '575179493f4f3'),
(46, 'sunday', 'sunday', '', '', '575179493f4f3'),
(47, 'sunday', 'sunday', '', '', '575179493f4f3'),
(48, 'sunday', 'sunday', '', '', '575179493f4f3'),
(49, 'sunday', 'sunday', '', '', '575179493f4f3'),
(50, 'sadasd', 'asdasdasd', '', '', ''),
(51, 'sunday', 'sunday', '', '', '575179493f4f3'),
(52, 'sunday123', 'sunday123', '', '', '5751799a02115'),
(53, 'monday', 'monday', '', '', '575181f206537'),
(54, 'monday', 'monday', '', '', ''),
(55, 'monday123', 'monday123', '', '', '57518f223eea9'),
(56, 'monday1234', 'monday1234', '', '', '575192e50649d'),
(57, 'monday12346', 'monday12346', '', '', '57519364504c4'),
(58, 'thrusday', 'thrusday', '', '', '575954c366b53'),
(59, 'thrusday', 'thrusday', '', '', '575954c366b53');

-- --------------------------------------------------------

--
-- Table structure for table `tc_user`
--

CREATE TABLE IF NOT EXISTS `tc_user` (
  `tc_user_id` int(11) NOT NULL AUTO_INCREMENT,
  `tc_user_profile` text NOT NULL,
  PRIMARY KEY (`tc_user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `tc_user`
--

INSERT INTO `tc_user` (`tc_user_id`, `tc_user_profile`) VALUES
(1, '{\n  "@context": [\n    "http://purl.imsglobal.org/ctx/lti/v2/ToolConsumerProfile",\n    {\n      "tcp": "http://mylocal/sakai-lti-test-master/106aff6"\n    }\n  ],\n  "@type": "ToolConsumerProfile",\n  "@id": "http://mylocal/sakai-lti-test-master/106aff6",\n  "lti_version": "LTI-2p0",\n  "guid": "106aff6",\n  "product_instance": {\n    "guid": "dcddf9808107-81ea-eaa4-1edf-5d24568c",\n    "product_info": {\n      "product_name": {\n        "default_value": "Sakai LTI 2.0 Test Harness",\n        "key": "product.name"\n      },\n      "product_version": "0.1",\n      "description": {\n        "default_value": "Dr. Chuck Online",\n        "key": "product.version"\n      },\n      "technical_description": {\n        "default_value": "LTI 1, 1.1 and 2.0 compliant",\n        "key": "product.technicalDescription"\n      },\n      "product_family": {\n        "code": "SakaiTestOs",\n        "vendor": {\n          "code": "www.sakaiproject.org",\n          "vendor_name": {\n            "default_value": "Sakai",\n            "key": "product.vendor.name"\n          },\n          "description": {\n            "default_value": "Sakai is an Open Source Learning Environment",\n            "key": "product.vendor.description"\n          },\n          "website": "http://www.sakaiproject.org/",\n          "timestamp": "2012-07-09T012:08:16-04:00",\n          "contact": {\n            "email": "support@sakaiproject.org"\n          }\n        }\n      }\n    },\n    "support": {\n      "email": "drchuck@gmail.com"\n    },\n    "service_owner" : {\n      "@id" : "http://state.university.edu/",\n      "timestamp" : "2012-03-28T09:08:16-04:00",\n      "service_owner_name" : {\n        "default_value" : "State University",\n        "key" : "service_owner.name"\n      },\n      "description" : {\n        "default_value" : "A fictitious university.",\n        "key" : "service_owner.description"\n      },\n      "support" : {\n        "email" : "techsupport@university.edu"\n      }\n    },\n    "service_provider" : {\n      "@id" : "http://yasp.example.com/ServiceProvider",\n      "guid" : "yasp.example.com",\n      "timestamp" : "2012-03-28T09:08:16-04:00",\n      "service_provider_name" : {\n        "default_value" : "Your Application Service Provider",\n        "key" : "service_provider.name"\n      },\n      "description" : {\n        "default_value" : "YASP is a fictitious application service provider",\n        "key" : "service_provider.description"\n      },\n      "support" : {\n        "email" : "support@yasp.example.com"\n      }\n    }\n  },\n  "capability_offered": [\n        "User.id",\n        "User.username",\n        "CourseSection.sourcedId",\n        "Person.sourcedId",\n        "Person.name.full",\n        "Membership.role",\n       "Person.name.given" ,\n       "Person.name.family" ,\n       "Person.email.primary" ,\n       "User.image" ,\n       "Result.sourcedId" ,\n       "Result.autocreate",\n       "Result.sourcedId"\n  ],\n  "service_offered": [\n    {\n      "@type": "RestService",\n      "@id": "tcp:ToolProxy.collection",\n      "endpoint": "http://mylocal/lti_v2/tc/tc_register.php",\n      "format": ["application/vnd.ims.lti.v2.toolproxy+json"],\n      "action": [ "POST" ]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:ToolProxy.item",\n      "endpoint" : "http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}",\n      "format" : ["application/vnd.ims.lti.v2.toolproxy+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:Result.item",\n      "endpoint" : "http://lms.example.com/resources/Result/{sourcedId}",\n      "format" : ["application/vnd.ims.lis.v2.result+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:LtiLinkSettings",\n      "endpoint" : "http://lms.example.com/resources/links/{link_id}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type" : "RestService",\n      "@id" : "tcp:ToolProxyBindingSettings",\n      "endpoint" : "http://lms.example.com/resources/lis/{context_type}/{context_id}/bindings/{vendor_code}/{product_code}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type":"RestService",\n      "@id" : "tcp:ToolProxySettings",\n      "endpoint" : "http://lms.example.com/resources/ToolProxy/{tool_proxy_guid}/custom",\n      "format" : ["application/vnd.ims.lti.v2.toolsettings+json", "application/vnd.ims.lti.v2.toolsettings.simple+json"],\n      "action" : ["GET", "PUT"]\n    },\n    {\n      "@type": "RestService",\n      "@id": "http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php",\n      "endpoint": "http://mylocal/sakai-lti-test-master/common/tool_consumer_outcome.php",\n      "format": ["application/vnd.ims.lti.v1.outcome+xml"],\n      "action": [ "POST" ]\n    }\n  ]\n}');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
