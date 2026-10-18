package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   
   public class DragonTalkerAttTipsItem extends Component
   {
      
      private var flagImg:Bitmap;
      
      private var propTxt:FilterFrameText;
      
      public function DragonTalkerAttTipsItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         flagImg = ComponentFactory.Instance.creatBitmap("asset.tips.attributeFlag");
         propTxt = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerAttTipsItem.propTxt");
         addChild(flagImg);
         addChild(propTxt);
         propTxt.x = 14;
      }
      
      public function setData(param1:String) : void
      {
         if(param1 == "")
         {
            flagImg.visible = false;
            return;
         }
         flagImg.visible = true;
         propTxt.htmlText = param1;
      }
      
      public function setDescWidth(param1:int) : void
      {
         propTxt.width = param1;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(flagImg);
         ObjectUtils.disposeObject(propTxt);
         super.dispose();
      }
   }
}

