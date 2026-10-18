package theseusCollention.view
{
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import theseusCollention.item.TheseusCollentionSuitBigItem;
   import utils.LogicUtils;
   import yishi.manager.TempleteManager;
   
   public class TheseusCollentionSuitView extends Sprite
   {
      
      protected var _CollenedSuit:VBox;
      
      private var _itemList:Vector.<TheseusCollentionSuitBigItem> = new Vector.<TheseusCollentionSuitBigItem>();
      
      protected var _leftbg:Bitmap;
      
      private var _boxScroll:ScrollPanel;
      
      public function TheseusCollentionSuitView()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         var _loc1_:TheseusCollentionSuitBigItem = null;
         var _loc4_:int = 0;
         _leftbg = ComponentFactory.Instance.creatBitmap("theseusCollection_leftBg2");
         addChild(_leftbg);
         _CollenedSuit = ComponentFactory.Instance.creatCustomObject("ui.TheseusCollention.CollenedSuit");
         var _loc3_:Array = TempleteManager.instance.collectionSuitTempCate.getTempArray();
         _CollenedSuit.beginChanges();
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc1_ = new TheseusCollentionSuitBigItem();
            _loc1_.data = _loc3_[_loc4_];
            _itemList[_loc4_] = _loc1_;
            _CollenedSuit.addChild(_loc1_);
            _loc4_++;
         }
         _CollenedSuit.commitChanges();
         _boxScroll = ComponentFactory.Instance.creatComponentByStylename("theseuscollentonView.suit.itemScroll");
         _boxScroll.setView(_CollenedSuit);
         _boxScroll.invalidateViewport();
         addChild(_boxScroll);
         var _loc2_:IntPoint = new IntPoint(0,5);
         _boxScroll.invalidateViewport();
         _boxScroll.viewPort.viewPosition = _loc2_;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_leftbg);
         _leftbg = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         ObjectUtils.disposeObject(_boxScroll);
         _boxScroll = null;
         ObjectUtils.disposeObject(_CollenedSuit);
         _CollenedSuit = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

