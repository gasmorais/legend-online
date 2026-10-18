package bag.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SelectedIconTextButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.service.managers.SocketSendManager;
   
   public class RentalBagAlertFrame extends Frame
   {
      
      private var _contentText:FilterFrameText;
      
      private var _confirmBtn:TextButton;
      
      private var _tabGroup:SelectedButtonGroup;
      
      private var _dayBtn1:SelectedIconTextButton;
      
      private var _dayBtn2:SelectedIconTextButton;
      
      private var _dayBtn3:SelectedIconTextButton;
      
      private var _useBindBtn:SelectedCheckButton;
      
      private var _alertText:FilterFrameText;
      
      private var _type:int;
      
      private var rentalBagArr:Array;
      
      public function RentalBagAlertFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _contentText = ComponentFactory.Instance.creatComponentByStylename("RentalBagAlertFrame.contentText");
         _dayBtn1 = ComponentFactory.Instance.creatComponentByStylename("RentalBagAlertFrame.dayBtn1");
         _dayBtn2 = ComponentFactory.Instance.creatComponentByStylename("RentalBagAlertFrame.dayBtn2");
         _dayBtn3 = ComponentFactory.Instance.creatComponentByStylename("RentalBagAlertFrame.dayBtn3");
         _useBindBtn = ComponentFactory.Instance.creatComponentByStylename("RentalBagAlertFrame.useBindBtn");
         _alertText = ComponentFactory.Instance.creatComponentByStylename("RentalBagAlertFrame.alertText");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("RentalBagAlertFrame.ConfirmBtn");
         addToContent(_contentText);
         addToContent(_dayBtn1);
         addToContent(_dayBtn2);
         addToContent(_dayBtn3);
         addToContent(_useBindBtn);
         addToContent(_alertText);
         addToContent(_confirmBtn);
         _tabGroup = new SelectedButtonGroup();
         _tabGroup.addSelectItem(_dayBtn1);
         _tabGroup.addSelectItem(_dayBtn2);
         _tabGroup.addSelectItem(_dayBtn3);
         _tabGroup.selectIndex = 0;
         _useBindBtn.selected = true;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
         rentalBagArr = ConfigInfoManager.instance.getRentalBagDayCost();
         if(!rentalBagArr)
         {
            return;
         }
         var _loc2_:Array = rentalBagArr[0].split(",");
         var _loc3_:Array = rentalBagArr[1].split(",");
         var _loc4_:Array = rentalBagArr[2].split(",");
         if(!_loc2_)
         {
            return;
         }
         if(!_loc3_)
         {
            return;
         }
         if(!_loc4_)
         {
            return;
         }
         _contentText.text = LanguageMgr.GetTranslation("RentalBagAlertFrame.contentText.text" + _type);
         _dayBtn1.text = LanguageMgr.GetTranslation("RentalBagAlertFrame.dayBtn.text",_loc2_[0],int(_loc2_[1]) * 2);
         _dayBtn2.text = LanguageMgr.GetTranslation("RentalBagAlertFrame.dayBtn.text",_loc3_[0],int(_loc3_[1]) * 2);
         _dayBtn3.text = LanguageMgr.GetTranslation("RentalBagAlertFrame.dayBtn.text",_loc4_[0],int(_loc4_[1]) * 2);
         _confirmBtn.text = LanguageMgr.GetTranslation("public.confirm");
         _alertText.text = LanguageMgr.GetTranslation("mainBar.view.VipCoolDownFrame.promptTxt");
         _useBindBtn.text = LanguageMgr.GetTranslation("mainBar.view.VipCoolDownFrame.useBind");
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _confirmBtn.addEventListener("click",__confirmHandler);
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _confirmBtn.removeEventListener("click",__confirmHandler);
      }
      
      protected function __confirmHandler(param1:MouseEvent) : void
      {
         if(!rentalBagArr)
         {
            return;
         }
         var _loc3_:int = _useBindBtn.selected ? 0 : 1;
         var _loc5_:int = _tabGroup.selectIndex;
         var _loc2_:Array = rentalBagArr[_loc5_].split(",");
         if(!_loc2_)
         {
            return;
         }
         var _loc6_:String = _loc2_[0];
         var _loc4_:int = _useBindBtn.selected ? playerInfo.allPoint : playerInfo.point;
         if(_loc4_ < _loc2_[1] * 2)
         {
            RechargeAlertMannager.show();
            return;
         }
         SocketSendManager.instance.sendRentalBagOp(_loc3_,_loc6_);
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         this.titleText = LanguageMgr.GetTranslation("bag.view.RentalBagAlertFrame.titleText");
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
               __confirmHandler(null);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_tabGroup)
         {
            ObjectUtils.disposeObject(_tabGroup);
         }
         _tabGroup = null;
         if(_confirmBtn)
         {
            ObjectUtils.disposeObject(_confirmBtn);
         }
         _confirmBtn = null;
         if(_dayBtn1)
         {
            ObjectUtils.disposeObject(_dayBtn1);
         }
         _dayBtn1 = null;
         if(_dayBtn2)
         {
            ObjectUtils.disposeObject(_dayBtn2);
         }
         _dayBtn2 = null;
         if(_dayBtn3)
         {
            ObjectUtils.disposeObject(_dayBtn3);
         }
         _dayBtn3 = null;
         if(_useBindBtn)
         {
            ObjectUtils.disposeObject(_useBindBtn);
         }
         _useBindBtn = null;
         if(_alertText)
         {
            ObjectUtils.disposeObject(_alertText);
         }
         _alertText = null;
         super.dispose();
      }
   }
}

