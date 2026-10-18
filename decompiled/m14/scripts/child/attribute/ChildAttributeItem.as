package child.attribute
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   
   public class ChildAttributeItem extends Component
   {
      
      private var _index:int;
      
      private var _bmp:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _addBtn:BaseButton;
      
      private var _reduceBtn:BaseButton;
      
      public function ChildAttributeItem()
      {
         super();
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
         refreahView();
      }
      
      private function refreahView() : void
      {
         _bmp = ComponentFactory.Instance.creatBitmap("asset.child.ChildAttributeItem.imageTxt" + _index);
         _txt = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.txt");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeItem.addBtn");
         _reduceBtn = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeItem.reduceBtn");
         addChild(_bmp);
         addChild(_txt);
         addChild(_addBtn);
         addChild(_reduceBtn);
         _txt.x = 80;
         _txt.setFrame(3);
      }
      
      public function get text() : FilterFrameText
      {
         return _txt;
      }
      
      public function get addBtn() : BaseButton
      {
         return _addBtn;
      }
      
      public function get reduceBtn() : BaseButton
      {
         return _reduceBtn;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bmp);
         _bmp = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_addBtn);
         _addBtn = null;
         ObjectUtils.disposeObject(_reduceBtn);
         _reduceBtn = null;
         super.dispose();
      }
   }
}

