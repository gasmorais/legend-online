package armyII.viewII.information
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.SNSEvent;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.SNSManager;
   import mvc.module.sns.BaseSnsInfo;
   import mvc.module.sns.SNSModel;
   import yishi.datas.consant.JobType;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.HeadIconCell;
   import yishi.view.community.RenameView;
   import yishi.view.frame.BuyFrameI;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class InformationView extends Sprite implements Disposeable
   {
      
      private const RENAME_CARD_TEMPID:int = 208018;
      
      private var _bg1:Scale9CornerImage;
      
      private var _bg2:Scale9CornerImage;
      
      private var _imageBg:MutipleImage;
      
      private var _headCell:HeadIconCell;
      
      private var _changeHeadBtn:TextButton;
      
      private var _inputNameTxt:FilterFrameText;
      
      private var _changeNameBtn:TextButton;
      
      public var _goodsExchangeView:ItemExchangeView;
      
      private var _birthSelectComBox:BirthSelectComBox;
      
      private var _areaSelectComBox:AreaSelectComBox;
      
      private var _honerTip:StripView;
      
      private var _consortiaTxt:FilterFrameText;
      
      private var _jobTxt:FilterFrameText;
      
      private var _charmsTxt:FilterFrameText;
      
      private var _exploitsTxt:FilterFrameText;
      
      private var _honerNameTxt:FilterFrameText;
      
      private var _helpBtn:BaseButton;
      
      private var _snsInfo:BaseSnsInfo;
      
      private var _defaultObj:Object;
      
      private var _tempStr:String = "";
      
      private var _vocationIcon:ScaleFrameImage;
      
      private var _helpBtnVocation:BaseButton;
      
      private var _dayAddGeste:Array = ["6000","50000"];
      
      public function InformationView()
      {
         _dayAddGeste = TempleteManager.instance.getConfigInfoByConfigName("DayAddGeste").ConfigValue.split(",");
         super();
         initView();
         addEvent();
         refresh();
      }
      
      private function initView() : void
      {
         _snsInfo = new BaseSnsInfo();
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("army.FrameBack1");
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("army.FrameBack2");
         _imageBg = ComponentFactory.Instance.creatComponentByStylename("army.imageBg");
         _headCell = ComponentFactory.Instance.creatCustomObject("armyII.InformationHeadIconCell");
         _changeHeadBtn = ComponentFactory.Instance.creatComponentByStylename("armyII.InformationChangeHeadBtn");
         _inputNameTxt = ComponentFactory.Instance.creatComponentByStylename("armyII.InformationInputNameTxt");
         _changeNameBtn = ComponentFactory.Instance.creatComponentByStylename("armyII.InformationChangeNameBtn");
         _goodsExchangeView = ComponentFactory.Instance.creatCustomObject("army.itemExchangeView");
         _areaSelectComBox = ComponentFactory.Instance.creatCustomObject("armyII.InformationAreaSelectComBox");
         _birthSelectComBox = ComponentFactory.Instance.creatCustomObject("armyII.InformationBirthSelectComBox");
         _honerTip = ComponentFactory.Instance.creatCustomObject("army.attribute.HonerTip");
         _jobTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.ThaneJobTxt");
         _honerNameTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.ThanehonouerNameTxt");
         _consortiaTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.ThaneConsortiaTxt");
         _charmsTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.ThaneCharmsTxt");
         _exploitsTxt = ComponentFactory.Instance.creatComponentByStylename("army.attribute.ThaneExploitsTxt");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("army.HonerHelpBtn");
         _helpBtnVocation = ComponentFactory.Instance.creatComponentByStylename("army.HonerHelpBtnVocation");
         _honerNameTxt.width = 120;
         _honerNameTxt.height = 35;
         _honerNameTxt.wordWrap = true;
         addChild(_bg1);
         addChild(_bg2);
         addChild(_imageBg);
         addChild(_headCell);
         addChild(_changeHeadBtn);
         addChild(_inputNameTxt);
         addChild(_changeNameBtn);
         addChild(_goodsExchangeView);
         addChild(_jobTxt);
         addChild(_honerNameTxt);
         addChild(_consortiaTxt);
         addChild(_exploitsTxt);
         addChild(_charmsTxt);
         addChild(_honerTip);
         addChild(_helpBtnVocation);
         _honerTip.addChild(createShape());
         setVocation();
         _headCell.type = "head";
         _headCell.headId = thane.snsInfo.headId;
         _inputNameTxt.text = thane.nickName;
         _changeHeadBtn.text = LanguageMgr.GetTranslation("armyII.viewII.information.InformationView.changeHead");
         _changeNameBtn.text = LanguageMgr.GetTranslation("armyII.viewII.information.InformationView.changeName");
         _helpBtn.tipData = LanguageMgr.GetTranslation("armyII.PlayerAttributeView.Tip02");
         _helpBtnVocation.tipData = LanguageMgr.GetTranslation("armyII.PlayerAttributeView.TipVocation");
         if(snsModel.hasSnsTemp)
         {
            initComBox();
         }
         else
         {
            snsManager.addEventListener("SNSTEMP_LOAD_COMPLETE",__snsTempLoadCompleteHandler);
            snsManager.loadSnsTemplate();
         }
      }
      
      private function setVocation() : void
      {
         if(PlayerManager.instance.currentPlayerModel.playerInfo.vocationGrades > 0)
         {
            if(_vocationIcon == null)
            {
               _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("army.VocationIconBtn");
               addChild(_vocationIcon);
            }
            if(_jobTxt)
            {
               _jobTxt.x = 202;
            }
            _vocationIcon.tipData = PlayerManager.instance.getVocationName(thane.templateInfo.Job,PlayerManager.instance.currentPlayerModel.playerInfo.vocationStep,PlayerManager.instance.currentPlayerModel.playerInfo.vocationLevel);
            _vocationIcon.setFrame(PlayerManager.instance.currentPlayerModel.playerInfo.vocationLevel);
            _vocationIcon.visible = true;
         }
      }
      
      private function createShape(param1:int = 160) : Shape
      {
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.beginFill(16711680,0);
         _loc2_.graphics.drawRect(0,0,param1,20);
         _loc2_.graphics.endFill();
         return _loc2_;
      }
      
      private function initComBox() : void
      {
         _defaultObj = {
            "id":0,
            "name":LanguageMgr.GetTranslation("armyII.viewII.information.InformationView.pleaseChoose")
         };
         for each(var _loc2_:Object in snsModel.sexList)
         {
         }
         for each(var _loc3_:Object in snsModel.bloodTypeList)
         {
         }
         for each(var _loc1_:Object in snsModel.horoscopeList)
         {
         }
         _areaSelectComBox.initComBox();
         _birthSelectComBox.setBirth(thane.snsInfo.birthYear,thane.snsInfo.birthMonth,thane.snsInfo.birthDay);
         _areaSelectComBox.setArea(thane.snsInfo.country,thane.snsInfo.province,thane.snsInfo.city);
      }
      
      private function __snsTempLoadCompleteHandler(param1:SNSEvent) : void
      {
         snsManager.removeEventListener("SNSTEMP_LOAD_COMPLETE",__snsTempLoadCompleteHandler);
         initComBox();
      }
      
      private function refreshView() : void
      {
         _headCell.headId = thane.snsInfo.headId;
      }
      
      private function addEvent() : void
      {
         _changeHeadBtn.addEventListener("click",__onChangeHeadClick);
         _changeNameBtn.addEventListener("click",__onChangeNameClick);
         snsManager.addEventListener("SNSINFO_UPDATE",__snsInfoSaveCompleteHandler);
         PlayerManager.instance.currentPlayerModel.playerInfo.addEventListener("NICKNAME_UPDATE",__nicknameUpdateHandler);
         _helpBtn.addEventListener("click",__clickHandler);
         _helpBtnVocation.addEventListener("click",__clickVocationHelpHandler);
         thane.addEventListener("THANE_INFO_UPDATE",__updateHandler);
         PlayerManager.instance.currentPlayerModel.playerInfo.addEventListener("VOCATION_GRADES",__playerVocationUpdate);
      }
      
      protected function __playerVocationUpdate(param1:PlayerEvent) : void
      {
         setVocation();
      }
      
      private function removeEvent() : void
      {
         _changeHeadBtn.removeEventListener("click",__onChangeHeadClick);
         _changeNameBtn.removeEventListener("click",__onChangeNameClick);
         snsManager.removeEventListener("SNSTEMP_LOAD_COMPLETE",__snsTempLoadCompleteHandler);
         snsManager.removeEventListener("SNSINFO_UPDATE",__snsInfoSaveCompleteHandler);
         StageReferance.stage.removeEventListener("click",__onAreaStageClick);
         StageReferance.stage.removeEventListener("click",__onBirthStageClick);
         PlayerManager.instance.currentPlayerModel.playerInfo.removeEventListener("NICKNAME_UPDATE",__nicknameUpdateHandler);
         _helpBtn.removeEventListener("click",__clickHandler);
         _helpBtnVocation.removeEventListener("click",__clickVocationHelpHandler);
         thane.removeEventListener("THANE_INFO_UPDATE",__updateHandler);
         PlayerManager.instance.currentPlayerModel.playerInfo.removeEventListener("VOCATION_GRADES",__playerVocationUpdate);
      }
      
      private function __updateHandler(param1:PlayerEvent) : void
      {
         refresh();
      }
      
      private function __clickVocationHelpHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = null;
         SoundManager.instance.play("022");
         if(thane.isHoly)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("core.heroVocationHelpFrame4");
         }
         else if(thane.isAvenger)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("core.heroVocationHelpFrame3");
         }
         else if(thane.vocationIndex > 0)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("core.heroVocationHelpFrame2");
         }
         else
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("core.heroVocationHelpFrame");
         }
         _loc2_["show"]();
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("core.HonerHelpFrame");
         _loc2_["show"]();
      }
      
      private function __onChangeHeadClick(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.armyController.openChangeHeadFrame(true);
      }
      
      private function __onChangeNameClick(param1:MouseEvent) : void
      {
         var _loc2_:Array = GoodsManager.instance.getBagGoodsByTemplateId(208018);
         if(_loc2_.length == 0)
         {
            CheckUIModuleUtil.instance.tryCall("quickbuy",showBuyFrameCall);
         }
         else
         {
            _loc2_.sortOn("isBinds",2);
            CheckUIModuleUtil.instance.tryCall("rename",openRenameCall,_loc2_);
         }
      }
      
      private function openRenameCall(param1:Array) : void
      {
         var _loc2_:RenameView = new RenameView(1,null,param1[0]);
         _loc2_.show();
      }
      
      private function showBuyFrameCall() : void
      {
         if(ArmyManager.instance.thane.grades < 10)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.information.InformationView.cannotBuyRenameCard",10));
            return;
         }
         var _loc1_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
         _loc1_.data(TempleteManager.instance.getShopTempInfoByItemId(208018));
         _loc1_.show();
      }
      
      private function __nicknameUpdateHandler(param1:PlayerEvent) : void
      {
         _inputNameTxt.text = PlayerManager.instance.currentPlayerModel.playerInfo.nickName;
      }
      
      private function __signTxtChangeHandler(param1:Event) : void
      {
      }
      
      private function __snsInfoSaveCompleteHandler(param1:SNSEvent) : void
      {
         refreshView();
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.information.InformationView.saveSucceed"));
      }
      
      private function __onBirthSelectClick(param1:MouseEvent) : void
      {
         if(_birthSelectComBox && _birthSelectComBox.parent)
         {
            return;
         }
         addChild(_birthSelectComBox);
         if(_areaSelectComBox && _areaSelectComBox.parent)
         {
            _areaSelectComBox.parent.removeChild(_areaSelectComBox);
         }
         param1.stopPropagation();
         StageReferance.stage.addEventListener("click",__onBirthStageClick);
      }
      
      private function __onBirthStageClick(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(_birthSelectComBox.isTargetOrContain(_loc2_))
         {
            return;
         }
         StageReferance.stage.removeEventListener("click",__onBirthStageClick);
         if(_birthSelectComBox && _birthSelectComBox.parent)
         {
            _birthSelectComBox.parent.removeChild(_birthSelectComBox);
         }
      }
      
      private function __onAreaSelectClick(param1:MouseEvent) : void
      {
         if(_areaSelectComBox && _areaSelectComBox.parent)
         {
            return;
         }
         addChild(_areaSelectComBox);
         if(_birthSelectComBox && _birthSelectComBox.parent)
         {
            _birthSelectComBox.parent.removeChild(_birthSelectComBox);
         }
         param1.stopPropagation();
         StageReferance.stage.addEventListener("click",__onAreaStageClick);
      }
      
      private function __onAreaStageClick(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(_areaSelectComBox.isTargetOrContain(_loc2_))
         {
            return;
         }
         StageReferance.stage.removeEventListener("click",__onAreaStageClick);
         if(_areaSelectComBox && _areaSelectComBox.parent)
         {
            _areaSelectComBox.parent.removeChild(_areaSelectComBox);
         }
      }
      
      private function __onSaveClick(param1:MouseEvent) : void
      {
         _snsInfo.userId = thane.userId;
         _snsInfo.nickName = thane.nickName;
         _snsInfo.birthYear = _birthSelectComBox.curSelectedYear ? int(_birthSelectComBox.curSelectedYear) : int(thane.snsInfo.birthYear);
         _snsInfo.birthMonth = _birthSelectComBox.curSelectedMonth ? int(_birthSelectComBox.curSelectedMonth) : int(thane.snsInfo.birthMonth);
         _snsInfo.birthDay = _birthSelectComBox.curSelectedDay ? int(_birthSelectComBox.curSelectedDay) : int(thane.snsInfo.birthDay);
         _snsInfo.country = _areaSelectComBox.curSelectedCountry ? _areaSelectComBox.curSelectedCountry["id"] : thane.snsInfo.country;
         _snsInfo.province = _areaSelectComBox.curSelectedProvince ? _areaSelectComBox.curSelectedProvince["id"] : thane.snsInfo.province;
         _snsInfo.city = _areaSelectComBox.curSelectedCity ? _areaSelectComBox.curSelectedCity["id"] : thane.snsInfo.city;
         snsManager.sendUpdateSnsInfo(_snsInfo);
      }
      
      private function saveSign() : void
      {
         snsManager.sendAutoSaveInfo(_snsInfo);
      }
      
      private function __onResetClick(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("armyII.viewII.information.InformationView.resetTip");
         SimpleAlertHelper.instance.data = [resetResponseHandler];
         SimpleAlertHelper.instance.popAlerFrame(LanguageMgr.GetTranslation("public.prompt"),_loc2_,LanguageMgr.GetTranslation("confirmBtn"),LanguageMgr.GetTranslation("cancel"),true,false,false);
      }
      
      private function resetResponseHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            _birthSelectComBox.reset();
            _areaSelectComBox.reset();
            thane.snsInfo.reset();
            snsManager.sendResetSnsInfo();
         }
      }
      
      public function refresh() : void
      {
         if(thane.nickName == PlayerManager.instance.currentPlayerModel.userInfo.userId + "$")
         {
            thane.nickName = LanguageMgr.GetTranslation("public.nickName");
         }
         _jobTxt.text = JobType.getJobName(thane.templateInfo.Job);
         _honerNameTxt.text = thane.honerTemp.TemplateName;
         _consortiaTxt.text = thane.consortiaName ? thane.consortiaName : LanguageMgr.GetTranslation("armyII.viewII.attribute.PlayerAttributeView.Not");
         _charmsTxt.text = thane.charms.toString();
         _exploitsTxt.text = thane.honer.toString();
         _honerNameTxt.x = _exploitsTxt.x + _exploitsTxt.textWidth + 10;
         _helpBtn.x = _honerNameTxt.x + _honerNameTxt.textWidth + 5;
         if(_honerNameTxt.numLines == 2)
         {
            _honerNameTxt.y = 105;
            _helpBtn.x = 353;
         }
         if(thane.nextHonerTemp.Data <= thane.honerTemp.Data)
         {
            _honerTip.tipData = LanguageMgr.GetTranslation("armyII.PlayerAttributeView.HonorMaxTip",thane.honerDay,_dayAddGeste[0],thane.honerDayMedicinal,_dayAddGeste[1]);
         }
         else
         {
            _honerTip.tipData = LanguageMgr.GetTranslation("armyII.PlayerAttributeView.Tip01",thane.nextHonerTemp.TemplateName,thane.nextHonerTemp.Grades + 1,thane.nextHonerTemp.Data - thane.honer,thane.honerDay,thane.honerDayMax,thane.honerDayMedicinal,_dayAddGeste[1]);
         }
      }
      
      private function get snsManager() : SNSManager
      {
         return SNSManager.instance;
      }
      
      private function get snsModel() : SNSModel
      {
         return SNSManager.instance.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function dispose() : void
      {
         removeEvent();
         saveSign();
         if(_bg1)
         {
            _bg1.dispose();
         }
         _bg1 = null;
         if(_headCell)
         {
            _headCell.dispose();
         }
         _headCell = null;
         if(_changeHeadBtn)
         {
            _changeHeadBtn.dispose();
         }
         _changeHeadBtn = null;
         if(_inputNameTxt)
         {
            _inputNameTxt.dispose();
         }
         _inputNameTxt = null;
         if(_changeNameBtn)
         {
            _changeNameBtn.dispose();
         }
         _changeNameBtn = null;
         if(_areaSelectComBox)
         {
            _areaSelectComBox.dispose();
         }
         _areaSelectComBox = null;
         if(_birthSelectComBox)
         {
            _birthSelectComBox.dispose();
         }
         _birthSelectComBox = null;
         if(_imageBg)
         {
            _imageBg.dispose();
         }
         _imageBg = null;
         ObjectUtils.disposeObject(_jobTxt);
         _jobTxt = null;
         ObjectUtils.disposeObject(_honerNameTxt);
         _honerNameTxt = null;
         ObjectUtils.disposeObject(_consortiaTxt);
         _consortiaTxt = null;
         ObjectUtils.disposeObject(_charmsTxt);
         _charmsTxt = null;
         ObjectUtils.disposeObject(_exploitsTxt);
         _exploitsTxt = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_honerTip);
         _honerTip = null;
         ObjectUtils.disposeObject(_vocationIcon);
         _vocationIcon = null;
         ObjectUtils.disposeObject(_helpBtnVocation);
         _helpBtnVocation = null;
         ObjectUtils.disposeObject(_goodsExchangeView);
         _goodsExchangeView = null;
         ObjectUtils.disposeAllChildren(this);
         _bg2 = null;
         _snsInfo = null;
         _defaultObj = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

