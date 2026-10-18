package mvc.module.maze
{
   import flash.events.EventDispatcher;
   import yishi.utils.MsgMan;
   
   public class MazeModel extends EventDispatcher
   {
      
      private static var _instance:MazeModel;
      
      public static const SHOP_MAZE_COIN_TEMPID:int = 208009;
      
      private var _isAuto:Boolean = false;
      
      private var _mazeOrderList:Vector.<MazeOrderInfo>;
      
      public function MazeModel()
      {
         super();
         initData();
      }
      
      public static function get instance() : MazeModel
      {
         if(!_instance)
         {
            _instance = new MazeModel();
         }
         return _instance;
      }
      
      private function initData() : void
      {
         _mazeOrderList = new Vector.<MazeOrderInfo>();
      }
      
      public function get mazeOrderList() : Vector.<MazeOrderInfo>
      {
         return _mazeOrderList;
      }
      
      public function get isAuto() : Boolean
      {
         return _isAuto;
      }
      
      public function set isAuto(param1:Boolean) : void
      {
         if(_isAuto == param1)
         {
            return;
         }
         _isAuto = param1;
         MsgMan.notifyObserver("REFRESH_AUTO_STATE");
      }
   }
}

