package dragontalker.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   
   public class DragonTalkerSymbioteView extends Component
   {
      
      private var _equipView:DragonTalkerEquipView;
      
      private var _bagView:DragonTalkerSymbioteBagView;
      
      public function DragonTalkerSymbioteView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         this.mouseEnabled = false;
         _equipView = ComponentFactory.Instance.creatCustomObject("DragonTalker.ppj0r.equipView");
         _bagView = ComponentFactory.Instance.creatCustomObject("DragonTalker.ppj0r.bagView");
         addChild(_equipView);
         addChild(_bagView);
         _equipView.setFashionBtnVisible(false);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_equipView);
         _equipView = null;
         ObjectUtils.disposeObject(_bagView);
         _bagView = null;
         super.dispose();
      }
   }
}

