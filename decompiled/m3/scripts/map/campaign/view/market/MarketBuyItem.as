package map.campaign.view.market
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class MarketBuyItem extends Component
   {
      
      private var _bg:MutipleImage;
      
      private var _name:FilterFrameText;
      
      private var _count:FilterFrameText;
      
      private var _price:FilterFrameText;
      
      private var _item:BaseItemView;
      
      private var _buyBtn:IconButton;
      
      public var pos:int;
      
      public var stallId:String;
      
      public var userId:int;
      
      public function MarketBuyItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("MarketBuyItem.bg");
         _name = ComponentFactory.Instance.creatComponentByStylename("MarketBuyItem.name");
         _count = ComponentFactory.Instance.creatComponentByStylename("MarketBuyItem.count");
         _price = ComponentFactory.Instance.creatComponentByStylename("MarketBuyItem.price");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("MarketBuyItem.buyBtn");
         _item = ComponentFactory.Instance.creatCustomObject("MarketBuyItem.item");
         addChild(_bg);
         addChild(_item);
         addChild(_name);
         addChild(_count);
         addChild(_price);
         addChild(_buyBtn);
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
         if(_count)
         {
            _count.dispose();
         }
         _count = null;
         if(_price)
         {
            _price.dispose();
         }
         _price = null;
         if(_buyBtn)
         {
            _buyBtn.dispose();
         }
         _buyBtn = null;
      }
      
      private function initEvent() : void
      {
         if(_buyBtn)
         {
            _buyBtn.addEventListener("click",__buyBtnHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",__buyBtnHandler);
         }
      }
      
      private function __buyBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:MarketBuyAlertFrame = null;
         if(_item && _item.data)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("market.MarketBuyAlertFrame");
            _loc2_.show(_item.data,userId,stallId);
         }
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         _item.data = param1;
         if(param1)
         {
            if(param1.petData)
            {
               _name.text = param1.petData.name;
            }
            else
            {
               _name.text = param1.templateInfo.TemplateName;
            }
            _count.text = param1.count + "";
            _price.text = param1.marketPrice + "";
            _name.setFrame(2);
            _buyBtn.enable = true;
         }
         else
         {
            _name.text = LanguageMgr.GetTranslation("market.MarketBuyItem.noGoodsName");
            _count.text = "";
            _price.text = "";
            _name.setFrame(1);
            _buyBtn.enable = false;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unitView();
         super.dispose();
      }
   }
}

