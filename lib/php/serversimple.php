<?
  $includes = realpath(dirname(__FILE__));
  require_once($includes . "/parameter.php");
  require_once($includes . "/header.php");
  require_once($includes . "/httpgenerator.php");

  class RiddlServerSimple {
    private $params;
    private $headers;
    private $debug;

    function __construct($debug=NULL) {
      $this->debug = $debug;
      $this->params = array();
      $this->headers = array();
    }

    function add($what) {
      if (is_array($what) && count($what) == 1 && (is_a($what[0],'RiddlParameterSimple') || is_a($what[0],'RiddlParameterComplex'))) {
        array_push($this->params,$what[0]);
      } elseif (is_array($what) && count($what) == 1 && is_a($what[0],'RiddlHeader')) {
        array_push($this->headers,$what[0]);
      } elseif (is_a($what,'RiddlParameterSimple') || is_a($what,'RiddlParameterComplex')) {
        array_push($this->params,$what);
      } elseif (is_a($what,'RiddlHeader')) {
        array_push($this->headers,$what);
      } elseif (is_array($what) && count($what) > 1) {
        foreach ($what as $w) {
          if (is_a($w,'RiddlParameterSimple') || is_a($w,'RiddlParameterComplex')) {
            array_push($this->params,$w);
          } elseif (is_a($w,'RiddlHeader')) {
            array_push($this->headers,$w);
          }
        }
      }
    }

    function riddl_it() {
      if (is_null($this->debug)) {
        $g = new RiddlHttpGenerator($this->headers,$this->params,fopen('php://output','w'),'header');
      } else {
        $g = new RiddlHttpGenerator($this->headers,$this->params,fopen($this->debug,'w'),'socket');
      }
      $g->generate();
      exit;
    }
  }
?>
