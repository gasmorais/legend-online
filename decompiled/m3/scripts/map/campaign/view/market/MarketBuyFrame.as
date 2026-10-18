package map.campaign.view.market
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import map.campaign.data.StallInfo;
   import yishi.utils.MsgMan;
   
   public class MarketBuyFrame extends Frame implements IManualSize
   {
      
      private var _bg:MutipleImage;
      
      private var _goodsSp:Sprite;
      
      private var _itemList:Vector.<MarketBuyItem>;
      
      private var _data:StallInfo;
      
      public function MarketBuyFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,425,460);
      }
      
      override public function get groups() : Array
      {
         return ["BAG_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("MarketBuyFrame.bg");
         _goodsSp = new Sprite();
         _itemList = new Vector.<MarketBuyItem>();
         addToContent(_bg);
         addToContent(_goodsSp);
         _goodsSp.x = _goodsSp.y = 5;
         addGoods();
      }
      
      private function unitView() : void
      {
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         ObjectUtils.disposeAllChildren(_goodsSp);
         _goodsSp = null;
         _itemList = null;
      }
      
      private function addGoods() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 12)
         {
            _itemList[_loc1_] = new MarketBuyItem();
            _itemList[_loc1_].pos = _loc1_;
            _itemList[_loc1_].x = _loc1_ % 2 * 195;
            _itemList[_loc1_].y = int(_loc1_ / 2) * 60;
            _goodsSp.addChild(_itemList[_loc1_]);
            _loc1_++;
         }
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         if(isDie)
         {
            return;
         }
         titleText = _data.name;
         _loc1_ = 0;
         while(_loc1_ < 12)
         {
            _itemList[_loc1_].data = _data.items[_loc1_];
            _itemList[_loc1_].stallId = _data.stallId;
            _itemList[_loc1_].userId = _data.userId;
            _loc1_++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         MsgMan.addObserver("CampaignEvent.MARKET_OPBACK",this,__opbackHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         MsgMan.removeObserver("CampaignEvent.MARKET_OPBACK",this,__opbackHandler);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __opbackHandler(param1:String, param2:Object) : void
      {
         if(param2)
         {
            switch(param2.type)
            {
               case 3:
               case 6:
                  refreshView();
                  break;
               case 1:
               case 2:
               case 4:
               case 5:
               case 7:
               case 8:
                  dispose();
            }
         }
      }
      
      public function set data(param1:StallInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unitView();
         super.dispose();
      }
   }
}

