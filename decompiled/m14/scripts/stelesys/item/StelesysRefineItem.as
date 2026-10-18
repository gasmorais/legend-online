package stelesys.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.utils.ObjectUtils;
   
   public class StelesysRefineItem extends StelesysNewRefineItem
   {
      
      private var _btn:SelectedButton;
      
      public function StelesysRefineItem()
      {
         super();
      }
      
      override protected function initView() : void
      {
         _protxt = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.refineMItemTxt");
         _mc = ComponentFactory.Instance.creatCustomObject("asset.stelesys.refineMc");
         _btn = ComponentFactory.Instance.creatComponentByStylename("stela.RefreshAttributeBtn");
         addChild(_protxt);
         addChild(_mc);
         addChild(_btn);
         _mc.mouseEnabled = false;
         _btn.selected = false;
      }
      
      public function get isLock() : Boolean
      {
         return _btn.selected;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         super.dispose();
      }
      
      public function resetLock() : void
      {
         _btn.selected = false;
      }
   }
}

