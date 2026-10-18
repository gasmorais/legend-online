package yishi.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.BingoManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.tips.MessageTipManager;
   
   public class BingoBuyFrame extends Frame
   {
      
      protected var _selfBack:MutipleImage;
      
      protected var _selfSelectBtn:SelectedIconButton;
      
      protected var _goods:Component;
      
      protected var _rankBmp:Image;
      
      protected var _priceTxt:FilterFrameText;
      
      protected var _nameTxt:FilterFrameText;
      
      protected var _addBtn:BaseButton;
      
      protected var _deleteBtn:BaseButton;
      
      protected var _selfConfirmBtn:IconButton;
      
      protected var _buyNumTxt:FilterFrameText;
      
      protected var _buyImage:ScaleFrameImage;
      
      protected var _data:*;
      
      protected var _buyNum:int = 1;
      
      protected var _cardAsset:BitmapData;
      
      protected var _luckNote:Bitmap;
      
      protected var _luckNumTxt1:FilterFrameText;
      
      protected var _luckNumTxt2:FilterFrameText;
      
      public function BingoBuyFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _selfBack = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BingoBuyFrameBack");
         _selfSelectBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.SelfSelectedBackBtn");
         _rankBmp = ComponentFactory.Instance.creatComponentByStylename("quickbuy.bingoBuy.rankNumBmp");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyGoodsNameStyle");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.AddButton");
         _deleteBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.DeleteButton");
         _selfConfirmBtn = ComponentFactory.Instance.creatComponentByStylename("quickbuy.selfConfirmBtn");
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("quickbuy.TotalPriceTextStyle");
         _buyNumTxt = ComponentFactory.Instance.creatComponentByStylename("quickbuy.BuyNumTextStyle");
         _buyImage = ComponentFactory.Instance.creatComponentByStylename("quickbuy.ShopPayType");
         _cardAsset = ComponentFactory.Instance.creatBitmapData("asset.shop.rankNumAsset");
         _luckNote = ComponentFactory.Instance.creatBitmap("asset.shop.luckNumBmp");
         _luckNumTxt1 = ComponentFactory.Instance.creatComponentByStylename("quickbuy.LuckNumTextStyle1");
         _luckNumTxt2 = ComponentFactory.Instance.creatComponentByStylename("quickbuy.LuckNumTextStyle2");
         _goods = new Component();
         addToContent(_selfBack);
         addToContent(_selfSelectBtn);
         addToContent(_rankBmp);
         addToContent(_goods);
         addToContent(_nameTxt);
         addToContent(_addBtn);
         addToContent(_deleteBtn);
         addToContent(_selfConfirmBtn);
         addToContent(_priceTxt);
         addToContent(_buyNumTxt);
         addToContent(_buyImage);
         addToContent(_luckNote);
         addToContent(_luckNumTxt1);
         addToContent(_luckNumTxt2);
         _selfConfirmBtn.x = 82;
         _buyImage.setFrame(1);
         titleText = LanguageMgr.GetTranslation("campaign.TrailShop.BuyBtnTxt");
         _selfSelectBtn.selected = true;
         _luckNumTxt1.text = "1";
         _luckNumTxt2.text = "1";
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _selfConfirmBtn.addEventListener("click",__confirmHandler);
         _addBtn.addEventListener("click",__addHandler);
         _deleteBtn.addEventListener("click",__deleteHandler);
         _buyNumTxt.addEventListener("change",__buyNumChange);
         _buyNumTxt.addEventListener("keyDown",__onKeydownHandler);
         _luckNumTxt1.addEventListener("change",__luckNumChange);
         _luckNumTxt2.addEventListener("change",__luckNumChange);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _selfConfirmBtn.removeEventListener("click",__confirmHandler);
         _addBtn.removeEventListener("click",__addHandler);
         _deleteBtn.removeEventListener("click",__deleteHandler);
         _buyNumTxt.removeEventListener("change",__buyNumChange);
         _buyNumTxt.removeEventListener("keyDown",__onKeydownHandler);
         _luckNumTxt1.removeEventListener("change",__luckNumChange);
         _luckNumTxt2.removeEventListener("change",__luckNumChange);
      }
      
      private function __onKeydownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __confirmHandler(null);
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
               __confirmHandler(null);
         }
      }
      
      public function data(param1:*, param2:int = 1, param3:Object = null) : void
      {
         _data = param1;
         _buyNum = param2;
         refreshView();
         buyNumChangeHandler();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
         KeyBoardRegister.instance.keyEnable = false;
         StageReferance.stage.focus = _buyNumTxt;
      }
      
      protected function __confirmHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_data)
         {
            _selfConfirmBtn.enable = true;
            if(int(_priceTxt.text) > PayMoney)
            {
               RechargeAlertMannager.show();
               dispose();
               return;
            }
            if(_luckNumTxt1.text == _luckNumTxt2.text)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("bingo.BingoBuyFrame.sameLuckNum"));
               return;
            }
            if(_selfSelectBtn.selected)
            {
               buy();
            }
         }
      }
      
      private function buy() : void
      {
         var _loc1_:String = _luckNumTxt1.text + "," + _luckNumTxt2.text;
         BingoManager.instance.OperateBingo(1,_data.cardId,_buyNum,_loc1_);
         dispose();
      }
      
      protected function refreshView() : void
      {
         if(!_data)
         {
            return;
         }
         _selfSelectBtn.x = 102;
         var _loc1_:int = int(_data.cardId);
         NumberViewUtils.refreshValue(_loc1_,_goods,_cardAsset,21,29,18,21,"0123456789");
         _goods.x = _rankBmp.x + (_rankBmp.width - _goods.displayWidth) / 2 - 2;
         _goods.y = 65;
         _nameTxt.text = LanguageMgr.GetTranslation("view.GoodsItem10.titleTxt",_data.cardId);
      }
      
      protected function buyNumChangeHandler() : void
      {
         var _loc1_:int = int(ConfigInfoManager.instance.getBingoBuy()[0]);
         var _loc2_:int = int(ConfigInfoManager.instance.getBingoBuy()[1]);
         var _loc3_:int = _loc2_ - 0;
         if(_loc3_ < _buyNum)
         {
            _buyNum = _loc3_;
         }
         _buyNum = _buyNum < 1 ? 1 : _buyNum;
         _buyNum = _buyNum > 9999 ? 9999 : _buyNum;
         _buyNumTxt.text = _buyNum.toString();
         _priceTxt.text = _loc1_ * _buyNum + "";
         if(int(_priceTxt.text) > PayMoney)
         {
            _priceTxt.setFrame(2);
         }
         else
         {
            _priceTxt.setFrame(1);
         }
         _buyNum <= 1 ? (_deleteBtn.enable = false) : (_deleteBtn.enable = true);
         _buyNum >= 9999 ? (_addBtn.enable = false) : (_addBtn.enable = true);
         if(_buyNum >= _loc3_)
         {
            _addBtn.enable = false;
         }
         _buyImage.x = _priceTxt.x + _priceTxt.textWidth + 5;
      }
      
      private function __addHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _buyNum = _buyNum + 1;
         buyNumChangeHandler();
      }
      
      private function __deleteHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _buyNum = _buyNum - 1;
         buyNumChangeHandler();
      }
      
      private function __buyNumChange(param1:Event) : void
      {
         _buyNum = int(_buyNumTxt.text);
         buyNumChangeHandler();
      }
      
      private function __luckNumChange(param1:Event) : void
      {
         var _loc3_:int = int(_luckNumTxt1.text);
         var _loc2_:int = int(_luckNumTxt2.text);
         _loc3_ = int(_loc3_ < 1 ? 1 : _loc3_);
         _loc3_ = int(_loc3_ > 75 ? 75 : _loc3_);
         _luckNumTxt1.text = _loc3_.toString();
         _loc2_ = int(_loc2_ < 1 ? 1 : _loc2_);
         _loc2_ = int(_loc2_ > 75 ? 75 : _loc2_);
         _luckNumTxt2.text = _loc2_.toString();
      }
      
      public function get PayMoney() : int
      {
         return playerInfo.point;
      }
      
      protected function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_selfBack);
         _selfBack = null;
         super.dispose();
      }
   }
}

