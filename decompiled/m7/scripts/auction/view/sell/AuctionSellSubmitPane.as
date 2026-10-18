package auction.view.sell
{
   import auction.view.AuctionAlert;
   import auction.view.common.TimeLimitButton;
   import bag.events.BagEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import manager.LanguageMgr;
   import mediator.AuctionMessageSender;
   import mvc.module.auction.SellItemVO;
   import mvc.module.pet.PetData;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.GoodsManager;
   import yishi.utils.StringUtil;
   
   public class AuctionSellSubmitPane extends Sprite implements Disposeable
   {
      
      private var _border:DisplayObject;
      
      private var _back:DisplayObject;
      
      private var _topLeftFlag:DisplayObject;
      
      private var _startBtn:BaseButton;
      
      private var _topTipTxt:FilterFrameText;
      
      private var _itemNameTxt:FilterFrameText;
      
      private var _priceTxt1:TextInput;
      
      private var _priceTxt2:TextInput;
      
      private var _carryingCostTxt:FilterFrameText;
      
      private var _timeLimitBtn1:TimeLimitButton;
      
      private var _timeLimitBtn2:TimeLimitButton;
      
      private var _timeLimitBtn3:TimeLimitButton;
      
      private var _group:SelectedButtonGroup;
      
      private var _goldIcon:Bitmap;
      
      private var _corner2:DisplayObject;
      
      private var _goodCell:AuctionSellTargetCell;
      
      private var _blinkMc:MovieClip;
      
      private var _recordData:SellItemVO;
      
      public function AuctionSellSubmitPane()
      {
         super();
         initView();
         addHandler();
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("auction.sell.sellBack");
         addChild(_border);
         _back = ComponentFactory.Instance.creatCustomObject("auction.sellSubmitBack");
         addChild(_back);
         _topLeftFlag = ComponentFactory.Instance.creatBitmap("asset.auction.sellLeftFlag");
         addChild(_topLeftFlag);
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("auction.startAuctionBtn");
         addChild(_startBtn);
         _topTipTxt = ComponentFactory.Instance.creatComponentByStylename("auction.sellSubmitTopTipTxt");
         _itemNameTxt = ComponentFactory.Instance.creatComponentByStylename("auction.sellSubmitItemNameTxt");
         _priceTxt1 = ComponentFactory.Instance.creatComponentByStylename("auction.sellSubmitPriceTxt1");
         _priceTxt2 = ComponentFactory.Instance.creatComponentByStylename("auction.sellSubmitPriceTxt2");
         _carryingCostTxt = ComponentFactory.Instance.creatComponentByStylename("auction.sellSubmitCarryingCostTxt");
         _timeLimitBtn1 = ComponentFactory.Instance.creatComponentByStylename("auction.sellTimeLimitBtn1");
         _timeLimitBtn2 = ComponentFactory.Instance.creatComponentByStylename("auction.sellTimeLimitBtn2");
         _timeLimitBtn3 = ComponentFactory.Instance.creatComponentByStylename("auction.sellTimeLimitBtn3");
         _goldIcon = ComponentFactory.Instance.creatBitmap("asset.auction.goldIcon");
         _goodCell = ComponentFactory.Instance.creatCustomObject("auction.sellTargetCell");
         _blinkMc = ClassUtils.CreatInstance("asset.auction.blinkIcon");
         _blinkMc.x = 9;
         _blinkMc.y = 63;
         addChild(_topTipTxt);
         addChild(_itemNameTxt);
         addChild(_priceTxt1);
         addChild(_priceTxt2);
         addChild(_carryingCostTxt);
         addChild(_timeLimitBtn1);
         addChild(_timeLimitBtn2);
         addChild(_timeLimitBtn3);
         addChild(_goldIcon);
         addChild(_blinkMc);
         addChild(_goodCell);
         _topTipTxt.text = LanguageMgr.GetTranslation("Auction.SubmitTopTip");
         _itemNameTxt.text = "";
         _priceTxt1.text = "";
         _priceTxt1.maxChars = 9;
         _priceTxt1.textField.restrict = "0-9";
         _priceTxt2.text = "";
         _priceTxt2.maxChars = 9;
         _priceTxt2.textField.restrict = "0-9";
         _priceTxt1.enable = _priceTxt2.enable = false;
         _timeLimitBtn1.setText(LanguageMgr.GetTranslation("Auction.SubmitHour1"));
         _timeLimitBtn2.setText(LanguageMgr.GetTranslation("Auction.SubmitHour2"));
         _timeLimitBtn3.setText(LanguageMgr.GetTranslation("Auction.SubmitHour3"));
         _corner2 = ComponentFactory.Instance.creatComponentByStylename("auction.sellCorner2");
         addChild(_corner2);
         _group = new SelectedButtonGroup();
         _group.addSelectItem(_timeLimitBtn1);
         _group.addSelectItem(_timeLimitBtn2);
         _group.addSelectItem(_timeLimitBtn3);
         _group.selectIndex = 0;
         updateCarryingCost();
      }
      
      private function addHandler() : void
      {
         _startBtn.addEventListener("click",onSellBtnClick);
         _goodCell.addEventListener("change",onDataChange);
         _group.addEventListener("change",onHourChange);
         _priceTxt1.textField.addEventListener("change",__correctFirstZero);
         _priceTxt2.textField.addEventListener("change",__correctFirstZero);
      }
      
      private function updateCarryingCost() : void
      {
         _carryingCostTxt.text = 250 * getSelectTime() + "";
      }
      
      private function onSellBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         SoundManager.instance.play("022");
         if(!_goodCell.data)
         {
            AuctionAlert.alert(LanguageMgr.GetTranslation("public.prompt"),LanguageMgr.GetTranslation("Auction.SubmitAlert1"));
            return;
         }
         if(StringUtil.trim(_priceTxt1.text) == "")
         {
            AuctionAlert.alert(LanguageMgr.GetTranslation("public.prompt"),LanguageMgr.GetTranslation("Auction.SubmitAlert6"));
            return;
         }
         var _loc5_:int = int(_priceTxt1.text);
         if(_loc5_ < 2)
         {
            AuctionAlert.alert(LanguageMgr.GetTranslation("public.prompt"),LanguageMgr.GetTranslation("Auction.SubmitAlert2"));
            return;
         }
         _loc2_ = int(_goodCell.data.templateInfo.StartingPrice);
         _loc3_ = int(_goodCell.data.willSellCount);
         if(_loc5_ < _loc2_ * _loc3_)
         {
            AuctionAlert.alert(LanguageMgr.GetTranslation("public.prompt"),LanguageMgr.GetTranslation("Auction.SubmitAlert5"));
            calPriceTxt1(_loc2_,_loc3_);
            return;
         }
         var _loc6_:int = int(_priceTxt2.text);
         if(_loc6_ < 1)
         {
            AuctionAlert.alert(LanguageMgr.GetTranslation("public.prompt"),LanguageMgr.GetTranslation("Auction.SubmitAlert3"));
            return;
         }
         if(_loc6_ <= _loc5_)
         {
            AuctionAlert.alert(LanguageMgr.GetTranslation("public.prompt"),LanguageMgr.GetTranslation("Auction.SubmitAlert4"));
            return;
         }
         var _loc4_:SellItemVO = new SellItemVO();
         if(_goodCell.data.petData)
         {
            if((_goodCell.data.petData as PetData).isRemote)
            {
               AuctionAlert.alert(LanguageMgr.GetTranslation("public.prompt"),LanguageMgr.GetTranslation("pet.inRemotePet4"));
               return;
            }
            _loc4_.itemPos = (_goodCell.data.petData as PetData).petId;
            _loc4_.itemType = 2;
         }
         else
         {
            _loc4_.itemId = _goodCell.data.id;
            _loc4_.itemPos = _goodCell.data.pos;
            _loc4_.itemType = 1;
            _loc4_.bagType = _goodCell.data.bagType;
         }
         if(_goodCell.data.willSellCount)
         {
            _loc4_.count = _goodCell.data.willSellCount;
         }
         else
         {
            _loc4_.count = _goodCell.data.count;
         }
         _loc4_.point = _loc5_;
         _loc4_.fixPoint = _loc6_;
         _loc4_.hour = getSelectTime();
         _loc4_.templateId = _goodCell.data.templateId;
         AuctionGoodMoveControl.storeTargetData();
         AuctionMessageSender.sendSellItemMessage(_loc4_);
         recordData(_loc4_);
         _goodCell.data.willSellCount = 0;
      }
      
      private function recordData(param1:SellItemVO) : void
      {
         _recordData = null;
         _recordData = param1;
      }
      
      private function getSelectTime() : int
      {
         if(_group.selectIndex == 0)
         {
            return 8;
         }
         if(_group.selectIndex == 1)
         {
            return 24;
         }
         return 48;
      }
      
      private function onDataChange(param1:Event) : void
      {
         var _loc2_:PetData = null;
         if(_goodCell.data)
         {
            if(_goodCell.data.petData)
            {
               _loc2_ = _goodCell.data.petData as PetData;
               _itemNameTxt.text = _loc2_.template.TemplateName;
            }
            else
            {
               _itemNameTxt.text = _goodCell.data.templateInfo.TemplateName;
            }
            calPriceTxt1(_goodCell.data.templateInfo.StartingPrice,_goodCell.data.count);
            _priceTxt1.enable = _priceTxt2.enable = true;
         }
         else
         {
            _itemNameTxt.text = "";
            _priceTxt1.text = "";
            _priceTxt2.text = "";
            _priceTxt1.enable = _priceTxt2.enable = false;
         }
         if(_itemNameTxt.numLines == 1)
         {
            _itemNameTxt.y = 85;
         }
         else if(_itemNameTxt.numLines == 2)
         {
            _itemNameTxt.y = 85;
         }
         else if(_itemNameTxt.numLines == 3)
         {
            _itemNameTxt.y = 80;
         }
         else
         {
            _itemNameTxt.y = 70;
         }
      }
      
      private function __correctFirstZero(param1:Event) : void
      {
         var _loc2_:TextField = param1.currentTarget as TextField;
         if(_loc2_.text.charAt(0) == "0")
         {
            _loc2_.text = int(_loc2_.text).toString();
         }
      }
      
      public function setPriceNull() : void
      {
         _priceTxt1.text = "";
         _priceTxt2.text = "";
      }
      
      private function calPriceTxt1(param1:int, param2:int) : void
      {
         if(param1 * param2 < 2)
         {
            _priceTxt1.text = "2";
         }
         else
         {
            _priceTxt1.text = param1 * param2 + "";
         }
      }
      
      public function checkData() : void
      {
         var _loc1_:GoodsInfo = _goodCell.data;
         if(_loc1_.petData)
         {
            checkForPet(_loc1_.petData);
         }
         else
         {
            checkForNormalGoods();
         }
      }
      
      private function checkForPet(param1:PetData) : void
      {
         var _loc2_:int = int(_goodCell.data.templateInfo.StartingPrice);
         calPriceTxt1(_loc2_,1);
         _priceTxt2.text = "";
      }
      
      private function checkForNormalGoods() : void
      {
         var _loc1_:int = 1;
         var _loc2_:int = 1;
         if(!_recordData)
         {
            if(_goodCell.data.willSellCount)
            {
               _loc1_ = int(_goodCell.data.templateInfo.StartingPrice);
               _loc2_ = int(_goodCell.data.willSellCount);
            }
            else
            {
               _loc1_ = int(_goodCell.data.templateInfo.StartingPrice);
               _loc2_ = int(_goodCell.data.count);
            }
            calPriceTxt1(_loc1_,_loc2_);
         }
         else if(_goodCell.data.templateId == _recordData.templateId && _goodCell.data.count == _recordData.count || _goodCell.data.templateId == _recordData.templateId && _goodCell.data.willSellCount && _goodCell.data.willSellCount == _recordData.count)
         {
            _priceTxt1.text = _recordData.point.toString();
            _priceTxt2.text = _recordData.fixPoint.toString();
         }
         else
         {
            if(_goodCell.data.willSellCount)
            {
               calPriceTxt1(_goodCell.data.templateInfo.StartingPrice,_goodCell.data.willSellCount);
            }
            else
            {
               calPriceTxt1(_goodCell.data.templateInfo.StartingPrice,_goodCell.data.count);
            }
            _priceTxt2.text = "";
         }
      }
      
      private function onHourChange(param1:Event) : void
      {
         SoundManager.instance.play("022");
         updateCarryingCost();
      }
      
      public function getCellItem() : InteractiveObject
      {
         return _goodCell;
      }
      
      public function getGoodCell() : AuctionSellTargetCell
      {
         return _goodCell;
      }
      
      public function dispose() : void
      {
         if(_goodCell.data)
         {
            GoodsManager.instance.dispatchEvent(new BagEvent("RETURN_REFRESH",null));
         }
         _goodCell.removeEventListener("change",onDataChange);
         _startBtn.removeEventListener("click",onSellBtnClick);
         _group.removeEventListener("change",onHourChange);
         _priceTxt1.textField.removeEventListener("change",__correctFirstZero);
         _priceTxt2.textField.removeEventListener("change",__correctFirstZero);
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_topLeftFlag);
         _topLeftFlag = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         ObjectUtils.disposeObject(_topTipTxt);
         _topTipTxt = null;
         ObjectUtils.disposeObject(_itemNameTxt);
         _itemNameTxt = null;
         ObjectUtils.disposeObject(_priceTxt1);
         _priceTxt1 = null;
         ObjectUtils.disposeObject(_priceTxt2);
         _priceTxt2 = null;
         ObjectUtils.disposeObject(_carryingCostTxt);
         _carryingCostTxt = null;
         ObjectUtils.disposeObject(_timeLimitBtn1);
         _timeLimitBtn1 = null;
         ObjectUtils.disposeObject(_timeLimitBtn2);
         _timeLimitBtn2 = null;
         ObjectUtils.disposeObject(_timeLimitBtn3);
         _timeLimitBtn3 = null;
         ObjectUtils.disposeObject(_group);
         _group = null;
         ObjectUtils.disposeObject(_goldIcon);
         _goldIcon = null;
         ObjectUtils.disposeObject(_corner2);
         _corner2 = null;
         ObjectUtils.disposeObject(_goodCell);
         _goodCell = null;
         ObjectUtils.disposeObject(_blinkMc);
         _blinkMc = null;
         if(parent)
         {
            parent.removeChild(_blinkMc);
         }
      }
      
      public function playBlink() : void
      {
         _blinkMc.gotoAndPlay(1);
      }
      
      public function stopBlink() : void
      {
         _blinkMc.gotoAndStop(1);
      }
   }
}

