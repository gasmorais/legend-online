package cell.mediator.playerbag
{
   import bag.helper.BagHelper;
   import cell.view.bag.BaseBagCell;
   import com.road.yishi.proto.player.PayTypeMsg;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.interfaces.IMediator;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class OpenGridMediator implements IMediator
   {
      
      private var _cell:BaseBagCell;
      
      public function OpenGridMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as BaseBagCell;
         _cell.addEventListener("click",__onClickHandler,false,10);
      }
      
      public function unregister(param1:Object) : void
      {
         _cell.removeEventListener("click",__onClickHandler);
         _cell = null;
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc8_:String = null;
         var _loc4_:String = null;
         if(FrameControllerManager.instance.armyController.model.currentPage >= 5)
         {
            return;
         }
         var _loc5_:int = (_cell.pos + 7) / 7;
         var _loc6_:int = (playerInfo.bagCount + playerInfo.bagDefaultCount) / 7;
         var _loc7_:int = _loc5_ - _loc6_;
         if(FrameControllerManager.instance.armyController.model.currentPage == 4)
         {
            _loc7_ -= 14;
         }
         if(_cell.lock && !BagHelper.instance.isSelling)
         {
            param1.stopPropagation();
            param1.stopImmediatePropagation();
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc8_ = LanguageMgr.GetTranslation("public.prompt");
            _loc4_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.OpenGridMediator.content",getPointByLine(_loc7_),_loc7_);
            SimpleAlertHelper.instance.data = [payCallBack,_loc7_];
            SimpleAlertHelper.instance.popAlerFrame(_loc8_,_loc4_,_loc2_,_loc3_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",getPointByLine(_loc7_));
         }
      }
      
      private function getPointByLine(param1:int) : int
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = playerInfo.bagCount / 7;
         var _loc6_:int = param1 + _loc3_;
         var _loc2_:Array = TempleteManager.instance.getConfigInfoByConfigName("AddBag_Count").ConfigValue.split(",");
         _loc5_ = _loc3_;
         while(_loc5_ < _loc6_)
         {
            if(_loc5_ <= _loc2_.length - 1)
            {
               _loc4_ += int(_loc2_[_loc5_]);
            }
            else
            {
               _loc4_ += int(_loc2_[_loc2_.length - 1]);
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function payCallBack(param1:Boolean, param2:Boolean, param3:int = 0, param4:int = 0) : void
      {
         var _loc6_:PackageOut = null;
         var _loc5_:PayTypeMsg = null;
         if(param1)
         {
            _loc6_ = new PackageOut(5010);
            _loc5_ = new PayTypeMsg();
            _loc5_.payType = 0;
            if(!param2)
            {
               _loc5_.payType = 1;
            }
            _loc5_.property1 = param3;
            SocketSendManager.instance.sendProtoBuffer(_loc6_,_loc5_);
         }
      }
   }
}

