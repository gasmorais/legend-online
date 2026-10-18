package mvc.controler
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import flash.events.Event;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.gemmaze.GemMazeModel;
   import mvc.module.gemmaze.GemMazeOrderInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GemMazeManager;
   import yishi.manager.PathManager;
   
   public class GemMazeControler extends FrameController
   {
      
      private var _invideFriendFrame:Frame;
      
      private var _invideByFriendFrame:Frame;
      
      public var frameType:uint;
      
      private var _invideMaskFrame:Frame;
      
      private var _isEnterGemMaze:Boolean = false;
      
      public function GemMazeControler()
      {
         super();
      }
      
      public function get model() : GemMazeModel
      {
         return GemMazeManager.Instance.model;
      }
      
      public function startFrameByType(param1:int, param2:Object = null) : void
      {
         frameType = param1;
         FrameControllerManager.instance.openControllerByInfo("gemmaze",null,param2);
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override protected function createFrame() : void
      {
         super.createFrame();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      override public function get frameClassName() : String
      {
         var _loc1_:String = "gemmaze.GemMazeFrame.frame";
         if(frameType == 2)
         {
            _loc1_ = "gemmaze.GemMazeInvideByFriendFrame";
         }
         return _loc1_;
      }
      
      public function loadGemMazeOrderData() : void
      {
         var _loc1_:String = PathManager.getGemMazeOrderPath();
         LoaderManagerII.instance.load(_loc1_,5,8,__gemMazeOrderLoadCompleteHandler);
      }
      
      public function set isEnterGemMaze(param1:Boolean) : void
      {
         _isEnterGemMaze = param1;
      }
      
      public function get isEnterGemMaze() : Boolean
      {
         return _isEnterGemMaze;
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
      
      public function openInvideMaskFrame() : void
      {
         _invideMaskFrame = ComponentFactory.Instance.creatComponentByStylename("gemmaze.GemMazeInvideMaskFrame");
         _invideMaskFrame["show"]();
      }
      
      public function closeInvideMaskFrame() : void
      {
         if(_invideMaskFrame != null)
         {
            _invideMaskFrame["dispose"]();
         }
      }
      
      public function openInvideFrame() : void
      {
         _invideFriendFrame = ComponentFactory.Instance.creatComponentByStylename("gemmaze.GemMazeInvideFrame");
         _invideFriendFrame.addEventListener("dispose",__invideDispose);
         _invideFriendFrame["show"]();
      }
      
      private function __invideDispose(param1:Event) : void
      {
         _invideFriendFrame.removeEventListener("dispose",__invideDispose);
         _invideFriendFrame = null;
      }
      
      public function openInvideByFrame() : void
      {
         _invideByFriendFrame = ComponentFactory.Instance.creatComponentByStylename("gemmaze.GemMazeInvideByFriendFrame");
         _invideByFriendFrame["show"]();
      }
      
      private function __gemMazeOrderLoadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc4_:GemMazeOrderInfo = null;
         model.orderList.length = 0;
         var _loc5_:XMLList = XML(param2)..GemMazeScore;
         for each(var _loc3_:XML in _loc5_)
         {
            _loc4_ = new GemMazeOrderInfo();
            _loc4_.userId = int(_loc3_.@UserId);
            _loc4_.job = int(_loc3_.@Job);
            _loc4_.nickName = _loc3_.@NickName;
            _loc4_.score = _loc3_.@Score;
            _loc4_.consortiaName = _loc3_.@ConsortiaName;
            _loc4_.grades = int(_loc3_.@Grades);
            _loc4_.gemMazeGrades = int(_loc3_.@GemMazeGrades);
            _loc4_.order = int(_loc3_.@Order);
            _loc4_.index = int(_loc3_.@Index);
            _loc4_.fightingCapacity = int(_loc3_.@FightingCapacity);
            _loc4_.isVip = _loc3_.@IsVip == "true";
            _loc4_.vipType = parseInt(_loc3_.@VipType);
            model.orderList.push(_loc4_);
         }
         model.updateOrderList();
      }
   }
}

