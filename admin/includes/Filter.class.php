<?php
debug_backtrace() || die ("Шууд хандах боломжгүй");
/**
 * Class of the filters displayed in the search engine in the listing of a module
 */
class Filter
{
    private $name;
    private $label;
    private $value;
    private $options;
    private $order;

    public function __construct ($name, $label, $options, $order)
    {
        $this->name = $name;
        $this->label = $label;
        if(is_array($options))
            $this->options = $options;
    }
    function getName()
    {
        return $this->name;
    }
    function getLabel()
    {
        return $this->label;
    }
    function getValue()
    {
        return $this->value;
    }
    function getOrder()
    {
        return $this->order;
    }
    function getOptions()
    {
        return $this->options;
    }
    function setValue($value)
    {
        $this->value = $value;
    }
}
