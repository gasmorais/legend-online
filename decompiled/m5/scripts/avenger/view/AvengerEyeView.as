package avenger.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.base.ProgressCommon;
   
   public class AvengerEyeView extends Component
   {
      
      private var _nextDescText:FilterFrameText;
      
      private var _curDescText:FilterFrameText;
      
      private var _eyeBack:MutipleImage;
      
      private var _expBar:ProgressCommon;
      
      private var _numBit:BitmapData;
      
      private var _gradeCon:Component;
      
      private var _maxImage:Image;
      
      public function AvengerEyeView()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _nextDescText = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerEyeView.nextDescText");
         _curDescText = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerEyeView.curDescText");
         _eyeBack = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerEyeView.eyeBack");
         _numBit = ComponentFactory.Instance.creatBitmapData("asset.Avenger.numBmd");
         _gradeCon = ComponentFactory.Instance.creatComponentByStylename("AvengerEyeView.gradeCon");
         _expBar = ComponentFactory.Instance.creatComponentByStylename("AvengerEyeView.expBar");
         _maxImage = ComponentFactory.Instance.creatComponentByStylename("AvengerEyeView.maxImage");
         addChild(_eyeBack);
         addChild(_gradeCon);
         addChild(_curDescText);
         addChild(_nextDescText);
         addChild(_maxImage);
         addChild(_expBar);
         _maxImage.visible = false;
      }
      
      private function addEvent() : void
      {
         thane.addEventListener("VOCATION_GRADES",__vocationChangeHandler);
         thane.addEventListener("VOCATION_GP",__vocationChangeHandler);
      }
      
      private function removeEvent() : void
      {
         thane.removeEventListener("VOCATION_GRADES",__vocationChangeHandler);
         thane.removeEventListener("VOCATION_GP",__vocationChangeHandler);
      }
      
      private function __vocationChangeHandler(param1:PlayerEvent) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         if(thane.isHoly)
         {
            _loc1_ = 30;
         }
         else
         {
            _loc1_ = int(thane.vocationGrades);
         }
         NumberViewUtils.refreshValue(_loc1_,_gradeCon,_numBit,14,18,11,14,"0123456789");
         var _loc3_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_loc1_,152);
         var _loc2_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_loc1_ + 1,152);
         if(!_loc3_)
         {
            return;
         }
         _curDescText.htmlText = LanguageMgr.GetTranslation("AvengerEyeView.curDescText.text",_loc3_.ActiveObject);
         if(_loc2_)
         {
            _nextDescText.htmlText = LanguageMgr.GetTranslation("AvengerEyeView.curDescText.text",_loc2_.ActiveObject);
            _expBar.value = thane.vocationGp / _loc2_.Data;
            _expBar.text = thane.vocationGp + "/" + _loc2_.Data;
            _maxImage.visible = false;
         }
         else
         {
            _nextDescText.htmlText = "";
            _expBar.value = 1;
            _expBar.text = LanguageMgr.GetTranslation("armyII.viewII.rune.RuneUpgradeView.RuneMaxTxt");
            _maxImage.visible = true;
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_nextDescText);
         _nextDescText = null;
         ObjectUtils.disposeObject(_curDescText);
         _curDescText = null;
         ObjectUtils.disposeObject(_eyeBack);
         _eyeBack = null;
         ObjectUtils.disposeObject(_gradeCon);
         _gradeCon = null;
         ObjectUtils.disposeObject(_numBit);
         _numBit = null;
         ObjectUtils.disposeObject(_expBar);
         _expBar = null;
         ObjectUtils.disposeObject(_maxImage);
         _maxImage = null;
         super.dispose();
      }
   }
}

