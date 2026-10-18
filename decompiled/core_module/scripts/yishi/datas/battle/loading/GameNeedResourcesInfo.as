package yishi.datas.battle.loading
{
   import yishi.manager.PathManager;
   
   public class GameNeedResourcesInfo
   {
      
      public var type:int;
      
      public var path:String;
      
      public var classPath:String;
      
      public function GameNeedResourcesInfo()
      {
         super();
      }
      
      public function get filePath() : String
      {
         return PathManager.resourcePath + path;
      }
   }
}

