<?php
debug_backtrace() || die ("Шууд хандах боломжгүй");
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
    private $notices;
    private $optionTable;
    private $roles;

    public function __construct($name, $label, $type, $required, $validation, $options, $multilingual, $unique, $comment, $active, $editor, $optionTable, $roles)
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
        $this->notices = array();
        $this->optionTable = $optionTable;
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
    function getValue($encode = false, $index = 0, $id_lang = DEFAULT_LANG)
    {
        if(!MULTILINGUAL) $id_lang = 0;
        if(isset($this->values[$index][$id_lang])){
            if(!is_array($this->values[$index][$id_lang]))
                return ($encode) ? htmlentities($this->values[$index][$id_lang], ENT_QUOTES, "UTF-8") : stripslashes($this->values[$index][$id_lang]);
            else
                return $this->values[$index][$id_lang];
        }else
            return "";
    }
    function removeValue($index)
    {
        if(isset($this->values[$index]))
            unset($this->values[$index]);
    }
    function getAllValues()
    {
        return $this->values;
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
    function getNotice($index = 0)
    {
        if(isset($this->notices[$index]))
            return $this->notices[$index];
        else
            return "";
    }
    function getOptionTable()
    {
        return $this->optionTable;
    }
    function isAllowed($type)
    {
        $roles = $this->roles;
        return (in_array($type, $roles) || in_array("all", $roles));
    }
    function setValue($value, $index = 0, $id_lang = null)
    {
        if(!is_null($id_lang))
            $this->values[$index][$id_lang] = (is_array($value)) ? $value : html_entity_decode($value, ENT_QUOTES, "UTF-8");
        else{
            for($i = 0; $i < count($this->values); $i++)
                $this->values[$index][$i] = (is_array($value)) ? $value : html_entity_decode($value, ENT_QUOTES, "UTF-8");
        }
    }
    function setNotice($notice, $index = 0)
    {
        $this->notices[$index] = $notice;
    }
}
