package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ArtifactEquipItem extends Sprite implements Disposeable
   {
      
      private var _flagImg:Bitmap;
      
      private var _attributeName:FilterFrameText;
      
      private var _attributeValue:FilterFrameText;
      
      public function ArtifactEquipItem()
      {
         super();
         _flagImg = ComponentFactory.Instance.creatBitmap("asset.tips.attributeFlag");
         _attributeName = ComponentFactory.Instance.creatComponentByStylename("tips.GoodAttackText");
         _attributeValue = ComponentFactory.Instance.creatComponentByStylename("tips.GoodAttackText");
         _attributeName.x = 14;
         _attributeValue.x = 50;
         _attributeName.width = 250;
         addChild(_flagImg);
         addChild(_attributeName);
         addChild(_attributeValue);
      }
      
      public function updateText(param1:String, param2:int) : void
      {
         _attributeName.text = param1 + param2.toString();
      }
      
      public function dispose() : void
      {
         if(_flagImg)
         {
            ObjectUtils.disposeObject(_flagImg);
         }
         _flagImg = null;
         if(_attributeName)
         {
            ObjectUtils.disposeObject(_attributeName);
         }
         _attributeName = null;
         if(_attributeValue)
         {
            ObjectUtils.disposeObject(_attributeValue);
         }
         _attributeValue = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

