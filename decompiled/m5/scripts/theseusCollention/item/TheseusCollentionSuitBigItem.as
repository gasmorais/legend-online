package theseusCollention.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusCollectionSuitInfo;
   import mvc.module.theseus.TheseusCollenTionModel;
   import theseusCollention.UI.TheseusCollentionItemUI;
   import theseusCollention.UI.TheseusSuitItemUI;
   import utils.LogicUtils;
   
   public class TheseusCollentionSuitBigItem extends Sprite
   {
      
      private var _data:TheseusCollectionSuitInfo;
      
      private var _suitArr:Array = [];
      
      protected var _theseusCollection_suitDivider:Bitmap;
      
      protected var _SuitTitlebg:ScaleFrameImage;
      
      protected var _nameTxt2:FilterFrameText;
      
      protected var _theseusCollection_suitStorebottom:Bitmap;
      
      protected var _Collenedequip:HBox;
      
      private var _itemList:Vector.<TheseusCollentionItemUI> = new Vector.<TheseusCollentionItemUI>();
      
      protected var _leftView:TheseusSuitItemUI;
      
      private var _id:int;
      
      public function TheseusCollentionSuitBigItem()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _theseusCollection_suitDivider = ComponentFactory.Instance.creatBitmap("theseusCollection_suitDivider");
         _SuitTitlebg = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.SuitTitlebg");
         _nameTxt2 = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollention.nameTxt2");
         _theseusCollection_suitStorebottom = ComponentFactory.Instance.creatBitmap("theseusCollection_suitStorebottom");
         _Collenedequip = ComponentFactory.Instance.creatCustomObject("ui.TheseusCollention.Collenedequip");
         _SuitTitlebg.setFrame(4);
         addChild(_theseusCollection_suitDivider);
         addChild(_SuitTitlebg);
         addChild(_nameTxt2);
         addChild(_theseusCollection_suitStorebottom);
         addChild(_Collenedequip);
         _leftView = new TheseusSuitItemUI();
      }
      
      public function get data() : TheseusCollectionSuitInfo
      {
         return _data;
      }
      
      private function get model() : TheseusCollenTionModel
      {
         return TheseussoulManager.Instance.modelCollenTion;
      }
      
      public function set data(param1:TheseusCollectionSuitInfo) : void
      {
         var _loc3_:Array = null;
         var _loc2_:TheseusCollentionItemUI = null;
         var _loc4_:int = 0;
         _data = param1;
         if(_data)
         {
            _loc3_ = model.getSuit(_data.Suit);
            _Collenedequip.beginChanges();
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc2_ = new TheseusCollentionItemUI(2);
               _itemList[_loc4_] = _loc2_;
               _itemList[_loc4_].data = _loc3_[_loc4_];
               _Collenedequip.addChild(_loc2_);
               _loc4_++;
            }
            _Collenedequip.commitChanges();
            _leftView.refreView(_data);
            _leftView.x = 575;
            _leftView.y = 40;
            addChild(_leftView);
            _nameTxt2.text = param1.SuitName;
            _nameTxt2.textColor = 16045207;
         }
      }
      
      public function dispose() : void
      {
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         ObjectUtils.disposeObject(_theseusCollection_suitDivider);
         _theseusCollection_suitDivider = null;
         ObjectUtils.disposeObject(_SuitTitlebg);
         _SuitTitlebg = null;
         ObjectUtils.disposeObject(_nameTxt2);
         _nameTxt2 = null;
         ObjectUtils.disposeObject(_theseusCollection_suitStorebottom);
         _theseusCollection_suitStorebottom = null;
         ObjectUtils.disposeObject(_Collenedequip);
         _Collenedequip = null;
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

