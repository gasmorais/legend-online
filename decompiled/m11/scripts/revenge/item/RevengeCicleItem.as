package revenge.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import yishi.manager.RevengeRoadManager;
   
   public class RevengeCicleItem extends Sprite
   {
      
      public var _circle1:Bitmap;
      
      public var _circle2:Bitmap;
      
      public var _circleLine:Bitmap;
      
      public var _circle3:Bitmap;
      
      public var _buyBtn:BaseButton;
      
      private var _txt:FilterFrameText;
      
      private var _sp:Sprite;
      
      private var _spMask:Shape;
      
      private var _c2Mask:Shape;
      
      private var _num:int;
      
      public function RevengeCicleItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _circle1 = ComponentFactory.Instance.creatBitmap("asset.revengeroad.circle1");
         _circle2 = ComponentFactory.Instance.creatBitmap("asset.revengeroad.circle2");
         _circleLine = ComponentFactory.Instance.creatBitmap("asset.revengeroad.circleLine");
         _circle3 = ComponentFactory.Instance.creatBitmap("asset.revengeroad.circle3");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("ui.revengeroad.buyBtn");
         _txt = ComponentFactory.Instance.creatComponentByStylename("ui.revengeroad.circleTxt");
         _sp = new Sprite();
         _spMask = new Shape();
         _spMask.y = 6;
         _spMask.graphics.beginFill(16711680);
         _spMask.graphics.drawCircle(46,39,39);
         _spMask.graphics.endFill();
         addChild(_spMask);
         _c2Mask = new Shape();
         _c2Mask.graphics.beginFill(16711680);
         _c2Mask.graphics.drawRect(0,92,92,92);
         _c2Mask.graphics.endFill();
         addChild(_circle1);
         addChild(_sp);
         _sp.addChild(_circle2);
         _sp.addChild(_c2Mask);
         _sp.addChild(_circleLine);
         _sp.addChild(_circle3);
         _sp.mask = _spMask;
         _circle2.mask = _c2Mask;
         addChild(_buyBtn);
         addChild(_txt);
      }
      
      public function set num(param1:int) : void
      {
         var _loc2_:int = int(RevengeRoadManager.Ins.model.MAX_VALUE);
         _num = param1 > _loc2_ ? _loc2_ : param1;
         var _loc3_:int = _num / _loc2_ * 91 + 6;
         _c2Mask.y = -_loc3_;
         _circleLine.y = 91 - _loc3_;
         _txt.text = param1 + "/" + _loc2_;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_circle1);
         _circle1 = null;
         ObjectUtils.disposeObject(_circle2);
         _circle2 = null;
         ObjectUtils.disposeObject(_circleLine);
         _circleLine = null;
         ObjectUtils.disposeObject(_circle3);
         _circle3 = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_sp);
         _sp = null;
         ObjectUtils.disposeObject(_spMask);
         _spMask = null;
         ObjectUtils.disposeObject(_c2Mask);
         _c2Mask = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

