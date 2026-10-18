package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class PetAttributeItemView extends Sprite implements Disposeable
   {
      
      private var _flagImg:Bitmap;
      
      private var _descTxt:FilterFrameText;
      
      public function PetAttributeItemView()
      {
         super();
         _flagImg = ComponentFactory.Instance.creatBitmap("asset.tips.attributeFlag");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("tips.PetAttributeView.desctxt");
         addChild(_flagImg);
         addChild(_descTxt);
      }
      
      public function setData(param1:String, param2:int = 1) : void
      {
         _descTxt.text = param1;
         _descTxt.setFrame(param2);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_flagImg);
         _flagImg = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
      }
   }
}

