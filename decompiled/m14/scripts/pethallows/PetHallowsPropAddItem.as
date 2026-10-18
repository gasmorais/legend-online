package pethallows
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   
   public class PetHallowsPropAddItem extends Component
   {
      
      private var ballImage:ScaleFrameImage;
      
      private var propText:FilterFrameText;
      
      private var addImage:Image;
      
      private var addValueText:FilterFrameText;
      
      private var _data:Object;
      
      public function PetHallowsPropAddItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         ballImage = ComponentFactory.Instance.creatComponentByStylename("PetHallowsPropAddItem.ballImage");
         propText = ComponentFactory.Instance.creatComponentByStylename("PetHallowsPropAddItem.propText");
         addImage = ComponentFactory.Instance.creatComponentByStylename("PetHallowsPropAddItem.addImage");
         addValueText = ComponentFactory.Instance.creatComponentByStylename("PetHallowsPropAddItem.addValueText");
         addChild(ballImage);
         addChild(propText);
         addChild(addImage);
         addChild(addValueText);
      }
      
      public function set data(param1:Object) : void
      {
         _data = param1;
         if(!_data)
         {
            return;
         }
         _data.selected ? ballImage.setFrame(2) : ballImage.setFrame(1);
         propText.text = LanguageMgr.GetTranslation("PetContracAddTips.addPropText" + _data.type) + ":" + _data.propData;
         if(_data.selected && _data.addValue > 0)
         {
            addValueText.text = _data.addValue + "";
            addImage.x = propText.x + propText.textWidth + 4;
            addValueText.x = addImage.x + addImage.width + 2;
            addImage.visible = true;
         }
         else
         {
            addValueText.text = "";
            addImage.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(ballImage);
         ballImage = null;
         ObjectUtils.disposeObject(propText);
         propText = null;
         ObjectUtils.disposeObject(addImage);
         addImage = null;
         ObjectUtils.disposeObject(addValueText);
         addValueText = null;
         super.dispose();
      }
   }
}

