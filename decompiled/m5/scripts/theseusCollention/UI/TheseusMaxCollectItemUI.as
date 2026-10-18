package theseusCollention.UI
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusCollectionStarInfo;
   import mvc.module.theseus.TheseusCollenTionModel;
   
   public class TheseusMaxCollectItemUI extends Sprite
   {
      
      protected var _suitBg:MutipleImage;
      
      protected var _suitItemAttrTxt1:FilterFrameText;
      
      protected var _suitItemAttrTxt2:FilterFrameText;
      
      protected var _theseusCollection_staricon:ScaleFrameImage;
      
      protected var _StarTxt1:FilterFrameText;
      
      public function TheseusMaxCollectItemUI()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _suitBg = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.maxBg");
         _theseusCollection_staricon = ComponentFactory.Instance.creatComponentByStylename("ui.theseusCollection_staricon");
         _StarTxt1 = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.StarTxt1");
         _suitItemAttrTxt1 = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.suitmaxItemAttrTxt");
         _suitItemAttrTxt2 = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.suitmaxItemAttrTxt");
         _theseusCollection_staricon.setFrame(2);
         _theseusCollection_staricon.x = 80;
         _theseusCollection_staricon.y = 10;
         _StarTxt1.x = 100;
         _StarTxt1.y = 10;
         addChild(_suitBg);
         addChild(_suitItemAttrTxt1);
         addChild(_suitItemAttrTxt2);
         addChild(_StarTxt1);
         addChild(_theseusCollection_staricon);
         _StarTxt1.text = "X10";
      }
      
      private function get model() : TheseusCollenTionModel
      {
         return TheseussoulManager.Instance.modelCollenTion;
      }
      
      public function refreView(param1:TheseusCollectionStarInfo) : void
      {
         var _loc4_:Array = param1.hasValueAtt;
         var _loc2_:String = _loc4_[0] ? _loc4_[0] : "";
         var _loc3_:String = _loc4_[1] ? _loc4_[1] : "";
         _suitItemAttrTxt1.width = 224;
         _suitItemAttrTxt2.width = 224;
         _suitItemAttrTxt2.y = 46;
         _suitItemAttrTxt2.htmlText = "";
         if(_loc3_ != "")
         {
            _suitItemAttrTxt1.y = 31;
            _suitItemAttrTxt1.htmlText = LanguageMgr.GetTranslation("TheseusCollenedBigItemUI." + _loc2_) + " : " + param1[_loc2_];
            _suitItemAttrTxt2.htmlText = LanguageMgr.GetTranslation("TheseusCollenedBigItemUI." + _loc3_) + " : " + param1[_loc3_];
         }
         else
         {
            _suitItemAttrTxt1.y = 41;
            _suitItemAttrTxt1.htmlText = LanguageMgr.GetTranslation("TheseusCollenedBigItemUI." + _loc2_) + " : " + param1[_loc2_];
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_suitBg);
         _suitBg = null;
         ObjectUtils.disposeObject(_suitItemAttrTxt1);
         _suitItemAttrTxt1 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

