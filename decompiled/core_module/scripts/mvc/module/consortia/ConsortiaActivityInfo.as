package mvc.module.consortia
{
   public class ConsortiaActivityInfo
   {
      
      private var _id:int;
      
      private var _promptTxt:String;
      
      private var _gotoFunction:Function;
      
      private var _operatingFun:Function;
      
      private var _operatingLabel:String;
      
      private var _isEnabled:Boolean;
      
      private var _isNeedJoinMc:Boolean;
      
      public var redTipNum:int = 0;
      
      public var isOpen:Boolean = true;
      
      public function ConsortiaActivityInfo()
      {
         super();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
      
      public function get promptTxt() : String
      {
         return _promptTxt;
      }
      
      public function set promptTxt(param1:String) : void
      {
         _promptTxt = param1;
      }
      
      public function get gotoFunction() : Function
      {
         return _gotoFunction;
      }
      
      public function set gotoFunction(param1:Function) : void
      {
         _gotoFunction = param1;
      }
      
      public function get operatingFun() : Function
      {
         return _operatingFun;
      }
      
      public function set operatingFun(param1:Function) : void
      {
         _operatingFun = param1;
      }
      
      public function get operatingLabel() : String
      {
         return _operatingLabel;
      }
      
      public function set operatingLabel(param1:String) : void
      {
         _operatingLabel = param1;
      }
      
      public function get isEnabled() : Boolean
      {
         return _isEnabled;
      }
      
      public function set isEnabled(param1:Boolean) : void
      {
         _isEnabled = param1;
      }
      
      public function get isNeedJoinMc() : Boolean
      {
         return _isNeedJoinMc;
      }
      
      public function set isNeedJoinMc(param1:Boolean) : void
      {
         _isNeedJoinMc = param1;
      }
   }
}

