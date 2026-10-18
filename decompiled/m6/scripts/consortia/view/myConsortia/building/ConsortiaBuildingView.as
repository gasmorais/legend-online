package consortia.view.myConsortia.building
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortia.view.myConsortia.skill.ConsortiaResearchSkillFrame;
   import flash.display.Bitmap;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import mvc.module.consortia.ConsortiaInfo;
   import yishi.manager.FrameControllerManager;
   
   public class ConsortiaBuildingView extends Sprite implements Disposeable
   {
      
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
      
      private var _caseFrame:ConsortiaCaseFrame;
      
      private var _altarFrame:ConsortiaAltarFrame;
      
      private var _researchFrame:ConsortiaResearchSkillFrame;
      
      public function ConsortiaBuildingView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _safeDepositBoxTxt = ComponentFactory.Instance.creatBitmap("asset.consortia.contributeSafeDepositBoxTxtImg");
         _shopTxtImg = ComponentFactory.Instance.creatBitmap("asset.consortia.contributeShopTxtImg");
         _skillTxtImg = ComponentFactory.Instance.creatBitmap("asset.consortia.contributeSkillTxtImg");
         _altarTxtImg = ComponentFactory.Instance.creatBitmap("asset.consortia.contributeAltarTxtImg");
         _altarBtn = ComponentFactory.Instance.creatCustomObject("consortia.contributeAltarBtn");
         _shopBtn = ComponentFactory.Instance.creatCustomObject("consortia.contributeShopBtn");
         _safeDepositBoxBtn = ComponentFactory.Instance.creatCustomObject("consortia.contributeSafeDepositBoxBtn");
         _skillBtn = ComponentFactory.Instance.creatCustomObject("consortia.contributeSkillBtn");
         addChild(_skillBtn);
         addChild(_altarBtn);
         addChild(_shopBtn);
         addChild(_safeDepositBoxBtn);
         addChild(_safeDepositBoxTxt);
         addChild(_skillTxtImg);
         addChild(_altarTxtImg);
         addChild(_shopTxtImg);
         if(consortiaInfo.altarLevel > 0)
         {
            _altarNum = ComponentFactory.Instance.creatComponentByStylename("consortia.NumAsset.Gradetext");
            _altarGrade = ComponentFactory.Instance.creatBitmap("asset.consortia.gradeAsset");
            _altarGrade.x = _altarTxtImg.x + _altarTxtImg.width + _padding;
            _altarGrade.y = 171;
            addChild(_altarGrade);
            _altarNum.text = consortiaInfo.altarLevel.toString();
            _altarNum.x = _altarGrade.x + _altarGrade.width + _padding;
            _altarNum.y = 171;
            addChild(_altarNum);
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
            _shopGrade.x = _shopTxtImg.x + _shopTxtImg.width + _padding;
            _shopGrade.y = 145;
            addChild(_shopGrade);
            _shopNum.text = consortiaInfo.shopLevel.toString();
            _shopNum.x = _shopGrade.x + _shopGrade.width + _padding;
            _shopNum.y = 145;
            addChild(_shopNum);
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
            _storeGrade.x = _safeDepositBoxTxt.x + _safeDepositBoxTxt.width + _padding;
            _storeGrade.y = 204;
            addChild(_storeGrade);
            _storeNum.text = consortiaInfo.storeLevel.toString();
            _storeNum.x = _storeGrade.x + _storeGrade.width - 5;
            _storeNum.y = 204;
            addChild(_storeNum);
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
            _schoolGrade.x = _skillTxtImg.x + _skillTxtImg.width + _padding;
            _schoolGrade.y = 63;
            addChild(_schoolGrade);
            _schoolNum.text = consortiaInfo.schoolLevel.toString();
            _schoolNum.x = _schoolGrade.x + _schoolGrade.width + _padding;
            _schoolNum.y = 63;
            addChild(_schoolNum);
            addChild(_schoolGrade);
            _skillTxtImg.visible = _skillBtn.visible = true;
         }
         else
         {
            _skillTxtImg.visible = _skillBtn.visible = false;
         }
      }
      
      private function get consortiaInfo() : ConsortiaInfo
      {
         return FrameControllerManager.instance.consortiaController.model.consortiaInfo;
      }
      
      private function uninit() : void
      {
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
         ObjectUtils.disposeAllChildren(this);
         _safeDepositBoxBtn = null;
         _altarBtn = null;
         _skillBtn = null;
         _shopBtn = null;
         _caseFrame = null;
         _altarFrame = null;
         _researchFrame = null;
      }
      
      private function addEvent() : void
      {
         _safeDepositBoxBtn.addEventListener("click",__onCaseClickHandler);
         _altarBtn.addEventListener("click",__onAltarClickHandler);
         _shopBtn.addEventListener("click",__onShopClickHandler);
         _skillBtn.addEventListener("click",__onLingshiClickHandler);
      }
      
      private function removeEvent() : void
      {
         _safeDepositBoxBtn.removeEventListener("click",__onCaseClickHandler);
         _altarBtn.removeEventListener("click",__onAltarClickHandler);
         _shopBtn.removeEventListener("click",__onShopClickHandler);
         _skillBtn.removeEventListener("click",__onLingshiClickHandler);
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
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

