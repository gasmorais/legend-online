package consortia.view.myConsortia.building
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconTextButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaRentalBagAlertFrame extends Frame
   {
      
      private var _contentText:FilterFrameText;
      
      private var _confirmBtn:IconButton;
      
      private var _tabGroup:SelectedButtonGroup;
      
      private var _dayBtn1:SelectedIconTextButton;
      
      private var _dayBtn2:SelectedIconTextButton;
      
      private var _dayBtn3:SelectedIconTextButton;
      
      private var _type:int;
      
      private var rentalBagArr:Array;
      
      private var _currentPage:int;
      
      public function ConsortiaRentalBagAlertFrame()
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
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.AgingSureBtn");
         addToContent(_contentText);
         addToContent(_dayBtn1);
         _dayBtn1.x = 25;
         addToContent(_dayBtn2);
         _dayBtn2.x = 25;
         addToContent(_dayBtn3);
         _dayBtn3.x = 25;
         addToContent(_confirmBtn);
         _tabGroup = new SelectedButtonGroup();
         _tabGroup.addSelectItem(_dayBtn1);
         _tabGroup.addSelectItem(_dayBtn2);
         _tabGroup.addSelectItem(_dayBtn3);
         _tabGroup.selectIndex = 0;
      }
      
      public function set currentPage(param1:int) : void
      {
         _currentPage = param1;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
         rentalBagArr = ConfigInfoManager.instance.getConsortiaRentalBagDayCost();
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
         _contentText.text = LanguageMgr.GetTranslation("ConsortiaRentalBagAlertFrame.contentText.text" + _type,_currentPage - 1);
         _dayBtn1.text = LanguageMgr.GetTranslation("ConsortiaRentalBagAlertFrame.dayBtn.text",_loc2_[0],_loc2_[1]);
         _dayBtn2.text = LanguageMgr.GetTranslation("ConsortiaRentalBagAlertFrame.dayBtn.text",_loc3_[0],_loc3_[1]);
         _dayBtn3.text = LanguageMgr.GetTranslation("ConsortiaRentalBagAlertFrame.dayBtn.text",_loc4_[0],_loc4_[1]);
         _confirmBtn.text = LanguageMgr.GetTranslation("public.confirm");
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
         var _loc4_:int = int(_tabGroup.selectIndex);
         var _loc2_:Array = rentalBagArr[_loc4_].split(",");
         if(!_loc2_)
         {
            return;
         }
         var _loc5_:int = int(_loc2_[0]);
         var _loc3_:int = int(FrameControllerManager.instance.consortiaController.model.consortiaInfo.offer);
         if(_loc3_ < _loc2_[1])
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ConsortiaRentalBagAlertFrame.offer.text"));
            return;
         }
         SocketSendManager.instance.sendConsortiaRentalBagOp(_currentPage - 2,_loc5_);
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         this.titleText = LanguageMgr.GetTranslation("bag.view.ConsortiaRentalBagAlertFrame.titleText");
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
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
         if(_contentText)
         {
            ObjectUtils.disposeObject(_contentText);
         }
         _contentText = null;
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
         super.dispose();
      }
   }
}

