package consortia.view.myConsortia.newui
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import consortia.view.myConsortia.building.ConsortiaAltarFrame;
   import consortia.view.myConsortia.building.ConsortiaCaseFrame;
   import consortia.view.myConsortia.skill.ConsortiaResearchSkillFrame;
   import events.ConsortiaEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mvc.module.consortia.ConsortiaInfo;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   
   public class ConsortiaBuildingView extends Component
   {
      
      private var _buildingBg:Image;
      
      private var _padding:int = 1;
      
      private var _safeDepositBoxTxt:Bitmap;
      
      private var _shopTxtImg:Bitmap;
      
      private var _skillTxtImg:Bitmap;
      
      private var _altarTxtImg:Bitmap;
      
      private var _altarBtn:SimpleButton;
      
      private var _shopBtn:SimpleButton;
      
      private var _safeDepositBoxBtn:SimpleButton;
      
      private var _skillBtn:SimpleButton;
      
      private var _altarNum:FilterFrameText;
      
      private var _altarGrade:Bitmap;
      
      private var _shopGrade:Bitmap;
      
      private var _shopNum:FilterFrameText;
      
      private var _storeGrade:Bitmap;
      
      private var _storeNum:FilterFrameText;
      
      private var _schoolGrade:Bitmap;
      
      private var _schoolNum:FilterFrameText;
      
      private var _masterChurchBtn:SimpleButton;
      
      private var _assassinCampBtn:SimpleButton;
      
      private var _hunterCampBtn:SimpleButton;
      
      private var _masterChurchBmp:Bitmap;
      
      private var _assassinCampBmp:Bitmap;
      
      private var _hunterCampBmp:Bitmap;
      
      private var _infoTipMc:MovieClip;
      
      private var _caseFrame:ConsortiaCaseFrame;
      
      private var _altarFrame:ConsortiaAltarFrame;
      
      private var _researchFrame:ConsortiaResearchSkillFrame;
      
      public function ConsortiaBuildingView()
      {
         super();
         initView();
         initStateView();
         showRedNumTip(model.taskCanRewardCount);
         addEvent();
      }
      
      private function initView() : void
      {
         _buildingBg = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaBuildingView.buildingBg");
         _safeDepositBoxTxt = ComponentFactory.Instance.creatBitmap("asset.consortia.contributeSafeDepositBoxTxtImg");
         _shopTxtImg = ComponentFactory.Instance.creatBitmap("asset.consortia.contributeShopTxtImg");
         _skillTxtImg = ComponentFactory.Instance.creatBitmap("asset.consortia.contributeSkillTxtImg");
         _altarTxtImg = ComponentFactory.Instance.creatBitmap("asset.consortia.contributeAltarTxtImg");
         _altarBtn = ComponentFactory.Instance.creatCustomObject("consortia.contributeAltarBtn");
         _shopBtn = ComponentFactory.Instance.creatCustomObject("consortia.contributeShopBtn");
         _safeDepositBoxBtn = ComponentFactory.Instance.creatCustomObject("consortia.contributeSafeDepositBoxBtn");
         _skillBtn = ComponentFactory.Instance.creatCustomObject("consortia.contributeSkillBtn");
         _masterChurchBtn = ComponentFactory.Instance.creatCustomObject("ConsortiaFacilitiesView.masterChurchBtn");
         _assassinCampBtn = ComponentFactory.Instance.creatCustomObject("ConsortiaFacilitiesView.assassinCampBtn");
         _hunterCampBtn = ComponentFactory.Instance.creatCustomObject("ConsortiaFacilitiesView.hunterCampBtn");
         _masterChurchBmp = ComponentFactory.Instance.creatBitmap("asset.ConsortiaFacilitiesView.masterChurchBmp");
         _assassinCampBmp = ComponentFactory.Instance.creatBitmap("asset.ConsortiaFacilitiesView.assassinCampBmp");
         _hunterCampBmp = ComponentFactory.Instance.creatBitmap("asset.ConsortiaFacilitiesView.hunterCampBmp");
         addChild(_buildingBg);
         addChild(_masterChurchBtn);
         addChild(_assassinCampBtn);
         addChild(_hunterCampBtn);
         addChild(_masterChurchBmp);
         addChild(_assassinCampBmp);
         addChild(_hunterCampBmp);
         addChild(_skillBtn);
         addChild(_altarBtn);
         addChild(_shopBtn);
         addChild(_safeDepositBoxBtn);
         addChild(_safeDepositBoxTxt);
         addChild(_skillTxtImg);
         addChild(_altarTxtImg);
         addChild(_shopTxtImg);
      }
      
      private function initStateView() : void
      {
         if(consortiaInfo.altarLevel > 0)
         {
            _altarNum = ComponentFactory.Instance.creatComponentByStylename("consortia.NumAsset.Gradetext");
            _altarGrade = ComponentFactory.Instance.creatBitmap("asset.consortia.gradeAsset");
            addChild(_altarNum);
            addChild(_altarGrade);
            _altarGrade.x = _altarTxtImg.x + _altarTxtImg.width + _padding;
            _altarGrade.y = 265;
            _altarNum.x = _altarGrade.x + _altarGrade.width + _padding;
            _altarNum.text = consortiaInfo.altarLevel.toString();
            _altarNum.y = 265;
            _altarTxtImg.visible = _altarBtn.visible = true;
         }
         else
         {
            _altarTxtImg.visible = _altarBtn.visible = false;
         }
         if(consortiaInfo.shopLevel > 0)
         {
            _shopGrade = ComponentFactory.Instance.creatBitmap("asset.consortia.gradeAsset");
            _shopNum = ComponentFactory.Instance.creatComponentByStylename("consortia.NumAsset.Gradetext");
            addChild(_shopNum);
            addChild(_shopGrade);
            _shopGrade.x = _shopTxtImg.x + _shopTxtImg.width + _padding;
            _shopGrade.y = 229;
            _shopNum.x = _shopGrade.x + _shopGrade.width + _padding;
            _shopNum.text = consortiaInfo.shopLevel.toString();
            _shopNum.y = 229;
            _shopTxtImg.visible = _shopBtn.visible = true;
         }
         else
         {
            _shopTxtImg.visible = _shopBtn.visible = false;
         }
         if(consortiaInfo.storeLevel > 0)
         {
            _storeGrade = ComponentFactory.Instance.creatBitmap("asset.consortia.gradeAsset");
            _storeNum = ComponentFactory.Instance.creatComponentByStylename("consortia.NumAsset.Gradetext");
            addChild(_storeNum);
            addChild(_storeGrade);
            _storeGrade.x = _safeDepositBoxTxt.x + _safeDepositBoxTxt.width + _padding;
            _storeGrade.y = 252;
            _storeNum.x = _storeGrade.x + _storeGrade.width + _padding;
            _storeNum.text = consortiaInfo.storeLevel.toString();
            _storeNum.y = 252;
            _safeDepositBoxTxt.visible = _safeDepositBoxBtn.visible = true;
         }
         else
         {
            _safeDepositBoxTxt.visible = _safeDepositBoxBtn.visible = false;
         }
         if(consortiaInfo.schoolLevel > 0)
         {
            _schoolGrade = ComponentFactory.Instance.creatBitmap("asset.consortia.gradeAsset");
            _schoolNum = ComponentFactory.Instance.creatComponentByStylename("consortia.NumAsset.Gradetext");
            addChild(_schoolNum);
            addChild(_schoolGrade);
            _schoolGrade.x = _skillTxtImg.x + _skillTxtImg.width + _padding;
            _schoolGrade.y = 158;
            _schoolNum.text = consortiaInfo.schoolLevel.toString();
            _schoolNum.x = _schoolGrade.x + _schoolGrade.width + _padding;
            _schoolNum.y = 158;
            _skillTxtImg.visible = _skillBtn.visible = true;
         }
         else
         {
            _skillTxtImg.visible = _skillBtn.visible = false;
         }
      }
      
      private function addEvent() : void
      {
         _safeDepositBoxBtn.addEventListener("click",__onCaseClickHandler);
         _altarBtn.addEventListener("click",__onAltarClickHandler);
         _shopBtn.addEventListener("click",__onShopClickHandler);
         _skillBtn.addEventListener("click",__onLingshiClickHandler);
         _masterChurchBtn.addEventListener("click",___masterChurchBtnClickHandler);
         _assassinCampBtn.addEventListener("click",__assassinCampBtnClickHandler);
         _hunterCampBtn.addEventListener("click",__hunterCampBtnClickHandler);
         model.addEventListener("UPDA_CONSORTIA_INFO",__onConsortiaInfoUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         if(_safeDepositBoxBtn)
         {
            _safeDepositBoxBtn.removeEventListener("click",__onCaseClickHandler);
         }
         if(_altarBtn)
         {
            _altarBtn.removeEventListener("click",__onAltarClickHandler);
         }
         if(_shopBtn)
         {
            _shopBtn.removeEventListener("click",__onShopClickHandler);
         }
         if(_skillBtn)
         {
            _skillBtn.removeEventListener("click",__onLingshiClickHandler);
         }
         if(_masterChurchBtn)
         {
            _masterChurchBtn.removeEventListener("click",___masterChurchBtnClickHandler);
         }
         if(_assassinCampBtn)
         {
            _assassinCampBtn.removeEventListener("click",__assassinCampBtnClickHandler);
         }
         if(_hunterCampBtn)
         {
            _hunterCampBtn.removeEventListener("click",__hunterCampBtnClickHandler);
         }
         model.removeEventListener("UPDA_CONSORTIA_INFO",__onConsortiaInfoUpdateHandler);
      }
      
      private function __onConsortiaInfoUpdateHandler(param1:ConsortiaEvent) : void
      {
         showRedNumTip(model.taskCanRewardCount);
      }
      
      private function ___masterChurchBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.consortiaController.showMasterSkillFrame(4);
      }
      
      private function __assassinCampBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.consortiaController.showBusinessFrame(5);
      }
      
      private function __hunterCampBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.consortiaController.showTaskSchoolFrame(6);
      }
      
      private function __onCaseClickHandler(param1:Event) : void
      {
         _caseFrame = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaCaseFrame");
         _caseFrame.addEventListener("dispose",__onCaseFrameDispose);
         _caseFrame.show();
      }
      
      private function __onCaseFrameDispose(param1:Event) : void
      {
         _caseFrame.removeEventListener("dispose",__onCaseFrameDispose);
         _caseFrame = null;
         StageReferance.stage.focus = this;
      }
      
      private function __onAltarClickHandler(param1:Event) : void
      {
         FrameControllerManager.instance.consortiaController.showAltarFrame();
      }
      
      private function __onShopClickHandler(param1:Event) : void
      {
         FrameControllerManager.instance.openControllerByInfo("shop",2);
      }
      
      private function __onLingshiClickHandler(param1:Event) : void
      {
         _researchFrame = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaResearchSkillFrame");
         _researchFrame.addEventListener("dispose",__onResearchFrameDispose);
         _researchFrame.show();
      }
      
      private function __onResearchFrameDispose(param1:Event) : void
      {
         _researchFrame.removeEventListener("dispose",__onResearchFrameDispose);
         _researchFrame = null;
         StageReferance.stage.focus = this;
      }
      
      private function showRedNumTip(param1:int) : void
      {
         if(param1 > 0 && _infoTipMc == null)
         {
            _infoTipMc = ComponentFactory.Instance.creatCustomObject("core.InfoTipsMc");
            addChild(_infoTipMc);
            _infoTipMc.mouseChildren = false;
            _infoTipMc.mouseEnabled = false;
            _infoTipMc.x = 730;
            _infoTipMc.y = 55;
         }
         if(_infoTipMc != null)
         {
            _infoTipMc.txt.text = param1 + "";
         }
      }
      
      private function get consortiaInfo() : ConsortiaInfo
      {
         return ConsortiaManager.instance.model.consortiaInfo;
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_buildingBg);
         _buildingBg = null;
         ObjectUtils.disposeObject(_skillBtn);
         _skillBtn = null;
         ObjectUtils.disposeObject(_altarBtn);
         _altarBtn = null;
         ObjectUtils.disposeObject(_shopBtn);
         _shopBtn = null;
         ObjectUtils.disposeObject(_safeDepositBoxBtn);
         _safeDepositBoxBtn = null;
         ObjectUtils.disposeObject(_safeDepositBoxTxt);
         _safeDepositBoxTxt = null;
         ObjectUtils.disposeObject(_skillTxtImg);
         _skillTxtImg = null;
         ObjectUtils.disposeObject(_altarTxtImg);
         _altarTxtImg = null;
         ObjectUtils.disposeObject(_shopTxtImg);
         _shopTxtImg = null;
         ObjectUtils.disposeObject(_masterChurchBtn);
         _masterChurchBtn = null;
         ObjectUtils.disposeObject(_assassinCampBtn);
         _assassinCampBtn = null;
         ObjectUtils.disposeObject(_hunterCampBtn);
         _hunterCampBtn = null;
         if(_caseFrame && _caseFrame.parent)
         {
            _caseFrame.dispose();
         }
         if(_altarFrame && _altarFrame.parent)
         {
            _altarFrame.dispose();
         }
         if(_researchFrame && _researchFrame.parent)
         {
            _researchFrame.dispose();
         }
         super.dispose();
      }
   }
}

