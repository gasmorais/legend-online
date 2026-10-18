package goddess.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.goddess.GoddessEquipInfo;
   
   public class GoddessBaseEquipView extends Component
   {
      
      protected var _data:GoddessEquipInfo;
      
      protected var _xihaoImage:MutipleImage;
      
      public var isSameData:Boolean;
      
      public function GoddessBaseEquipView()
      {
         super();
         _xihaoImage = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.xhaoBg");
         addChild(_xihaoImage);
      }
      
      public function get data() : GoddessEquipInfo
      {
         return _data;
      }
      
      public function set data(param1:GoddessEquipInfo) : void
      {
         if(_data == param1)
         {
            isSameData = true;
         }
         else
         {
            isSameData = false;
         }
         _data = param1;
      }
      
      public function updateView() : void
      {
         data = _data;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_xihaoImage);
         _xihaoImage = null;
         super.dispose();
         _data = null;
      }
   }
}

