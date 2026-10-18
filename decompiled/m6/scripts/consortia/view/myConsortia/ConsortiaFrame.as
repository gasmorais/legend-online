package consortia.view.myConsortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import consortia.view.myConsortia.chairmanPath.ConsortiaPermissionFrame;
   import consortia.view.myConsortia.newui.ConsortiaActivityView;
   import consortia.view.myConsortia.newui.ConsortiaBuildingView;
   import consortia.view.myConsortia.newui.ConsortiaDevelopView;
   import consortia.view.myConsortia.newui.ConsortiaFacilitiesView;
   import consortia.view.myConsortia.newui.ConsortiaInfoView;
   import events.ConsortiaEvent;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.controler.ConsortiaControler;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.base.TabPageUtil;
   
   public class ConsortiaFrame extends Frame implements IManualSize
   {
      
      private var _titleImage:Bitmap;
      
      private var _leftRibbonImage:Image;
      
      private var _rightRibbonImage:Image;
      
      private var _border:ScaleBitmapImage;
      
      private var _tabPageUtil:TabPageUtil;
      
      private var _infoBtn:SelectedIconButton;
      
      private var _developBtn:SelectedIconButton;
      
      private var _memberBtn:SelectedIconButton;
      
      private var _buildingBtn:SelectedIconButton;
      
      private var _facilitiesBtn:SelectedIconButton;
      
      private var _activityBtn:SelectedIconButton;
      
      private var _btnHbox:HBox;
      
      private var _recruitNum:ConsortiaTabItemNumView;
      
      private var _activeNum:ConsortiaTabItemNumView;
      
      private var _facilitiesNum:ConsortiaTabItemNumView;
      
      public function ConsortiaFrame()
      {
         super();
         initView();
         initBtnView();
         addEvent();
         control.getConsortiaInfos();
         resetConsortiaName();
         __recruitNumHandler(null);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,965,633);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _titleImage = ComponentFactory.Instance.creatBitmap("asset.Consortia.ConsortiaFrame.titleImage");
         _leftRibbonImage = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaFrame.leftRibbonImage");
         _rightRibbonImage = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaFrame.rightRibbonImage");
         _border = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaFrame.border");
         _infoBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaFrame.infoBtn");
         _developBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaFrame.developBtn");
         _memberBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaFrame.memberBtn");
         _buildingBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaFrame.buildingBtn");
         _facilitiesBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaFrame.facilitiesBtn");
         _activityBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaFrame.activityBtn");
         _btnHbox = ComponentFactory.Instance.creatComponentByStylename("ConsortiaFrame.btnHbox");
         _recruitNum = new ConsortiaTabItemNumView();
         _activeNum = new ConsortiaTabItemNumView();
         _facilitiesNum = new ConsortiaTabItemNumView();
         addToContent(_titleImage);
         addToContent(_leftRibbonImage);
         addToContent(_rightRibbonImage);
         addToContent(_border);
         addToContent(_btnHbox);
         addToContent(_recruitNum);
         addToContent(_activeNum);
         addToContent(_facilitiesNum);
         _btnHbox.addChild(_infoBtn);
         var _loc1_:SimpleDictionary = ConsortiaManager.instance.model.consortiaMemberList;
         for each(var _loc2_:ThaneInfo in _loc1_)
         {
            if(_loc2_.userId == playerInfo.userId && _loc2_.dutyId == 1)
            {
               _btnHbox.addChild(_developBtn);
            }
         }
         _btnHbox.addChild(_memberBtn);
         _btnHbox.addChild(_buildingBtn);
         _btnHbox.addChild(_activityBtn);
         if(_btnHbox.numChildren == 5)
         {
            _recruitNum.x = _btnHbox.x + 333;
            _recruitNum.y = _btnHbox.y - 10;
            _facilitiesNum.x = _btnHbox.x + 458;
            _facilitiesNum.y = _btnHbox.y - 10;
            _activeNum.x = _btnHbox.x + 583;
            _activeNum.y = _btnHbox.y - 10;
         }
         else
         {
            _recruitNum.x = _btnHbox.x + 213;
            _recruitNum.y = _btnHbox.y - 10;
            _facilitiesNum.x = _btnHbox.x + 338;
            _facilitiesNum.y = _btnHbox.y - 10;
            _activeNum.x = _btnHbox.x + 463;
            _activeNum.y = _btnHbox.y - 10;
         }
      }
      
      private function initBtnView() : void
      {
         _tabPageUtil = new TabPageUtil();
         _tabPageUtil.addItemPage(_infoBtn,creatInfoPage);
         _tabPageUtil.addItemPage(_developBtn,creatDevelopPage);
         _tabPageUtil.addItemPage(_memberBtn,creatMemberPage);
         _tabPageUtil.addItemPage(_buildingBtn,creatBuildingPage);
         _tabPageUtil.addItemPage(_facilitiesBtn,creatFacilitiesPage);
         _tabPageUtil.addItemPage(_activityBtn,creatActivityPage);
         _tabPageUtil.selectIndex = 0;
      }
      
      private function creatInfoPage() : ConsortiaInfoView
      {
         var _loc1_:ConsortiaInfoView = ComponentFactory.Instance.creatCustomObject("Consortia.ConsortiaFrame.infoView");
         addToContent(_loc1_);
         return _loc1_;
      }
      
      private function creatDevelopPage() : ConsortiaDevelopView
      {
         var _loc1_:ConsortiaDevelopView = ComponentFactory.Instance.creatCustomObject("Consortia.ConsortiaFrame.developView");
         addToContent(_loc1_);
         return _loc1_;
      }
      
      private function creatMemberPage() : ConsortiaStaffPage
      {
         var _loc1_:ConsortiaStaffPage = ComponentFactory.Instance.creatCustomObject("Consortia.ConsortiaStaffPage");
         addToContent(_loc1_);
         return _loc1_;
      }
      
      private function creatBuildingPage() : ConsortiaBuildingView
      {
         var _loc1_:ConsortiaBuildingView = ComponentFactory.Instance.creatCustomObject("Consortia.ConsortiaFrame.buildingView");
         addToContent(_loc1_);
         return _loc1_;
      }
      
      private function creatFacilitiesPage() : ConsortiaFacilitiesView
      {
         var _loc1_:ConsortiaFacilitiesView = ComponentFactory.Instance.creatCustomObject("Consortia.ConsortiaFrame.facilitiesView");
         addToContent(_loc1_);
         return _loc1_;
      }
      
      private function creatActivityPage() : ConsortiaActivityView
      {
         var _loc1_:ConsortiaActivityView = ComponentFactory.Instance.creatCustomObject("Consortia.ConsortiaFrame.activityView");
         addToContent(_loc1_);
         return _loc1_;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _tabPageUtil.addEventListener("change",tabChangeHandler);
         model.addEventListener("REFRESH_CONSORTIA_NAME",__onConsortiaInfoUpdata);
         model.addEventListener("UPDA_CONSORTIA_INFO",__onConsortiaInfoUpdata);
         playerInfo.addEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
         model.addEventListener("recruitnum_changed",__recruitNumHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_tabPageUtil)
         {
            _tabPageUtil.removeEventListener("change",tabChangeHandler);
         }
         model.removeEventListener("REFRESH_CONSORTIA_NAME",__onConsortiaInfoUpdata);
         model.removeEventListener("UPDA_CONSORTIA_INFO",__onConsortiaInfoUpdata);
         playerInfo.removeEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
         model.removeEventListener("recruitnum_changed",__recruitNumHandler);
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:ConsortiaPermissionFrame = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaPermissionFrame");
         _loc2_.show();
      }
      
      private function __recruitNumHandler(param1:ConsortiaEvent) : void
      {
         _recruitNum.num = 0;
         if(control.getRightsByIndex(9))
         {
            _recruitNum.num = model.recruitNum;
         }
         _activeNum.num = model.treasureCount + FrameControllerManager.instance.guildFbController.model.getReaNum();
         _facilitiesNum.num = model.taskCanRewardCount;
      }
      
      private function __onConsortiaInfoUpdata(param1:Event) : void
      {
         titleText = model.consortiaInfo.consortiaName + LanguageMgr.GetTranslation("public.consortia");
         __recruitNumHandler(null);
      }
      
      private function __existConsortiaHandler(param1:PlayerEvent) : void
      {
         if(playerInfo.consortiaID == 0)
         {
            dispose();
         }
      }
      
      private function tabChangeHandler(param1:Event) : void
      {
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show(param1:Object = null) : void
      {
         ConsortiaManager.instance.isOpen = true;
         if(param1 != null)
         {
            _tabPageUtil.selectIndex = int(param1);
         }
         LayerManager.Instance.addToLayer(this,3,true,true);
         titleText = model.consortiaInfo.consortiaName + LanguageMgr.GetTranslation("public.consortia");
      }
      
      public function gotoFrame(param1:int = 0) : void
      {
         _tabPageUtil.selectIndex = param1;
         _tabPageUtil.dispatchEvent(new Event("change"));
      }
      
      public function get frameIndex() : int
      {
         return _tabPageUtil.selectIndex;
      }
      
      private function get recruitNum() : int
      {
         var _loc1_:int = 0;
         if(model.applyConsortiaList.length > 0 && playerInfo.consortiaID > 0)
         {
            if(FrameControllerManager.instance.consortiaController.getRightsByIndex(9))
            {
               _loc1_ = int(model.recruitNum);
            }
         }
         return _loc1_;
      }
      
      private function resetConsortiaName() : Boolean
      {
         var _loc2_:Frame = null;
         var _loc1_:String = playerInfo.consortiaName;
         if(model.consortiaInfo.chairmanID != playerInfo.userId)
         {
            return false;
         }
         if(_loc1_.indexOf("!") > 0)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaRenameFrame");
            _loc2_["show"](dispose);
            return true;
         }
         return false;
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get control() : ConsortiaControler
      {
         return FrameControllerManager.instance.consortiaController;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_titleImage);
         _titleImage = null;
         ObjectUtils.disposeObject(_leftRibbonImage);
         _leftRibbonImage = null;
         ObjectUtils.disposeObject(_rightRibbonImage);
         _rightRibbonImage = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_infoBtn);
         _infoBtn = null;
         ObjectUtils.disposeObject(_developBtn);
         _developBtn = null;
         ObjectUtils.disposeObject(_memberBtn);
         _memberBtn = null;
         ObjectUtils.disposeObject(_buildingBtn);
         _buildingBtn = null;
         ObjectUtils.disposeObject(_facilitiesBtn);
         _facilitiesBtn = null;
         ObjectUtils.disposeObject(_activityBtn);
         _activityBtn = null;
         ObjectUtils.disposeObject(_btnHbox);
         _btnHbox = null;
         ObjectUtils.disposeObject(_tabPageUtil);
         _tabPageUtil = null;
         ObjectUtils.disposeObject(_recruitNum);
         _recruitNum = null;
         ObjectUtils.disposeObject(_activeNum);
         _activeNum = null;
         ObjectUtils.disposeObject(_facilitiesNum);
         _facilitiesNum = null;
         super.dispose();
      }
   }
}

