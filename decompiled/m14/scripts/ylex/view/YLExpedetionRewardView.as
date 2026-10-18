package ylex.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class YLExpedetionRewardView extends Sprite
   {
      
      public var _bigBg:Bitmap;
      
      public var _ft3:Bitmap;
      
      public var _ft1:Bitmap;
      
      public var _rwSigleBtn:IconButton;
      
      public var _rwDoubleBtn:IconButton;
      
      public var _rwPoint:FilterFrameText;
      
      public var _rwExp:FilterFrameText;
      
      public var _ft2:Bitmap;
      
      public var _rwHbox1:HBox;
      
      public var _rwHbox2:HBox;
      
      private var _ptImg:Image;
      
      public function YLExpedetionRewardView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bigBg = ComponentFactory.Instance.creatBitmap("asset.ylexdition.rw.bigBg");
         _ft3 = ComponentFactory.Instance.creatBitmap("asset.ylexdition.rw.ft3");
         _ft1 = ComponentFactory.Instance.creatBitmap("asset.ylexdition.rw.ft1");
         _rwSigleBtn = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.rwSigleBtn");
         _rwDoubleBtn = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.rwDoubleBtn");
         _rwPoint = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.rwPoint");
         _rwExp = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.rwExp");
         _ft2 = ComponentFactory.Instance.creatBitmap("asset.ylexdition.rw.ft2");
         _rwHbox1 = ComponentFactory.Instance.creatCustomObject("ui.ylexpedition.rwHbox1");
         _rwHbox2 = ComponentFactory.Instance.creatCustomObject("ui.ylexpedition.rwHbox2");
         _ptImg = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.rwPtImg");
         addChild(_bigBg);
         addChild(_ft3);
         addChild(_ft1);
         addChild(_rwSigleBtn);
         addChild(_rwDoubleBtn);
         addChild(_rwPoint);
         addChild(_rwExp);
         addChild(_ft2);
         addChild(_rwHbox1);
         addChild(_rwHbox2);
         addChild(_ptImg);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bigBg);
         _bigBg = null;
         ObjectUtils.disposeObject(_ft3);
         _ft3 = null;
         ObjectUtils.disposeObject(_ft1);
         _ft1 = null;
         ObjectUtils.disposeObject(_rwSigleBtn);
         _rwSigleBtn = null;
         ObjectUtils.disposeObject(_rwDoubleBtn);
         _rwDoubleBtn = null;
         ObjectUtils.disposeObject(_rwPoint);
         _rwPoint = null;
         ObjectUtils.disposeObject(_rwExp);
         _rwExp = null;
         ObjectUtils.disposeObject(_ft2);
         _ft2 = null;
         ObjectUtils.disposeObject(_rwHbox1);
         _rwHbox1 = null;
         ObjectUtils.disposeObject(_rwHbox2);
         _rwHbox2 = null;
         ObjectUtils.disposeObject(_ptImg);
         _ptImg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

