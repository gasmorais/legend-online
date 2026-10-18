package monster.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   
   public class MonsterCallDropAreaView extends Component
   {
      
      private var _materialImage:Image;
      
      public function MonsterCallDropAreaView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _materialImage = ComponentFactory.Instance.creatComponentByStylename("MonsterCallFrame.materialImage");
         addChild(_materialImage);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_materialImage);
         _materialImage = null;
         super.dispose();
      }
   }
}

