package royaltyboss
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   
   public class RoyaltyPropertyItem extends Component
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _icon:Bitmap;
      
      private var _txt:FilterFrameText;
      
      public function RoyaltyPropertyItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("royaltyPropertyItem.bg");
         _icon = ComponentFactory.Instance.creatBitmap("asset.RoyaltyPropertyItem.icon");
         _txt = ComponentFactory.Instance.creatComponentByStylename("royaltyPropertyItem.txt");
         addChild(_bg);
         addChild(_icon);
         addChild(_txt);
         _bg.setFrame(1);
      }
      
      public function set txt(param1:String) : void
      {
         _txt.text = param1;
      }
      
      public function set frame(param1:int) : void
      {
         _bg.setFrame(param1);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

