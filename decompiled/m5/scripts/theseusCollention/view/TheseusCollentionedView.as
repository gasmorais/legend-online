package theseusCollention.view
{
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import theseusCollention.UI.TheseusCollenedLeftViewUI;
   import theseusCollention.UI.TheseusCollenedRightViewUi;
   
   public class TheseusCollentionedView extends Sprite
   {
      
      protected var _leftView:TheseusCollenedLeftViewUI;
      
      protected var _rightView:TheseusCollenedRightViewUi;
      
      private var _boxScroll:ScrollPanel;
      
      protected var _theseusCollection_RightBg:Bitmap;
      
      protected var _leftbg:Bitmap;
      
      public function TheseusCollentionedView()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _leftbg = ComponentFactory.Instance.creatBitmap("theseusCollection_leftBg1");
         addChild(_leftbg);
         _leftView = new TheseusCollenedLeftViewUI();
         _theseusCollection_RightBg = ComponentFactory.Instance.creatBitmap("theseusCollection_RightBg");
         _rightView = new TheseusCollenedRightViewUi();
         _theseusCollection_RightBg.x = _rightView.x = 620;
         _theseusCollection_RightBg.y = _rightView.y = 5;
         _leftView.y = 105;
         addChild(_theseusCollection_RightBg);
         addChild(_rightView);
         _boxScroll = ComponentFactory.Instance.creatComponentByStylename("theseuscollentonView.itemScroll");
         _boxScroll.setView(_leftView);
         _boxScroll.invalidateViewport();
         addChild(_boxScroll);
         var _loc1_:IntPoint = new IntPoint(0,5);
         _boxScroll.invalidateViewport();
         _boxScroll.viewPort.viewPosition = _loc1_;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_boxScroll);
         _boxScroll = null;
         ObjectUtils.disposeObject(_leftbg);
         _leftbg = null;
         ObjectUtils.disposeObject(_theseusCollection_RightBg);
         _theseusCollection_RightBg = null;
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

