package theseus.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class TheseusEquipPageView extends Sprite
   {
      
      private var _equipView:ThereussoulEquipView;
      
      private var _bagView:TheseusEquipBagView;
      
      public function TheseusEquipPageView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _equipView = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.ThereussoulEquipView");
         addChild(_equipView);
         _bagView = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.TheseusEquipBagView");
         addChild(_bagView);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_equipView);
         _equipView = null;
         ObjectUtils.disposeObject(_bagView);
         _bagView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

