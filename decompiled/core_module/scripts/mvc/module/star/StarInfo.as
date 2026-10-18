package mvc.module.star
{
   import flash.events.EventDispatcher;
   import yishi.datas.templates.StarTemplate;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class StarInfo extends EventDispatcher
   {
      
      protected static const DROP_DELETE:String = "DROP_DELETE";
      
      protected var _changeObj:SimpleDictionary;
      
      public var id:int;
      
      public var userId:int;
      
      public var oldBagType:int;
      
      public var bagType:int;
      
      public var pos:int;
      
      public var grade:int;
      
      public var gp:int;
      
      public var template:StarTemplate;
      
      public var count:int = 1;
      
      public var composeLock:Boolean;
      
      private var _tempId:int;
      
      public function StarInfo()
      {
         super();
         _changeObj = new SimpleDictionary(true);
      }
      
      public function set tempId(param1:int) : void
      {
         if(_tempId != param1)
         {
            _tempId = param1;
            template = TempleteManager.instance.starTempalteCate.getTemplateByID(_tempId);
         }
      }
      
      public function get tempId() : int
      {
         return _tempId;
      }
      
      public function beginChange() : void
      {
         _changeObj.clear();
      }
      
      public function commit() : void
      {
         if(!_changeObj["DROP_DELETE"])
         {
         }
      }
   }
}

