package stokesore
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class StokesOreDropItem extends Sprite implements Disposeable
   {
      
      private var _dropCell:BaseItemView;
      
      private var _data:GoodsInfo;
      
      public function StokesOreDropItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _dropCell = ComponentFactory.Instance.creatCustomObject("stokesOreDropItem.BottleDropItemCell");
         addChild(_dropCell);
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _dropCell.data = _data;
         }
      }
      
      public function get displayWidth() : int
      {
         return 40;
      }
      
      public function get displayHeight() : int
      {
         return 40;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_dropCell);
         _dropCell = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

