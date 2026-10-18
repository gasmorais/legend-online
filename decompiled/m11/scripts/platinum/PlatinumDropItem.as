package platinum
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class PlatinumDropItem extends Sprite implements Disposeable
   {
      
      private var _dropCell:BaseItemView;
      
      private var _dropName:FilterFrameText;
      
      private var _dropCount:FilterFrameText;
      
      private var _data:GoodsInfo;
      
      public function PlatinumDropItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _dropCell = ComponentFactory.Instance.creatCustomObject("bottle.BottleDropItemCell");
         _dropName = ComponentFactory.Instance.creatComponentByStylename("bottle.BottleDropItemName");
         _dropCount = ComponentFactory.Instance.creatComponentByStylename("bottle.BottleDropItemCount");
         addChild(_dropCell);
         addChild(_dropName);
         addChild(_dropCount);
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _dropCell.data = _data;
            _dropName.text = _data.templateInfo.TemplateName;
            _dropCount.text = "x" + _data.count;
            _dropName.setFrame(_data.templateInfo.Profile);
            _dropCount.setFrame(_data.templateInfo.Profile);
         }
      }
      
      public function get displayWidth() : int
      {
         return 180;
      }
      
      public function get displayHeight() : int
      {
         return 40;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_dropCell);
         _dropCell = null;
         ObjectUtils.disposeObject(_dropName);
         _dropName = null;
         ObjectUtils.disposeObject(_dropCount);
         _dropCount = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

