package mvc.module.minos
{
   import yishi.datas.templates.MinosLevelTempInfo;
   import yishi.manager.TempleteManager;
   
   public class MinosLevelInfo
   {
      
      public var progress:int;
      
      public var progressMax:int;
      
      public var killNpc:int;
      
      public var npcMax:int;
      
      public var killBoss:int;
      
      public var bossMax:int;
      
      private var _killInfo:String;
      
      private var _killList:Array = [];
      
      private var _id:int;
      
      private var _lvTemp:MinosLevelTempInfo;
      
      public function MinosLevelInfo()
      {
         super();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id(param1:int) : void
      {
         if(_id == param1)
         {
            return;
         }
         _id = param1;
         _lvTemp = TempleteManager.instance.minosLevelCate.getTemplateByID(_id);
      }
      
      public function get lvTemp() : MinosLevelTempInfo
      {
         return _lvTemp;
      }
      
      public function set killInfo(param1:String) : void
      {
         if(_killInfo == param1 || param1 == "")
         {
            return;
         }
         _killInfo = param1;
         _killList = _killInfo.split(",");
      }
      
      public function get killList() : Array
      {
         return _killList;
      }
   }
}

