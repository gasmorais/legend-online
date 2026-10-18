package dragontalker.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   
   public class DragonTalkerMainView extends Component
   {
      
      private var _bagView:DragonTalkerBagView;
      
      private var _equipView:DragonTalkerEquipView;
      
      public function DragonTalkerMainView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         this.mouseEnabled = false;
         _bagView = ComponentFactory.Instance.creatCustomObject("DragonTalker.vhua9.bagView");
         _equipView = ComponentFactory.Instance.creatCustomObject("DragonTalker.vhua9.equipView");
         addChild(_equipView);
         addChild(_bagView);
         _bagView.viewType = 1;
         _equipView.setFashionBtnVisible(true);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bagView);
         _bagView = null;
         ObjectUtils.disposeObject(_equipView);
         _equipView = null;
         super.dispose();
      }
   }
}

