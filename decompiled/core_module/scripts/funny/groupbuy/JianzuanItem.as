package funny.groupbuy
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import yishi.utils.NumberViewUtils;
   
   public class JianzuanItem extends Component
   {
      
      public var w:int;
      
      private var _numC:Sprite;
      
      private var _img1:DisplayObject;
      
      private var _img2:DisplayObject;
      
      public function JianzuanItem()
      {
         super();
         initUI();
      }
      
      private function initUI() : void
      {
         _img1 = ComponentFactory.Instance.creat("asset.groupbuy.zijianqu");
         this.addChild(_img1);
         _numC = ComponentFactory.Instance.creatCustomObject("groupbuy.jianzuanC");
         this.addChild(_numC);
         _img2 = ComponentFactory.Instance.creat("asset.groupbuy.zizuanshisbig");
      }
      
      public function updateNum(param1:int) : void
      {
         var _loc2_:Bitmap = null;
         ObjectUtils.removeChildAllChildren(_numC);
         _loc2_ = ComponentFactory.Instance.creatBitmap("asset.groupbuy.num3");
         NumberViewUtils.getNumberView(param1,_numC,_loc2_.bitmapData,13,19,13,13,"0123456789",1);
         ObjectUtils.disposeObject(_loc2_);
         _loc2_ = null;
         _img2.x = _numC.x + _numC.width;
         w = 25 + _numC.width + _img2.width;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_numC);
         _numC = null;
         ObjectUtils.disposeObject(_img1);
         _img1 = null;
         ObjectUtils.disposeObject(_img2);
         _img2 = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

