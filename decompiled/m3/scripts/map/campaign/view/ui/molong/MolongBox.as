package map.campaign.view.ui.molong
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   
   public class MolongBox extends Component
   {
      
      private var _index:int;
      
      public function MolongBox(param1:int, param2:int = 2201)
      {
         _index = param1;
         super();
         addBoxes();
         this.buttonMode = true;
      }
      
      public function get indexBox() : int
      {
         return _index;
      }
      
      private function addBoxes() : void
      {
         var _loc1_:DisplayObject = ComponentFactory.Instance.creat("asset.molong.money");
         var _loc2_:DisplayObject = ComponentFactory.Instance.creat("asset.molong.moneyMC");
         this.addChild(_loc1_);
         this.addChild(_loc2_);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

