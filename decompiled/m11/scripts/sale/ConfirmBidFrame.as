package sale
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SaleManager;
   import mvc.module.sale.SaleData;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class ConfirmBidFrame extends Frame
   {
      
      private var _content:FilterFrameText;
      
      private var _iconBg:Image;
      
      private var _icon:BaseItemView;
      
      private var _smallPointImg:Bitmap;
      
      private var _numberInputBg:Image;
      
      private var _inputTxt:FilterFrameText;
      
      private var _confirmBtn:IconButton;
      
      private var _cancenBtn:IconButton;
      
      private var _itemName:FilterFrameText;
      
      private var _myBidPrice:FilterFrameText;
      
      private var _line:ScaleLeftRightImage;
      
      private var _contentValue:String;
      
      private var _openType:int;
      
      private var _callback:Function;
      
      private var _data:SaleData;
      
      public function ConfirmBidFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _iconBg = ComponentFactory.Instance.creatComponentByStylename("sale.iconBg");
         _icon = ComponentFactory.Instance.creatCustomObject("sale.saleGoodsBaseItemView");
         _content = ComponentFactory.Instance.creatComponentByStylename("ConfirmBidFrame.ConfirmSellContent");
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("sale.ConfirmSellInputTxt");
         _smallPointImg = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         _numberInputBg = ComponentFactory.Instance.creatComponentByStylename("sale.numberInputBg");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("sale.ConfirmBidBtn");
         _cancenBtn = ComponentFactory.Instance.creatComponentByStylename("sale.CancelBidBtn");
         _itemName = ComponentFactory.Instance.creatComponentByStylename("ConfirmBidFrame.itemName");
         _myBidPrice = ComponentFactory.Instance.creatComponentByStylename("ConfirmBidFrame.myBidPrice");
         _line = ComponentFactory.Instance.creatComponentByStylename("sale.line");
         _inputTxt.maxChars = 8;
         addToContent(_iconBg);
         addToContent(_icon);
         _icon.x = -15;
         _icon.y = -33;
         _iconBg.x = _icon.x - 2;
         _iconBg.y = _icon.y - 1;
         addToContent(_numberInputBg);
         addToContent(_content);
         addToContent(_inputTxt);
         addToContent(_line);
         addToContent(_smallPointImg);
         addToContent(_itemName);
         addToContent(_myBidPrice);
         addToContent(_confirmBtn);
         addToContent(_cancenBtn);
         _smallPointImg.x = 168;
         _smallPointImg.y = 72;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _inputTxt.addEventListener("keyDown",__inputEnterHandle);
         _confirmBtn.addEventListener("click",__confirmHandler);
         _cancenBtn.addEventListener("click",__cancelHandler);
      }
      
      private function removeEvent() : void
      {
         _inputTxt.removeEventListener("keyDown",__inputEnterHandle);
         removeEventListener("response",__frameResponseHandler);
         _confirmBtn.removeEventListener("click",__confirmHandler);
         _cancenBtn.removeEventListener("click",__cancelHandler);
      }
      
      private function __confirmHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:int = parseInt(_inputTxt.text);
         if(_openType == 2)
         {
            if(_data.fixPoint != 0)
            {
               _loc2_ = int(_data.fixPoint);
            }
         }
         else if(_openType == 1)
         {
            if(_data.fixPoint != 0 && _loc2_ >= _data.fixPoint)
            {
               _loc2_ = int(_data.fixPoint);
            }
            else if(_loc2_ < getLeastBidPrice())
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("ConfirmBidFrame.priceTooLow",getLeastBidPrice()));
               return;
            }
         }
         if(playerInfo.point < _loc2_)
         {
            RechargeAlertMannager.show();
            return;
         }
         SaleManager.instance.sendBid(_data.auctionId,_loc2_);
         dispose();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_callback != null)
         {
            _callback(false,true,_data);
            _callback = null;
         }
         dispose();
      }
      
      private function __inputEnterHandle(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __confirmHandler(null);
         }
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 2)
         {
            __confirmHandler(null);
         }
         else
         {
            __cancelHandler(null);
         }
      }
      
      private function refreshView() : void
      {
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.templateId);
         _itemName.text = _loc1_.TemplateName;
         if(_openType == 2)
         {
            _myBidPrice.visible = false;
            _smallPointImg.visible = false;
            _inputTxt.visible = false;
            _numberInputBg.visible = false;
            _content.y = 55;
            _content.htmlText = LanguageMgr.GetTranslation("ConfirmBidFrame.confirmBuy",_data.fixPoint,_loc1_.TemplateName);
         }
         else
         {
            _myBidPrice.text = LanguageMgr.GetTranslation("ConfirmBidFrame.myPrice");
            _inputTxt.text = getLeastBidPrice() + "";
            _inputTxt.setSelection(_inputTxt.text.length,_inputTxt.text.length);
            _content.y = 30;
            _content.htmlText = LanguageMgr.GetTranslation("ConfirmBidFrame.priceNotLessThan",getLeastBidPrice());
         }
         _content.height = _content.textHeight + 5;
         titleText = LanguageMgr.GetTranslation("public.prompt");
         StageReferance.stage.focus = _inputTxt;
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = _loc1_.TemplateId;
         _loc2_.count = _data.counts;
         _icon.data = _loc2_;
      }
      
      private function getLeastBidPrice() : int
      {
         var _loc1_:int = _data.currentPoint * 11;
         if(_loc1_ % 10 == 0)
         {
            return _loc1_ / 10;
         }
         return (_loc1_ - _loc1_ % 10) / 10 + 1;
      }
      
      public function show(param1:SaleData, param2:int, param3:Function) : void
      {
         _data = param1;
         _openType = param2;
         _callback = param3;
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
         refreshView();
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         _data = null;
         if(_callback != null)
         {
            _callback(false,false,_data);
         }
         _callback = null;
         removeEvent();
         ObjectUtils.disposeObject(_content);
         _content = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_inputTxt);
         _inputTxt = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         ObjectUtils.disposeObject(_cancenBtn);
         _cancenBtn = null;
         ObjectUtils.disposeObject(_itemName);
         _itemName = null;
         ObjectUtils.disposeObject(_myBidPrice);
         _myBidPrice = null;
         super.dispose();
      }
   }
}

