package monsterexplore.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.DemonLandDropTemplate;
   import yishi.view.community.BaseItemView;
   
   public class MonsterExploreBossRewardView extends Component
   {
      
      private var _data:Array;
      
      private var _bg:Scale9CornerImage;
      
      private var _list:SimpleTileList;
      
      private var _panel:ScrollPanel;
      
      private var _itemList:Vector.<BaseItemView>;
      
      public function MonsterExploreBossRewardView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.fallGoodsBG");
         _list = ComponentFactory.Instance.creatCustomObject("core.fallGoodsList",[5]);
         _panel = ComponentFactory.Instance.creatComponentByStylename("core.fallGoodsPanel");
         _panel.beginChanges();
         _panel.setView(_list);
         _panel.commitChanges();
         _panel.invalidateViewport();
         addChild(_bg);
         addChild(_panel);
         _itemList = new Vector.<BaseItemView>();
      }
      
      public function get data() : Array
      {
         return _data;
      }
      
      public function set data(param1:Array) : void
      {
         _data = param1;
         removeItems();
         initList();
         setPanelHeight();
      }
      
      private function setPanelHeight() : void
      {
         _panel.beginChanges();
         if(data.length > 5)
         {
            _bg.height = 127;
            _panel.height = 105;
         }
         else
         {
            _bg.height = 75;
            _panel.height = 50;
         }
         _panel.commitChanges();
         _panel.invalidateViewport();
         if(_panel.vScrollbar.visible)
         {
            _panel.x = 10;
         }
         else
         {
            _panel.x = 4;
         }
      }
      
      private function initList() : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc5_:GoodsInfo = null;
         var _loc6_:DemonLandDropTemplate = null;
         var _loc3_:int = int(data.length);
         if(_loc3_ > 5)
         {
            _loc2_ = _loc3_ > 10 ? 15 : 10;
         }
         else
         {
            _loc2_ = 5;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("core.fallGoods.BaseItemView");
            _itemList.push(_loc1_);
            _list.addChild(_loc1_);
            _loc5_ = new GoodsInfo();
            if(_loc4_ < _loc3_)
            {
               _loc6_ = data[_loc4_];
               _loc5_.templateId = _loc6_.ItemId;
               _loc5_.count = _loc6_.Count;
               _itemList[_loc4_].data = _loc5_;
            }
            _loc4_++;
         }
      }
      
      private function removeItems() : void
      {
         var _loc1_:BaseItemView = null;
         while(_itemList && _itemList.length > 0)
         {
            _loc1_ = _itemList.pop();
            _loc1_.dispose();
            _loc1_ = null;
         }
         if(_list)
         {
            _list.refreshChildPos();
         }
         if(_panel)
         {
            _panel.invalidateViewport();
         }
      }
      
      override public function dispose() : void
      {
         removeItems();
         _itemList = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(_panel)
         {
            ObjectUtils.disposeObject(_panel);
         }
         _panel = null;
         super.dispose();
      }
   }
}

