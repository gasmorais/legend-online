package mvc.controler
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import flash.utils.Dictionary;
   import managers.RemotePetManager;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.remotepet.RemotePetModel;
   import mvc.module.remotepet.RemotePetOrderInfo;
   import mvc.module.remotepet.RemotePetTurnItemInfo;
   import yishi.datas.templates.RemotePetTurnTemplateInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   
   public class RemotePetController extends FrameController
   {
      
      public static const READY_FRAME:uint = 1;
      
      public static const TURN_FRAME:uint = 2;
      
      private var frameType:int;
      
      public function RemotePetController()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      public function startFrameByType(param1:int, param2:Object = null) : void
      {
         frameType = param1;
         FrameControllerManager.instance.openControllerByInfo("remotepet",null,param2);
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
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
      
      override public function get frameClassName() : String
      {
         var _loc1_:String = "remotepet.RemotePetReadyFrame";
         if(frameType == 2)
         {
            _loc1_ = "remotepet.RemotePetTurnFrame";
         }
         return _loc1_;
      }
      
      public function initTurnsData() : void
      {
         var _loc2_:RemotePetTurnItemInfo = null;
         var _loc1_:Dictionary = TempleteManager.instance.remotePetTemplateCate.getTemplates();
         if(_loc1_)
         {
            if(model.turnInfo.remotePetTurnList.length == 0)
            {
               for each(var _loc3_:RemotePetTurnTemplateInfo in _loc1_)
               {
                  _loc2_ = new RemotePetTurnItemInfo();
                  _loc2_.tempInfo = _loc3_;
                  model.turnInfo.remotePetTurnList.push(_loc2_);
               }
            }
         }
         model.turnInfo.remotePetTurnList.sort(sortTurn);
         model.turnInfo.reseData();
         model.turnInfo.updateShowTurnList();
         model.updatePage();
         model.commitTurnList();
      }
      
      private function sortTurn(param1:RemotePetTurnItemInfo, param2:RemotePetTurnItemInfo) : int
      {
         if(param1.tempInfo.Index < param2.tempInfo.Index)
         {
            return -1;
         }
         if(param1.tempInfo.Index > param2.tempInfo.Index)
         {
            return 1;
         }
         if(param1.tempInfo.Type < param2.tempInfo.Type)
         {
            return -1;
         }
         if(param1.tempInfo.Type > param2.tempInfo.Type)
         {
            return 1;
         }
         return 0;
      }
      
      public function pageLookHandler(param1:Boolean) : void
      {
         if(param1 && model.turnInfo.currPage > 1)
         {
            model.turnInfo.currPage--;
         }
         else
         {
            if(!(!param1 && model.turnInfo.currPage < model.turnInfo.totalPage))
            {
               return;
            }
            model.turnInfo.currPage++;
         }
         model.turnInfo.updateShowTurnList();
         model.updatePage();
         model.commitTurnList();
      }
      
      private function get model() : RemotePetModel
      {
         return RemotePetManager.instance.model;
      }
      
      public function loadRemotePetOrderData() : void
      {
         var _loc1_:String = PathManager.getRemotePetOrderPath();
         LoaderManagerII.instance.load(_loc1_,5,8,__OrderLoadCompleteHandler);
      }
      
      private function __OrderLoadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc4_:RemotePetOrderInfo = null;
         var _loc5_:XMLList = XML(param2)..info;
         model.orderTime = DateFormatter.parse(_loc5_[0].@createDate,"YYYY-MM-DD hh:mm:ss");
         model.orderList.length = 0;
         var _loc6_:XMLList = XML(param2)..RemotePetOrder;
         for each(var _loc3_:XML in _loc6_)
         {
            _loc4_ = new RemotePetOrderInfo();
            _loc4_.userId = int(_loc3_.@UserId);
            _loc4_.nickName = _loc3_.@NickName;
            _loc4_.fight = _loc3_.@Fight;
            _loc4_.consortiaName = _loc3_.@ConsortiaName;
            _loc4_.grades = int(_loc3_.@Grades);
            _loc4_.order = int(_loc3_.@Order);
            _loc4_.index = int(_loc3_.@Index);
            _loc4_.fightingCapacity = int(_loc3_.@FightingCapacity);
            _loc4_.isVip = _loc3_.@IsVip == "true";
            model.orderList.push(_loc4_);
         }
         model.orderList.sort(sortOrder);
         model.updateOrderList();
      }
      
      private function sortOrder(param1:RemotePetOrderInfo, param2:RemotePetOrderInfo) : int
      {
         if(param1.order < param2.order)
         {
            return -1;
         }
         if(param1.order > param2.order)
         {
            return 1;
         }
         return 0;
      }
   }
}

