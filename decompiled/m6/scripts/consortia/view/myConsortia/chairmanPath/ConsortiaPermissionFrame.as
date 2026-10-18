package consortia.view.myConsortia.chairmanPath
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import events.ConsortiaEvent;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaDutyInfo;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.filter.UIFilter;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   
   public class ConsortiaPermissionFrame extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _closeBtn:TextButton;
      
      private var _leftBg:Bitmap;
      
      private var _rightBg:Bitmap;
      
      private var _wordBg1:Bitmap;
      
      private var _wordBg2:Bitmap;
      
      private var _positionListTxtImg:Bitmap;
      
      private var _lineImg:Bitmap;
      
      private var _permissionInfoTxtImg:Bitmap;
      
      private var _separationLineImg:Image;
      
      private var _chairmanBtn:ConsortiaPermissionItem;
      
      private var _viceChairmanBtn:ConsortiaPermissionItem;
      
      private var _officialBtn:ConsortiaPermissionItem;
      
      private var _eliteBtn:ConsortiaPermissionItem;
      
      private var _normalBtn:ConsortiaPermissionItem;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _data:ConsortiaModel;
      
      private var _vbox:VBox;
      
      private var _learnSkill:Bitmap;
      
      private var _recruitStall:Bitmap;
      
      private var _expelStall:Bitmap;
      
      private var _ModifyAnnouncement:Bitmap;
      
      private var _upgradeStall:Bitmap;
      
      private var _researchSkill:Bitmap;
      
      private var _changeName:Bitmap;
      
      private var _levelUp:Bitmap;
      
      private var _callTree:Bitmap;
      
      private var _masterSkill:Bitmap;
      
      private var _businesshop:Bitmap;
      
      public function ConsortiaPermissionFrame()
      {
         super();
         initView();
         addEvent();
         initData();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Image = null;
         _data = FrameControllerManager.instance.consortiaController.model;
         titleText = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaPermissionFrame.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaPermissionFrameDescribeBackground");
         addToContent(_bg);
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaPermissionFrameCloseBtn");
         addToContent(_closeBtn);
         _closeBtn.text = LanguageMgr.GetTranslation("public.close");
         _leftBg = ComponentFactory.Instance.creatBitmap("asset.consortia.PermissionFrameLeftBg");
         addToContent(_leftBg);
         _rightBg = ComponentFactory.Instance.creatBitmap("asset.consortia.PermissionFrameRightBg");
         addToContent(_rightBg);
         _wordBg1 = ComponentFactory.Instance.creatBitmap("asset.consortia.PermissionFrameWordBg");
         addToContent(_wordBg1);
         _wordBg2 = ComponentFactory.Instance.creatBitmap("asset.consortia.PermissionFrameWordBg02");
         addToContent(_wordBg2);
         _positionListTxtImg = ComponentFactory.Instance.creatBitmap("asset.consortia.PermissionFramePositionListTxtImg");
         addToContent(_positionListTxtImg);
         _lineImg = ComponentFactory.Instance.creatBitmap("asset.consortia.PermissionFrameLineBg");
         addToContent(_lineImg);
         _permissionInfoTxtImg = ComponentFactory.Instance.creatBitmap("asset.consortia.PermissionFramePermissionInfoTxtImg");
         addToContent(_permissionInfoTxtImg);
         _separationLineImg = ComponentFactory.Instance.creatComponentByStylename("consortia.PermissionFrameSeparationLineImg");
         addToContent(_separationLineImg);
         _loc2_ = 1;
         while(_loc2_ < 4)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("consortia.PermissionFrameSeparationLineImg");
            _loc1_.x = _separationLineImg.x;
            _loc1_.y = _separationLineImg.y + _loc2_ * 35;
            addToContent(_loc1_);
            _loc2_++;
         }
         _chairmanBtn = ComponentFactory.Instance.creatCustomObject("consortia.ConsortiaPermissionItem");
         _chairmanBtn.type = 1;
         _chairmanBtn.nameTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaPermissionFrame.name00");
         addToContent(_chairmanBtn);
         _viceChairmanBtn = ComponentFactory.Instance.creatCustomObject("consortia.ConsortiaPermissionItem");
         _viceChairmanBtn.type = 2;
         _viceChairmanBtn.nameTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaPermissionFrame.name01");
         addToContent(_viceChairmanBtn);
         _viceChairmanBtn.x = _chairmanBtn.x;
         _viceChairmanBtn.y = _chairmanBtn.y + 35;
         _officialBtn = ComponentFactory.Instance.creatCustomObject("consortia.ConsortiaPermissionItem");
         addToContent(_officialBtn);
         _officialBtn.type = 3;
         _officialBtn.x = _chairmanBtn.x;
         _officialBtn.y = _viceChairmanBtn.y + 35;
         _officialBtn.nameTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaPermissionFrame.name02");
         _normalBtn = ComponentFactory.Instance.creatCustomObject("consortia.ConsortiaPermissionItem");
         addToContent(_normalBtn);
         _normalBtn.type = 5;
         _normalBtn.x = _chairmanBtn.x;
         _normalBtn.y = _officialBtn.y + 35;
         _normalBtn.nameTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaPermissionFrame.name03");
         _buttonGroup = new SelectedButtonGroup();
         _buttonGroup.addSelectItem(_chairmanBtn);
         _buttonGroup.addSelectItem(_viceChairmanBtn);
         _buttonGroup.addSelectItem(_officialBtn);
         _buttonGroup.addSelectItem(_normalBtn);
         _chairmanBtn.dispatchEvent(new MouseEvent("click"));
         _learnSkill = ComponentFactory.Instance.creatBitmap("asset.consortia.learnSkill");
         _recruitStall = ComponentFactory.Instance.creatBitmap("asset.consortia.Recruit");
         _expelStall = ComponentFactory.Instance.creatBitmap("asset.consortia.sackStaff");
         _ModifyAnnouncement = ComponentFactory.Instance.creatBitmap("asset.consortia.modifyAnnouncement");
         _upgradeStall = ComponentFactory.Instance.creatBitmap("asset.consortia.upgrade");
         _researchSkill = ComponentFactory.Instance.creatBitmap("asset.consortia.research");
         _changeName = ComponentFactory.Instance.creatBitmap("asset.consortia.changeName");
         _levelUp = ComponentFactory.Instance.creatBitmap("asset.consortia.levelUp");
         _callTree = ComponentFactory.Instance.creatBitmap("asset.consortia.callTree");
         _masterSkill = ComponentFactory.Instance.creatBitmap("asset.consortia.masterSkill");
         _businesshop = ComponentFactory.Instance.creatBitmap("asset.consortia.businesshop");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("consortia.PermissionInfoVbox");
         addToContent(_vbox);
         _vbox.addChild(_learnSkill);
         _vbox.addChild(_recruitStall);
         _vbox.addChild(_expelStall);
         _vbox.addChild(_upgradeStall);
         _vbox.addChild(_researchSkill);
         _vbox.addChild(_masterSkill);
         _vbox.addChild(_changeName);
         _vbox.addChild(_ModifyAnnouncement);
         _vbox.addChild(_levelUp);
         _vbox.addChild(_callTree);
         _vbox.addChild(_businesshop);
      }
      
      private function uninit() : void
      {
         _closeBtn = null;
         _chairmanBtn = null;
         _viceChairmanBtn = null;
         _officialBtn = null;
         _eliteBtn = null;
         _normalBtn = null;
         _data = null;
         _learnSkill = null;
         _recruitStall = null;
         _expelStall = null;
         _ModifyAnnouncement = null;
         _upgradeStall = null;
         _researchSkill = null;
         _changeName = null;
         _levelUp = null;
         _callTree = null;
         ObjectUtils.disposeObject(_businesshop);
         _businesshop = null;
         ObjectUtils.disposeObject(_masterSkill);
         _masterSkill = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _closeBtn.addEventListener("click",__onCloseHandler);
         _chairmanBtn.addEventListener("click",__onItemClickHandler);
         _viceChairmanBtn.addEventListener("click",__onItemClickHandler);
         _officialBtn.addEventListener("click",__onItemClickHandler);
         _normalBtn.addEventListener("click",__onItemClickHandler);
         _data.addEventListener("UPDA_CONSORTIA_RIGHTS",__onConsortiaDutyInfoUpdata);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _closeBtn.removeEventListener("click",__onCloseHandler);
         _chairmanBtn.removeEventListener("click",__onItemClickHandler);
         _viceChairmanBtn.removeEventListener("click",__onItemClickHandler);
         _officialBtn.removeEventListener("click",__onItemClickHandler);
         _normalBtn.removeEventListener("click",__onItemClickHandler);
         _data.removeEventListener("UPDA_CONSORTIA_RIGHTS",__onConsortiaDutyInfoUpdata);
      }
      
      private function initData() : void
      {
      }
      
      private function __onCloseHandler(param1:Event) : void
      {
         dispose();
      }
      
      private function __onItemClickHandler(param1:Event) : void
      {
         switch(param1.currentTarget)
         {
            case _chairmanBtn:
               showJurisdiction(1);
               break;
            case _viceChairmanBtn:
               showJurisdiction(2);
               break;
            case _officialBtn:
               showJurisdiction(3);
               break;
            case _normalBtn:
               showJurisdiction(4);
         }
      }
      
      private function __onConsortiaDutyInfoUpdata(param1:ConsortiaEvent) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         for each(var _loc1_:ConsortiaDutyInfo in _data.consortiaDutyList)
         {
            switch(int(_loc1_.levels) - 1)
            {
               case 0:
                  _chairmanBtn.data = _loc1_;
                  break;
               case 1:
                  _viceChairmanBtn.data = _loc1_;
                  break;
               case 2:
                  _officialBtn.data = _loc1_;
                  break;
               case 3:
               case 4:
                  _normalBtn.data = _loc1_;
            }
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      private function showJurisdiction(param1:int) : void
      {
         var _loc2_:Array = null;
         clearFilter();
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = ConsortiaDutyInfo.chairman;
               break;
            case 1:
               _loc2_ = ConsortiaDutyInfo.vicePresident;
               break;
            case 2:
               _loc2_ = ConsortiaDutyInfo.officer;
               break;
            case 3:
               _loc2_ = ConsortiaDutyInfo.Elite;
         }
         if(_loc2_.indexOf(13) >= 0)
         {
            _learnSkill.filters = null;
         }
         if(_loc2_.indexOf(8) >= 0)
         {
            _recruitStall.filters = null;
         }
         if(_loc2_.indexOf(5) >= 0)
         {
            _expelStall.filters = null;
         }
         if(_loc2_.indexOf(4) >= 0)
         {
            _ModifyAnnouncement.filters = null;
         }
         if(_loc2_.indexOf(19) >= 0)
         {
            _upgradeStall.filters = null;
         }
         if(_loc2_.indexOf(2) >= 0)
         {
            _researchSkill.filters = null;
         }
         if(_loc2_.indexOf(18) >= 0)
         {
            _changeName.filters = null;
         }
         if(_loc2_.indexOf(17) >= 0)
         {
            _levelUp.filters = null;
         }
         if(_loc2_.indexOf(18) >= 0)
         {
            _callTree.filters = null;
         }
         if(_loc2_.indexOf(43) >= 0)
         {
            _businesshop.filters = null;
         }
         if(_loc2_.indexOf(44) >= 0)
         {
            _masterSkill.filters = null;
         }
      }
      
      private function clearFilter() : void
      {
         _learnSkill.filters = [UIFilter.getBlackFilter()];
         _recruitStall.filters = [UIFilter.getBlackFilter()];
         _expelStall.filters = [UIFilter.getBlackFilter()];
         _ModifyAnnouncement.filters = [UIFilter.getBlackFilter()];
         _upgradeStall.filters = [UIFilter.getBlackFilter()];
         _researchSkill.filters = [UIFilter.getBlackFilter()];
         _changeName.filters = [UIFilter.getBlackFilter()];
         _levelUp.filters = [UIFilter.getBlackFilter()];
         _callTree.filters = [UIFilter.getBlackFilter()];
         _masterSkill.filters = [UIFilter.getBlackFilter()];
         _businesshop.filters = [UIFilter.getBlackFilter()];
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninit();
         super.dispose();
      }
   }
}

