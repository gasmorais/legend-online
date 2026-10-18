package map.campaign.view.market
{
   import cell.mediator.marketbag.MarketItemCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   
   public class MarketSellItem extends Component
   {
      
      private var _bg:MutipleImage;
      
      private var _name:FilterFrameText;
      
      private var _price:FilterFrameText;
      
      private var _item:MarketItemCell;
      
      public function MarketSellItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("MarketSellItem.bg");
         _name = ComponentFactory.Instance.creatComponentByStylename("MarketSellItem.name");
         _price = ComponentFactory.Instance.creatComponentByStylename("MarketSellItem.price");
         _item = ComponentFactory.Instance.creatCustomObject("MarketBagListView.cell");
         addChild(_bg);
         addChild(_item);
         addChild(_name);
         addChild(_price);
         _item.celltType = "SELL_TYPE";
         _item.lock = false;
         data = null;
      }
      
      private function unitView() : void
      {
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_name)
         {
            _name.dispose();
         }
         _name = null;
         if(_price)
         {
            _price.dispose();
         }
         _price = null;
      }
      
      public function set pos(param1:int) : void
      {
         if(_item)
         {
            _item.pos = param1;
         }
      }
      
      public function get data() : GoodsInfo
      {
         if(_item)
         {
            return _item.data;
         }
         return null;
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         _item.data = param1;
         if(param1)
         {
            _name.setFrame(2);
            if(param1.petData)
            {
               _name.text = param1.petData.name;
            }
            else
            {
               _name.text = param1.templateInfo.TemplateName;
            }
            _price.text = param1.marketPrice + "";
         }
         else
         {
            _name.setFrame(1);
            _name.text = LanguageMgr.GetTranslation("view.market.MarketSellItem.defaultName");
            _price.text = "";
         }
      }
      
      override public function dispose() : void
      {
         unitView();
         super.dispose();
      }
   }
}

