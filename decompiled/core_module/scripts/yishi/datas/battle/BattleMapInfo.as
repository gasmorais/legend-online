package yishi.datas.battle
{
   public class BattleMapInfo
   {
      
      private var _floorPath:String = "";
      
      private var _floorRunPath:String = "";
      
      private var _backPath:String = "";
      
      private var _scenePath:String = "";
      
      private var _sceneRunPath:String = "";
      
      private var _frontPath:String = "";
      
      public function BattleMapInfo()
      {
         super();
      }
      
      public function get sceneRunPath() : String
      {
         return _sceneRunPath;
      }
      
      public function set sceneRunPath(param1:String) : void
      {
         _sceneRunPath = param1;
      }
      
      public function get scenePath() : String
      {
         return _scenePath;
      }
      
      public function set scenePath(param1:String) : void
      {
         _scenePath = param1;
      }
      
      public function get backPath() : String
      {
         return _backPath;
      }
      
      public function set backPath(param1:String) : void
      {
         _backPath = param1;
      }
      
      public function get floorRunPath() : String
      {
         return _floorRunPath;
      }
      
      public function set floorRunPath(param1:String) : void
      {
         _floorRunPath = param1;
      }
      
      public function get floorPath() : String
      {
         return _floorPath;
      }
      
      public function set floorPath(param1:String) : void
      {
         _floorPath = param1;
      }
      
      public function get frontPath() : String
      {
         return _frontPath;
      }
      
      public function set frontPath(param1:String) : void
      {
         _frontPath = param1;
      }
   }
}

