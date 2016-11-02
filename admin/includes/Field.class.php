<?php
debug_backtrace() || die ("Direct access not permitted");
/**
 * Class of the fields displayed in the form of a module
 */
class Field
{
    private $name;
    private $label;
    private $type;
    private $required;
    private $values;
    private $options;
    private $validation;
    private $multilingual;
    private $unique;
    private $comment;
    private $active;
    private $editor;
    private $notice;
    private $optionTable;
    private $relation;
    private $roles;

    public function __construct ($name, $label, $type, $required, $validation, $options, $multilingual, $unique, $comment, $active, $editor, $optionTable, $relation, $roles, $notice = "")
    {
        $this->name = $name;
        $this->label = $label;
        $this->type = $type;
        if(is_numeric($required) && ($required == 1 || $required == 0))
            $this->required = $required;
        if(is_array($options))
            $this->options = $options;
        $this->validation = $validation;
        $this->values = array();
        if(is_numeric($multilingual) && ($multilingual == 1 || $multilingual == 0))
            $this->multilingual = $multilingual;
        if(is_numeric($unique) && ($unique == 1 || $unique == 0))
            $this->unique = $unique;
        else
            $this->active = 0;
        $this->comment = $comment;
        if(is_numeric($active) && ($active == 1 || $active == 0))
            $this->active = $active;
        else
            $this->active = 1;
        if(is_numeric($editor) && ($editor == 1 || $editor == 0))
            $this->editor = $editor;
        else
            $this->editor = 0;
        $this->notice = $notice;
        $this->optionTable = $optionTable;
        $this->relation = $relation;
        $this->roles = $roles;
    }
    function getName()
    {
        return $this->name;
    }
    function getLabel()
    {
        return $this->label;
    }
    function getType()
    {
        return $this->type;
    }
    function isEditor()
    {
        return $this->editor;
    }
    function isRequired()
    {
        return $this->required;
    }
    function getOptions()
    {
        return $this->options;
    }
    function getValue($encode = false, $id_lang = DEFAULT_LANG)
    {
        if(!MULTILINGUAL) $id_lang = 0;
        if(isset($this->values[$id_lang])){
            if(!is_array($this->values[$id_lang]))
                return ($encode) ? htmlentities($this->values[$id_lang], ENT_QUOTES, "UTF-8") : stripslashes($this->values[$id_lang]);
            else
                return $this->values[$id_lang];
        }else
            return "";
    }
    function getValidation()
    {
        return $this->validation;
    }
    function isMultilingual()
    {
        return $this->multilingual;
    }
    function isUnique()
    {
        return $this->unique;
    }
    function isActive()
    {
        return $this->active;
    }
    function getComment()
    {
        return $this->comment;
    }
    function getNotice()
    {
        return $this->notice;
    }
    function getOptionTable()
    {
        return $this->optionTable;
    }
    function getRelation()
    {
        return $this->relation;
    }
    function isAllowed($type)
    {
        $roles = $this->roles;
        return (in_array($type, $roles) || in_array("all", $roles));
    }
    function setValue($value, $id_lang = null)
    {
        if(!is_null($id_lang))
            $this->values[$id_lang] = (is_array($value)) ? $value : html_entity_decode($value, ENT_QUOTES, "UTF-8");
        else{
            for($i = 0; $i < count($this->values); $i++)
                $this->values[$i] = (is_array($value)) ? $value : html_entity_decode($value, ENT_QUOTES, "UTF-8");
        }
    }
    function setNotice($notice)
    {
        $this->notice = $notice;
    }
}
