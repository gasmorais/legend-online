package mvc.controler
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.controls.Frame;
   import managers.SinglePassManager;
   import mvc.FrameController;
   import mvc.module.singlepass.SinglePassModel;
   import mvc.module.singlepass.SinglePassOrderInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PathManager;
   
   public class SinglePassFrameController extends FrameController
   {
      
      public function SinglePassFrameController()
      {
         super();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 2)
         {
            return "singlepass.SinglePassBugleFrame";
         }
         if(_data.openType == 1)
         {
            return "singlepass.SinglePassFrame";
         }
         return "singlepass.SinglePassFrame";
      }
      
      public function closeFrame() : void
      {
         if(_frame)
         {
            _frame.dispose();
            _frame = null;
         }
      }
      
      override protected function exitFrame() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         super.exitFrame();
      }
      
      public function loadSinglePassOrderData() : void
      {
         var _loc1_:String = PathManager.getSinglePassOrderPath();
         LoaderManagerII.instance.load(_loc1_,5,8,__mazeOrderLoadCompleteHandler);
      }
      
      private function __mazeOrderLoadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc4_:SinglePassOrderInfo = null;
         model.orderList.length = 0;
         var _loc5_:XMLList = XML(param2)..item;
         for each(var _loc3_:XML in _loc5_)
         {
            _loc4_ = new SinglePassOrderInfo();
            _loc4_.userId = int(_loc3_.@UserId);
            _loc4_.job = int(_loc3_.@Job);
            _loc4_.nickName = _loc3_.@NickName;
            _loc4_.consortiaName = _loc3_.@ConsortiaName;
            _loc4_.grades = int(_loc3_.@Grades);
            _loc4_.order = int(_loc3_.@Order);
            _loc4_.index = int(_loc3_.@Index);
            _loc4_.fightingCapacity = int(_loc3_.@FightingCapacity);
            _loc4_.isVip = _loc3_.@IsVip == "true";
            _loc4_.vipType = parseInt(_loc3_.@VipType);
            model.orderList.push(_loc4_);
         }
         model.updateOrderList();
      }
      
      public function get model() : SinglePassModel
      {
         return SinglePassManager.instance.model;
      }
   }
}

