<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of resource_handler_class - handels are the basic-lti-launch requests.
 *
 * @copyright (c) 2016, Srinivasu M <srinivasu.m@impelsys.com>
 * @author Impelsys India Pvt. Ltd.
 */
abstract class Resource_Handler_Class
{
    // variable declaration
    protected $resourceName;
    protected $resourceId;
    protected $resourceType;
    protected $resourceLocation;
    protected $callBackURL;

    // Set variable name
    public function setResourceName()
    {
    }

    public function getResourceName()
    {
    }

    public function setResourceType()
    {
    }

    public function getResourceType()
    {
    }

    public function setResourceId()
    {
    }

    public function getResourceId()
    {
    }

    public function resourceLocation()
    {
    }

    abstract public function launchResource($resourceId, $callBackURL, $token);
}
