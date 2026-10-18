package mvc.controler
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import managers.FishManager;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.fish.FishForkHandler;
   import mvc.module.fish.FishModel;
   import mvc.module.fish.FishOrderInfo;
   import mvc.module.fish.FishPoolHandler;
   import yishi.manager.PathManager;
   
   public class FishControler extends FrameController
   {
      
      public var fishPoolHandler:FishPoolHandler;
      
      public var fishForkHandler:FishForkHandler;
      
      public function FishControler()
      {
         super();
      }
      
      public function get model() : FishModel
      {
         return FishManager.instance.model;
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      override protected function createFrame() : void
      {
         super.createFrame();
         fishPoolHandler = new FishPoolHandler();
         fishForkHandler = new FishForkHandler();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
         fishPoolHandler.exit();
         fishForkHandler.exit();
      }
      
      override public function get frameClassName() : String
      {
         return "fish.FishFrame";
      }
      
      public function loadFishOrderData() : void
      {
         var _loc1_:String = PathManager.getFishOrderPath();
         LoaderManagerII.instance.load(_loc1_,5,8,__fishOrderLoadCompleteHandler);
      }
      
      private function __fishOrderLoadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc4_:FishOrderInfo = null;
         model.orderList.length = 0;
         var _loc5_:XMLList = XML(param2)..FishScore;
         for each(var _loc3_:XML in _loc5_)
         {
            _loc4_ = new FishOrderInfo();
            _loc4_.userId = int(_loc3_.@UserId);
            _loc4_.job = int(_loc3_.@Job);
            _loc4_.nickName = _loc3_.@NickName;
            _loc4_.score = _loc3_.@Score;
            _loc4_.consortiaName = _loc3_.@ConsortiaName;
            _loc4_.grades = int(_loc3_.@Grades);
            _loc4_.fishGrades = int(_loc3_.@FishGrades);
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

