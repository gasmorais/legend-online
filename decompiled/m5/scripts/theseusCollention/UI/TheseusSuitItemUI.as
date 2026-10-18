package theseusCollention.UI
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusCollectionSuitInfo;
   import mvc.module.theseus.TheseusCollenTionModel;
   import yishi.filter.UIFilter;
   import yishi.manager.TempleteManager;
   
   public class TheseusSuitItemUI extends Sprite
   {
      
      protected var _suitBg:MutipleImage;
      
      protected var _suitItemAttrTxt1:FilterFrameText;
      
      protected var _suitItemAttrTxt4:FilterFrameText;
      
      protected var _suitItemAttrTxt3:FilterFrameText;
      
      protected var _suitItemAttrTxt2:FilterFrameText;
      
      private var _boxScroll:ScrollPanel;
      
      protected var _CollenedSuit:VBox;
      
      public function TheseusSuitItemUI()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _suitBg = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.suitBg");
         _suitItemAttrTxt1 = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.suitItemAttrTxt");
         _suitItemAttrTxt4 = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.suitItemAttrTxt4");
         _suitItemAttrTxt3 = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.suitItemAttrTxt3");
         _suitItemAttrTxt2 = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.suitItemAttrTxt2");
         _CollenedSuit = ComponentFactory.Instance.creatCustomObject("ui.TheseusCollention.CollenedSuitTxt");
         addChild(_suitBg);
      }
      
      private function get model() : TheseusCollenTionModel
      {
         return TheseussoulManager.Instance.modelCollenTion;
      }
      
      public function refreView(param1:TheseusCollectionSuitInfo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:TheseusCollectionSuitInfo = TempleteManager.instance.collectionSuitTempCate.getTemplateByID(param1.Id);
         var _loc4_:Array = [0,3,6,10];
         if(_loc2_)
         {
            _suitItemAttrTxt1.text = LanguageMgr.GetTranslation("theseusCollention.UI.suit1") + " " + _loc2_.Star0Desc;
            _suitItemAttrTxt2.text = LanguageMgr.GetTranslation("theseusCollention.UI.suit2") + " " + _loc2_.Star3Desc;
            _suitItemAttrTxt3.text = LanguageMgr.GetTranslation("theseusCollention.UI.suit3") + " " + _loc2_.Star6Desc;
            _suitItemAttrTxt4.text = LanguageMgr.GetTranslation("theseusCollention.UI.suit4") + " " + _loc2_.Star10Desc;
            _loc3_ = 1;
            while(_loc3_ <= 4)
            {
               if(!model.suit(_loc2_.Suit,_loc4_[_loc3_ - 1]))
               {
                  this["_suitItemAttrTxt" + _loc3_].filters = [UIFilter.getGrayFilter()];
               }
               else
               {
                  this["_suitItemAttrTxt" + _loc3_].filters = null;
               }
               this["_suitItemAttrTxt" + _loc3_].height = this["_suitItemAttrTxt" + _loc3_].textHeight + 5;
               _loc3_++;
            }
            _CollenedSuit.beginChanges();
            _CollenedSuit.addChild(_suitItemAttrTxt1);
            _CollenedSuit.addChild(_suitItemAttrTxt2);
            _CollenedSuit.addChild(_suitItemAttrTxt3);
            _CollenedSuit.addChild(_suitItemAttrTxt4);
            _CollenedSuit.commitChanges();
            _boxScroll = ComponentFactory.Instance.creatComponentByStylename("theseuscollentonView.suit.itemtxtScroll");
            _boxScroll.setView(_CollenedSuit);
            _boxScroll.invalidateViewport();
            addChild(_boxScroll);
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_suitBg);
         _suitBg = null;
         ObjectUtils.disposeObject(_suitItemAttrTxt1);
         _suitItemAttrTxt1 = null;
         ObjectUtils.disposeObject(_suitItemAttrTxt4);
         _suitItemAttrTxt4 = null;
         ObjectUtils.disposeObject(_suitItemAttrTxt3);
         _suitItemAttrTxt3 = null;
         ObjectUtils.disposeObject(_suitItemAttrTxt2);
         _suitItemAttrTxt2 = null;
         ObjectUtils.disposeObject(_CollenedSuit);
         _CollenedSuit = null;
         ObjectUtils.disposeObject(_boxScroll);
         _boxScroll = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

