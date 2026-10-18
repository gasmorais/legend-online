package consortia.view.newboss.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class NewBossDesItem extends Sprite
   {
      
      public var _t1:FilterFrameText;
      
      public var _t2:FilterFrameText;
      
      public function NewBossDesItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _t1 = ComponentFactory.Instance.creatComponentByStylename("ui.consortianewboss.t1");
         _t2 = ComponentFactory.Instance.creatComponentByStylename("ui.consortianewboss.t2");
         addChild(_t1);
         addChild(_t2);
      }
      
      public function refreshView(param1:String, param2:String) : void
      {
         _t1.text = param1;
         _t2.text = param2;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_t1);
         _t1 = null;
         ObjectUtils.disposeObject(_t2);
         _t2 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

