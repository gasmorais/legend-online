package map.campaign.view.market
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.MarketModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   
   public class MarketBagFrame extends Frame implements IManualSize
   {
      
      private var _listView:MarketBagListView;
      
      private var _bg:Scale9CornerImage;
      
      private var _btn1:SelectedIconButton;
      
      private var _btn2:SelectedIconButton;
      
      private var _btn3:SelectedIconButton;
      
      private var _btn4:SelectedIconButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _sellFrame:MarketSellFrame;
      
      public function MarketBagFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,820,530);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("Auction.BagTitle");
         _bg = ComponentFactory.Instance.creatComponentByStylename("MarketBagFrame.bg");
         _btn1 = ComponentFactory.Instance.creatComponentByStylename("MarketBagFrame.btn1");
         _btn2 = ComponentFactory.Instance.creatComponentByStylename("MarketBagFrame.btn2");
         _btn3 = ComponentFactory.Instance.creatComponentByStylename("MarketBagFrame.btn3");
         _btn4 = ComponentFactory.Instance.creatComponentByStylename("MarketBagFrame.btn4");
         _sellFrame = ComponentFactory.Instance.creatComponentByStylename("market.MarketSellFrame",[1]);
         _sellFrame.refreshView();
         _btnGroup = new SelectedButtonGroup();
         _listView = new MarketBagListView();
         _listView.x = 7;
         _listView.y = 40;
         addChild(_sellFrame);
         addToContent(_bg);
         addToContent(_btn1);
         addToContent(_btn2);
         addToContent(_btn3);
         addToContent(_btn4);
         addToContent(_listView);
         _btnGroup.addSelectItem(_btn1);
         _btnGroup.addSelectItem(_btn2);
         _btnGroup.addSelectItem(_btn3);
         _btnGroup.addSelectItem(_btn4);
         _btnGroup.selectIndex = 0;
      }
      
      private function unitView() : void
      {
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_btn1)
         {
            _btn1.dispose();
         }
         _btn1 = null;
         if(_btn2)
         {
            _btn2.dispose();
         }
         _btn2 = null;
         if(_btn3)
         {
            _btn3.dispose();
         }
         _btn3 = null;
         if(_btn4)
         {
            _btn4.dispose();
         }
         _btn4 = null;
         if(_sellFrame)
         {
            _sellFrame.dispose();
         }
         _sellFrame = null;
         if(_listView)
         {
            _listView.dispose();
         }
         _listView = null;
         _btnGroup = null;
      }
      
      private function __selectedHandler(param1:Event) : void
      {
         _listView.gotoPage(_btnGroup.selectIndex);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         if(_btnGroup)
         {
            _btnGroup.addEventListener("change",__selectedHandler);
         }
         MsgMan.addObserver("CampaignEvent.MARKET_OPBACK",this,__opbackHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__selectedHandler);
         }
         MsgMan.removeObserver("CampaignEvent.MARKET_OPBACK",this,__opbackHandler);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               model.endSell();
               dispose();
         }
      }
      
      private function __opbackHandler(param1:String, param2:Object) : void
      {
         if(param2 && param2.userId == playerInfo.userId && param2.isSuccess)
         {
            switch(param2.type)
            {
               case 1:
               case 2:
               case 3:
               case 4:
               case 6:
               case 8:
                  if(_sellFrame)
                  {
                     _sellFrame.refreshView();
                  }
                  break;
               case 5:
                  dispose();
                  _sellFrame = ComponentFactory.Instance.creatComponentByStylename("market.MarketSellFrame",[2]);
                  _sellFrame.refreshView();
                  LayerManager.Instance.addToLayer(_sellFrame,3,true,true);
                  break;
               case 7:
                  dispose();
            }
         }
      }
      
      override public function set x(param1:Number) : void
      {
         super.x = param1 + 430;
         if(_sellFrame)
         {
            _sellFrame.x = -430;
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : MarketModel
      {
         return CampaignManager.instance.marketModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unitView();
         super.dispose();
      }
   }
}

