package map.campaign.view.market
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.MarketModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.view.community.BaseItemView;
   
   public class MarketBuyAlertFrame extends Frame implements IManualSize
   {
      
      private var _bg:MutipleImage;
      
      private var _promiTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _priceTxt:FilterFrameText;
      
      private var _item:BaseItemView;
      
      private var _confirmBtn:IconButton;
      
      private var _data:GoodsInfo;
      
      private var _stallId:String;
      
      private var _userId:int;
      
      public function MarketBuyAlertFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,290,225);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("market.MarketBuyAlertFrame.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("MarketBuyAlertFrame.bg");
         _item = ComponentFactory.Instance.creatCustomObject("MarketBuyAlertFrame.item");
         _promiTxt = ComponentFactory.Instance.creatComponentByStylename("MarketBuyAlertFrame.promiTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("MarketBuyAlertFrame.nameTxt");
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("MarketBuyAlertFrame.priceTxt");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("MarketBuyAlertFrame.confirmBrn");
         addToContent(_bg);
         addToContent(_item);
         addToContent(_promiTxt);
         addToContent(_nameTxt);
         addToContent(_priceTxt);
         addToContent(_confirmBtn);
         _promiTxt.text = LanguageMgr.GetTranslation("market.MarketBuyAlertFrame.prompt");
      }
      
      private function unitView() : void
      {
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_promiTxt)
         {
            _promiTxt.dispose();
         }
         _promiTxt = null;
         if(_nameTxt)
         {
            _nameTxt.dispose();
         }
         _nameTxt = null;
         if(_priceTxt)
         {
            _priceTxt.dispose();
         }
         _priceTxt = null;
         if(_confirmBtn)
         {
            _confirmBtn.dispose();
         }
         _confirmBtn = null;
         if(_item)
         {
            _item.dispose();
         }
         _item = null;
         _data = null;
      }
      
      private function refreshView() : void
      {
         if(_data)
         {
            if(_data.petData)
            {
               _nameTxt.text = _data.petData.name;
            }
            else
            {
               _nameTxt.text = _data.templateInfo.TemplateName;
            }
            _priceTxt.text = LanguageMgr.GetTranslation("market.MarketBuyAlertFrame.priceTxt",_data.marketPrice);
            _item.data = _data;
            _confirmBtn.enable = true;
         }
         else
         {
            _nameTxt.text = "";
            _priceTxt.text = "";
            _item.data = null;
            _confirmBtn.enable = false;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         if(_confirmBtn)
         {
            _confirmBtn.addEventListener("click",__confirmHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_confirmBtn)
         {
            _confirmBtn.removeEventListener("click",__confirmHandler);
         }
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
      
      private function __confirmHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            if(playerInfo.point < _data.marketPrice)
            {
               RechargeAlertMannager.show();
               dispose();
               return;
            }
            model.buyGoods(_userId,_stallId,_data.pos,_data.count);
         }
         dispose();
      }
      
      private function get model() : MarketModel
      {
         return CampaignManager.instance.marketModel;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function show(param1:GoodsInfo, param2:int, param3:String) : void
      {
         _data = param1;
         _userId = param2;
         _stallId = param3;
         refreshView();
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unitView();
         super.dispose();
      }
   }
}

