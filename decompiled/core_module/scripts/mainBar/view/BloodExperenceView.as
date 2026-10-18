package mainBar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import flash.display.Shape;
   import mvc.module.armyII.UserArmy;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class BloodExperenceView extends Component
   {
      
      public static const BLOOD_MAX:int = 1000000;
      
      private var _bloodBtn:BaseButton;
      
      private var _mask:Shape;
      
      private var _maskBegin_y:int;
      
      private var _hitArea:Shape;
      
      private var _data:UserArmy;
      
      private var _percent:Number;
      
      public function BloodExperenceView()
      {
         super();
         initView();
         buttonMode = true;
      }
      
      private function initView() : void
      {
         _bloodBtn = ComponentFactory.Instance.creatComponentByStylename("resourcesBar.QuickBuyBtn");
         addChild(_bloodBtn);
         _mask = createShape();
         addChild(_mask);
         _hitArea = createShape();
         addChild(_hitArea);
         _bloodBtn.mask = _mask;
      }
      
      private function createShape() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(_bloodBtn.x,_bloodBtn.y,_bloodBtn.width,_bloodBtn.height);
         _loc1_.graphics.endFill();
         _maskBegin_y = _bloodBtn.height;
         return _loc1_;
      }
      
      private function refreshView() : void
      {
         if(_data)
         {
            _percent = currentThane.blood / 1000000;
            if(_percent > 1)
            {
               _percent = 1;
            }
            _mask.y = _maskBegin_y - _mask.height * _percent;
         }
         else
         {
            _percent = 0;
            _mask.y = _maskBegin_y - _mask.height * _percent;
         }
      }
      
      private function get currentThane() : ThaneInfo
      {
         return _data.baseHero;
      }
      
      public function set data(param1:UserArmy) : void
      {
         _data = param1;
         refreshView();
      }
   }
}

