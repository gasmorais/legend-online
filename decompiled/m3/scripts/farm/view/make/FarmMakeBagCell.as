package farm.view.make
{
   import cell.view.bag.BaseBagCell;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ComposeGoodsTemplete;
   import yishi.filter.UIFilter;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   
   public class FarmMakeBagCell extends BaseBagCell
   {
      
      private var _selectedBg:Bitmap;
      
      private var _selected:Boolean;
      
      public function FarmMakeBagCell()
      {
         super();
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         _selectedBg.visible = selected;
      }
      
      override public function set data(param1:GoodsInfo) : void
      {
         super.data = param1;
         if(data == null)
         {
            return;
         }
         checkGoodsCount();
      }
      
      private function checkGoodsCount() : void
      {
         var _loc2_:ComposeGoodsTemplete = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Dictionary = TempleteManager.instance.getComposeTempleteList();
         for each(var _loc6_:ComposeGoodsTemplete in _loc1_)
         {
            if(_loc6_.NewMaterial == data.templateId)
            {
               _loc2_ = _loc6_;
               break;
            }
         }
         this.filters = [];
         _loc4_ = 1;
         while(_loc4_ < 5)
         {
            _loc5_ = int(_loc2_["Material" + _loc4_]);
            _loc3_ = int(_loc2_["Count" + _loc4_]);
            if(_loc3_ > GoodsManager.instance.getGoodsNumByTempId(_loc5_))
            {
               this.filters = [UIFilter.getBlackFilter()];
               break;
            }
            _loc4_++;
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_selectedBg == null)
         {
            _selectedBg = ComponentFactory.Instance.creatBitmap("asset.farm.make.ComposeGoodsLightBg");
            _selectedBg.x = 2;
            _selectedBg.y = 3;
         }
         addChild(_selectedBg);
         _selectedBg.visible = false;
      }
   }
}

