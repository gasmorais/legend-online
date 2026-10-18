package mvc.controler
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.controls.Frame;
   import flash.events.Event;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.maze.MazeModel;
   import mvc.module.maze.MazeOrderInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketSendManager;
   
   public class MazeControler extends FrameController
   {
      
      private var _isOpen:Boolean = true;
      
      public function MazeControler()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
         if(_isOpen)
         {
            PlayerManager.instance.addEventListener("UPDATE_TOWER_INFO",__updateTowerInfoHandler);
         }
      }
      
      override protected function get preLoad() : Boolean
      {
         return _isOpen;
      }
      
      override protected function startPreLoad() : void
      {
         SocketSendManager.instance.requestTowerInfo(0);
      }
      
      private function __updateTowerInfoHandler(param1:PlayerEvent) : void
      {
         PlayerManager.instance.removeEventListener("UPDATE_TOWER_INFO",__updateTowerInfoHandler);
         _isOpen = false;
         super.start(_data);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         var _loc1_:Boolean = false;
         if(_data && _data.openType == 2)
         {
            _loc1_ = true;
         }
         _frame["show"](_loc1_);
      }
      
      override protected function createFrame() : void
      {
         super.createFrame();
      }
      
      override protected function exitFrame() : void
      {
         PlayerManager.instance.removeEventListener("UPDATE_TOWER_INFO",__updateTowerInfoHandler);
         _isOpen = true;
         super.exitFrame();
      }
      
      override public function get frameClassName() : String
      {
         return "maze.MazeFrame1";
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      public function loadMazeOrderData(param1:int) : void
      {
         var _loc2_:String = PathManager.getMazeOrderPath(param1);
         LoaderManagerII.instance.load(_loc2_,5,8,__mazeOrderLoadCompleteHandler);
      }
      
      private function __mazeOrderLoadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc4_:MazeOrderInfo = null;
         model.mazeOrderList.length = 0;
         var _loc5_:XMLList = XML(param2)..item;
         for each(var _loc3_:XML in _loc5_)
         {
            _loc4_ = new MazeOrderInfo();
            _loc4_.userId = int(_loc3_.@userId);
            _loc4_.job = int(_loc3_.@job);
            _loc4_.nickName = _loc3_.@nickName;
            _loc4_.consortiaName = _loc3_.@consortiaName;
            _loc4_.mazeOrder = int(_loc3_.@towerOrder);
            _loc4_.maxFloor = int(_loc3_.@towerIndex);
            _loc4_.grades = int(_loc3_.@grades);
            _loc4_.fightingCapacity = int(_loc3_.@fightingCapacity);
            _loc4_.isVip = _loc3_.@IsVip == "true";
            _loc4_.vipType = parseInt(_loc3_.@VipType);
            model.mazeOrderList.push(_loc4_);
         }
         model.dispatchEvent(new Event("ORDERDATA_LOAD_COMPLETE"));
      }
      
      public function get model() : MazeModel
      {
         return MazeModel.instance;
      }
   }
}

