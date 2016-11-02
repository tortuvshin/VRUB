<?php
debug_backtrace() || die ("Direct access not permitted");
/**
 * Class of the modules
 */
class Module
{
    private $name;
    private $title;
    private $dir;
    private $multi;
    private $library;
    private $dashboard;
    private $icon;
    private $ranking;
    private $home;
    private $main;
    private $validation;
    private $dates;
    private $release;
    private $max_medias;
    private $medias_multi;
    private $resizing;
    private $max_w_big;
    private $max_h_big;
    private $max_w_medium;
    private $max_h_medium;
    private $max_w_small;
    private $max_h_small;
    private $permissions;

    public function __construct($name, $title, $dir, $multi, $ranking, $home, $main, $validation, $dates, $release, $library, $dashboard, $max_medias, $medias_multi, $resizing, $max_w_big, $max_h_big, $max_w_medium, $max_h_medium, $max_w_small, $max_h_small, $icon, $permissions)
    {
        $this->name = $name;
        $this->title = $title;
        $this->dir = $dir;
        $this->multi = $multi;
        $this->library = $library;
        $this->dashboard = $dashboard;
        $this->icon = $icon;
        $this->ranking = $ranking;
        $this->home = $home;
        $this->main = $main;
        $this->validation = $validation;
        $this->dates = $dates;
        $this->release = $release;
        $this->max_medias = $max_medias;
        $this->resizing = $resizing;
        $this->medias_multi = $medias_multi;
        $this->max_w_big = $max_w_big;
        $this->max_h_big = $max_h_big;
        $this->max_w_medium = $max_w_medium;
        $this->max_h_medium = $max_h_medium;
        $this->max_w_small = $max_w_small;
        $this->max_h_small = $max_h_small;
        $this->permissions = $permissions;
    }

    function getName()
    {
        return $this->name;
    }
    function getTitle()
    {
        return $this->title;
    }
    function getDir()
    {
        return $this->dir;
    }
    function getIcon()
    {
        return $this->icon;
    }
    function isMultilingual()
    {
        return $this->multi;
    }
    function isLibrary()
    {
        return $this->library;
    }
    function isDashboard()
    {
        return $this->dashboard;
    }
    function isRanking()
    {
        return $this->ranking;
    }
    function isValidation()
    {
        return $this->validation;
    }
    function isHome()
    {
        return $this->home;
    }
    function isMain()
    {
        return $this->main;
    }
    function isDates()
    {
        return $this->dates;
    }
    function isRelease()
    {
        return $this->release;
    }
    function getMaxMedias()
    {
        return $this->max_medias;
    }
    function isMediasMulti()
    {
        return $this->medias_multi;
    }
    function getResizing()
    {
        return $this->resizing;
    }
    function getMaxWBig()
    {
        return $this->max_w_big;
    }
    function getMaxHBig()
    {
        return $this->max_h_big;
    }
    function getMaxWMedium()
    {
        return $this->max_w_medium;
    }
    function getMaxHMedium()
    {
        return $this->max_h_medium;
    }
    function getMaxWSmall()
    {
        return $this->max_w_small;
    }
    function getMaxHSmall()
    {
        return $this->max_h_small;
    }
    function getPermissions($type)
    {
        $permissions = $this->permissions;
        return isset($permissions[$type]) ? $permissions[$type] : array();
    }
}
