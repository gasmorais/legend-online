package yishi.view.community
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.ConsortiaControler;
   import mvc.module.armyII.BaseArmy;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class ConsortiaPlayerMenu extends PlayerMenu
   {
      
      private var _promotionBtn:TextButton;
      
      private var _demotionBtn:TextButton;
      
      private var _fireBtn:TextButton;
      
      private var _outRoonFun:Function;
      
      private var _controller:ConsortiaControler;
      
      private var _outRoomBtn:BaseButton;
      
      public var closeRights:Boolean;
      
      private var _army:BaseArmy;
      
      public function ConsortiaPlayerMenu()
      {
         super();
      }
      
      override protected function showConsortia() : void
      {
      }
      
      override protected function initView() : void
      {
         super.showChatButton = true;
         super.initView();
         _controller = FrameControllerManager.instance.consortiaController;
         _back2 = ComponentFactory.Instance.creatComponentByStylename("tips.ConsortiaPlayerMenuBack");
         _back2.y = _back.y + _back.height - 1;
         _back2.visible = false;
         addChild(_back2);
         _promotionBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.UpgradeBtn");
         _promotionBtn.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaPlayerMenu.promotion");
         _promotionBtn.enable = false;
         addChild(_promotionBtn);
         _demotionBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.DemotionBtn");
         _demotionBtn.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaPlayerMenu.demotion");
         _demotionBtn.enable = false;
         addChild(_demotionBtn);
         _fireBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.FireBtn");
         _fireBtn.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaPlayerMenu.fire");
         _fireBtn.enable = false;
         addChild(_fireBtn);
         _outRoomBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.outRoomBtn");
         _outRoomBtn.visible = false;
         addChild(_outRoomBtn);
         _back.width = 240;
         _back2.width = 240;
      }
      
      override protected function uninit() : void
      {
         super.uninit();
         ObjectUtils.disposeAllChildren(this);
         if(_promotionBtn)
         {
            ObjectUtils.disposeObject(_promotionBtn);
         }
         _promotionBtn = null;
         if(_demotionBtn)
         {
            ObjectUtils.disposeObject(_demotionBtn);
         }
         _demotionBtn = null;
         if(_fireBtn)
         {
            ObjectUtils.disposeObject(_fireBtn);
         }
         _fireBtn = null;
         if(_outRoomBtn)
         {
            ObjectUtils.disposeObject(_outRoomBtn);
         }
         _outRoomBtn = null;
         _outRoonFun = null;
         _thane = null;
         _controller = null;
      }
      
      override protected function addEvent() : void
      {
         super.addEvent();
         _promotionBtn.addEventListener("click",__onPromotionHandler);
         _demotionBtn.addEventListener("click",__onDeomotionHandler);
         _fireBtn.addEventListener("click",__onFireHandler);
         _outRoomBtn.addEventListener("click",__onOutRoomHandler);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         if(_promotionBtn)
         {
            _promotionBtn.removeEventListener("click",__onPromotionHandler);
         }
         if(_demotionBtn)
         {
            _demotionBtn.removeEventListener("click",__onDeomotionHandler);
         }
         if(_fireBtn)
         {
            _fireBtn.removeEventListener("click",__onFireHandler);
         }
         if(_outRoomBtn)
         {
            _outRoomBtn.removeEventListener("click",__onOutRoomHandler);
         }
      }
      
      override protected function __stageMouseDown(param1:MouseEvent) : void
      {
      }
      
      private function __onPromotionHandler(param1:MouseEvent) : void
      {
         if(_thane.dutyId == 5)
         {
            _controller.changeDuty(_thane.dutyId - 2,_data["userId"]);
         }
         else
         {
            _controller.changeDuty(_thane.dutyId - 1,_data["userId"]);
         }
         dispose();
      }
      
      private function __onDeomotionHandler(param1:MouseEvent) : void
      {
         _controller.changeDuty(_thane.dutyId + 1,_thane.userId);
         dispose();
      }
      
      private function __onFireHandler(param1:MouseEvent) : void
      {
         SimpleAlertHelper.instance.data = [_controller.fireMember,_thane.userId];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaPlayerMenu.content");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false);
         dispose();
      }
      
      private function __onOutRoomHandler(param1:MouseEvent) : void
      {
         if(_outRoonFun != null)
         {
            _outRoonFun();
         }
         dispose();
      }
      
      public function set outRoomFun(param1:Function) : void
      {
         _outRoonFun = param1;
      }
      
      override public function setData(param1:Object, param2:Boolean = false) : void
      {
         super.setData(param1,param2);
         setRights();
      }
      
      public function showOutRoomBtn(param1:Boolean) : void
      {
         _outRoomBtn.visible = param1;
         _back2.visible = param1;
      }
      
      private function setRights() : void
      {
         var _loc1_:Boolean = _controller.getRightsByIndex(19);
         if(_loc1_ && !closeRights)
         {
            if(selfConsortiaInfo.dutyId && (selfConsortiaInfo.dutyId < _thane.dutyId && selfConsortiaInfo.dutyId != 4))
            {
               if(_thane.dutyId > 2 && (selfConsortiaInfo.dutyId < _thane.dutyId - 1 && selfConsortiaInfo.dutyId != 4))
               {
                  _promotionBtn.enable = true;
               }
               if(_thane.dutyId < 4)
               {
                  _demotionBtn.enable = true;
               }
            }
            else
            {
               _promotionBtn.enable = false;
               _demotionBtn.enable = false;
            }
         }
         _loc1_ = _controller.getRightsByIndex(5);
         if(!_loc1_)
         {
            _promotionBtn.visible = false;
            _demotionBtn.visible = false;
         }
         if(_loc1_ && !closeRights)
         {
            if(selfConsortiaInfo.dutyId && (selfConsortiaInfo.dutyId < _thane.dutyId && selfConsortiaInfo.dutyId != 5))
            {
               _fireBtn.enable = true;
            }
            else
            {
               _fireBtn.enable = false;
            }
         }
         else
         {
            _fireBtn.visible = false;
         }
         _back2.visible = _promotionBtn.visible || _demotionBtn.visible || _fireBtn.visible;
         _back2.y = _back.y + _back.height - 1;
         _promotionBtn.y = _demotionBtn.y = _fireBtn.y = _back2.y + 9;
      }
      
      public function set army(param1:BaseArmy) : void
      {
         _army = param1;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get selfConsortiaInfo() : ThaneInfo
      {
         return _controller.getSimplePlayerInfoById(playerInfo.userId);
      }
   }
}

