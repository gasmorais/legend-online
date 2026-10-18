package yishi.datas.battle
{
   import yishi.manager.PathManager;
   
   public class GameNeedScript
   {
      
      public var acionId:int;
      
      private var _filePath:String;
      
      public function GameNeedScript()
      {
         super();
      }
      
      public function get filePath() : String
      {
         return PathManager.resourcePath + "script/" + acionId + ".swf";
      }
   }
}

