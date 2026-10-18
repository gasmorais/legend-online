package cell.mediator.marketbag
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.MarketModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   
   public class MarketSellAlertFrame extends Frame implements IManualSize
   {
      
      private var _bg:MutipleImage;
      
      private var _numTxt:FilterFrameText;
      
      private var _priceTxt:FilterFrameText;
      
      private var _addBtn:BaseButton;
      
      private var _reduceBtn:BaseButton;
      
      private var _confirmBtn:IconButton;
      
      private var _cancleBtn:IconButton;
      
      private var _data:GoodsInfo;
      
      private var _num:int;
      
      private var _price:int;
      
      private var _targetPos:int;
      
      public function MarketSellAlertFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,375,250);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("armyII.ArmyFrameII.sell");
         _bg = ComponentFactory.Instance.creatComponentByStylename("MarketSellAlertFrame.bg");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("MarketSellAlertFrame.numTxt");
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("MarketSellAlertFrame.priceTxt");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("MarketSellAlertFrame.addBtn");
         _reduceBtn = ComponentFactory.Instance.creatComponentByStylename("MarketSellAlertFrame.reduceBtn");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("MarketSellAlertFrame.confirmBtn");
         _cancleBtn = ComponentFactory.Instance.creatComponentByStylename("MarketSellAlertFrame.cancleBtn");
         addToContent(_bg);
         addToContent(_numTxt);
         addToContent(_priceTxt);
         addToContent(_addBtn);
         addToContent(_reduceBtn);
         addToContent(_confirmBtn);
         addToContent(_cancleBtn);
      }
      
      private function unitView() : void
      {
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_numTxt)
         {
            _numTxt.dispose();
         }
         _numTxt = null;
         if(_priceTxt)
         {
            _priceTxt.dispose();
         }
         _priceTxt = null;
         if(_addBtn)
         {
            _addBtn.dispose();
         }
         _addBtn = null;
         if(_reduceBtn)
         {
            _reduceBtn.dispose();
         }
         _reduceBtn = null;
         if(_confirmBtn)
         {
            _confirmBtn.dispose();
         }
         _confirmBtn = null;
         if(_cancleBtn)
         {
            _cancleBtn.dispose();
         }
         _cancleBtn = null;
      }
      
      private function __numHandler(param1:Event) : void
      {
         _num = parseInt(_numTxt.text);
         if(_num > _data.count)
         {
            _num = _data.count;
         }
         if(_num < 1)
         {
            _num = 1;
         }
         _numTxt.text = _num + "";
         setEnable();
      }
      
      private function __priceHandler(param1:Event) : void
      {
         _price = parseInt(_priceTxt.text);
         if(_price > 9999999)
         {
            _price = 9999999;
         }
         if(_price < _data.templateInfo.StartingPrice * _num)
         {
            _price = _data.templateInfo.StartingPrice * _num;
         }
         if(_price < 2)
         {
            _price = 2;
         }
         _priceTxt.text = _price + "";
      }
      
      private function __addBtnHandler(param1:MouseEvent) : void
      {
         if(_data.petData == null && _num < _data.count)
         {
            _num += 1;
            _numTxt.text = _num + "";
            setEnable();
         }
      }
      
      private function __reduceBtnHandler(param1:MouseEvent) : void
      {
         if(_data.petData == null && _num > 1)
         {
            _num -= 1;
            _numTxt.text = _num + "";
            setEnable();
         }
      }
      
      private function __confirmBtnHandler(param1:MouseEvent) : void
      {
         if(_data.petData == null)
         {
            if(_targetPos >= 0 && _num > 0 && _num <= _data.count && _price > 0)
            {
               model.marketGoodsToSell(_data.pos,_targetPos,_num,_price);
            }
         }
         else
         {
            model.marketPetToSell(_data.petData.petId,_targetPos,_price);
         }
         dispose();
      }
      
      private function __cancleBtnHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         if(_numTxt)
         {
            _numTxt.addEventListener("change",__numHandler);
         }
         if(_priceTxt)
         {
            _priceTxt.addEventListener("change",__priceHandler);
         }
         if(_addBtn)
         {
            _addBtn.addEventListener("click",__addBtnHandler);
         }
         if(_reduceBtn)
         {
            _reduceBtn.addEventListener("click",__reduceBtnHandler);
         }
         if(_confirmBtn)
         {
            _confirmBtn.addEventListener("click",__confirmBtnHandler);
         }
         if(_cancleBtn)
         {
            _cancleBtn.addEventListener("click",__cancleBtnHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_numTxt)
         {
            _numTxt.removeEventListener("change",__numHandler);
         }
         if(_priceTxt)
         {
            _priceTxt.removeEventListener("change",__priceHandler);
         }
         if(_addBtn)
         {
            _addBtn.removeEventListener("click",__addBtnHandler);
         }
         if(_reduceBtn)
         {
            _reduceBtn.removeEventListener("click",__reduceBtnHandler);
         }
         if(_confirmBtn)
         {
            _confirmBtn.removeEventListener("click",__confirmBtnHandler);
         }
         if(_cancleBtn)
         {
            _cancleBtn.removeEventListener("click",__cancleBtnHandler);
         }
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function refreshView() : void
      {
         if(_data && !isDie)
         {
            _num = _data.count;
            _price = _data.templateInfo.StartingPrice * _num;
            _price = _price > 2 ? _price : 2;
            _numTxt.text = _num + "";
            _priceTxt.text = _price + "";
            setEnable();
         }
      }
      
      private function setEnable() : void
      {
         if(!isDie)
         {
            _addBtn.enable = _num < _data.count;
            _reduceBtn.enable = _num > 1;
         }
      }
      
      public function show(param1:GoodsInfo, param2:int) : void
      {
         _data = param1;
         _targetPos = param2;
         refreshView();
         LayerManager.Instance.addToLayer(this,3,true,true,1);
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

