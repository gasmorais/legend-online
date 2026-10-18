package mounts
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.CustomBitmap;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   
   public class MountsPromotionItemView extends Component
   {
      
      private var _type:int = 0;
      
      private var _propertyImg:CustomBitmap;
      
      private var _oldTxt:FilterFrameText;
      
      private var _propertyImg2:CustomBitmap;
      
      private var _newTxt:FilterFrameText;
      
      private var _addTxt:FilterFrameText;
      
      private var _upArrow:CustomBitmap;
      
      public function MountsPromotionItemView(param1:int = 1)
      {
         super();
         _type = param1;
         initView();
         addEvent();
      }
      
      protected function initView() : void
      {
         var _loc2_:String = null;
         switch(_type - 1)
         {
            case 0:
               _loc2_ = "asset.mounts.StrengthTxt";
               break;
            case 1:
               _loc2_ = "asset.mounts.IntellectTxt";
               break;
            case 2:
               _loc2_ = "asset.mounts.StaminaTxt";
               break;
            case 3:
               _loc2_ = "asset.mounts.ArmorTxt";
               break;
            default:
               _loc2_ = "asset.mounts.ArmorTxt";
         }
         var _loc1_:BitmapData = ClassUtils.CreatInstance(_loc2_);
         _propertyImg = ComponentFactory.Instance.creatCustomObject("mountsPromotionItemView.propertyImg");
         _propertyImg2 = ComponentFactory.Instance.creatCustomObject("mountsPromotionItemView.propertyImg2");
         _propertyImg.bitmapData = _propertyImg2.bitmapData = _loc1_;
         addChild(_propertyImg);
         addChild(_propertyImg2);
         _oldTxt = ComponentFactory.Instance.creatComponentByStylename("mountsPromotionItemView.oldTxt");
         _newTxt = ComponentFactory.Instance.creatComponentByStylename("mountsPromotionItemView.newTxt");
         addChild(_oldTxt);
         addChild(_newTxt);
         _addTxt = ComponentFactory.Instance.creatComponentByStylename("mountsPromotionItemView.addTxt");
         _upArrow = ComponentFactory.Instance.creatCustomObject("mountsPromotionItemView.upArrow");
         addChild(_addTxt);
         addChild(_upArrow);
         _oldTxt.text = "+9999";
         _newTxt.text = "+19999";
         _addTxt.text = "200";
         _addTxt.x = _newTxt.x + _newTxt.textWidth + 35;
         _upArrow.x = _addTxt.x + _addTxt.textWidth + 3;
      }
      
      protected function uintView() : void
      {
         ObjectUtils.disposeObject(_oldTxt);
         _oldTxt = null;
         ObjectUtils.disposeObject(_newTxt);
         _newTxt = null;
         ObjectUtils.disposeObject(_propertyImg);
         _propertyImg = null;
         ObjectUtils.disposeObject(_propertyImg2);
         _propertyImg2 = null;
      }
      
      protected function addEvent() : void
      {
      }
      
      protected function removeEvent() : void
      {
      }
      
      public function update(param1:int, param2:int, param3:int = 0, param4:Boolean = false) : void
      {
         _oldTxt.text = "+" + param1;
         _newTxt.text = "+" + param2;
         if(param3 != 0)
         {
            _addTxt.text = param3.toString();
            _addTxt.x = _newTxt.x + _newTxt.textWidth + 35;
            _upArrow.x = _addTxt.x + _addTxt.textWidth + 3;
            _addTxt.visible = true;
            _upArrow.visible = true;
         }
         else
         {
            _addTxt.visible = false;
            _upArrow.visible = false;
         }
         if(param4)
         {
            _propertyImg2.visible = false;
            _newTxt.visible = false;
         }
         else
         {
            _propertyImg2.visible = true;
            _newTxt.visible = true;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
      }
   }
}

