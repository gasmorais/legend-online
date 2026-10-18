package remainsexplore
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import mvc.module.remainsexplore.RemainsExploreModel;
   import yishi.manager.RemainsExploreManager;
   
   public class RemainsExploreAreaItem extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _txtImg:Bitmap;
      
      private var _hBox:HBox;
      
      private var _index:int;
      
      private const NUM:int = 3;
      
      public function RemainsExploreAreaItem(param1:int)
      {
         super();
         _index = param1;
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.RemainsExploreAreaItem.bg" + _index);
         _txtImg = ComponentFactory.Instance.creatBitmap("asset.RemainsExploreAreaItem.txt" + _index);
         _hBox = ComponentFactory.Instance.creatComponentByStylename("remainsExploreAreaItem.hBox");
         addChild(_bg);
         addChild(_txtImg);
         addChild(_hBox);
         initItem();
      }
      
      private function initItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:RemainsExploreNodeItem = null;
         _hBox.removeAllChild();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new RemainsExploreNodeItem(_index,_loc2_ + 1);
            _hBox.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function get model() : RemainsExploreModel
      {
         return RemainsExploreManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_txtImg);
         _txtImg = null;
         ObjectUtils.disposeAllChildren(_hBox);
         _hBox = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

