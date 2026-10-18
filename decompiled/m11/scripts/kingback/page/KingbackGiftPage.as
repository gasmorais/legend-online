package kingback.page
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import kingback.item.KingbackGiftKindItem;
   import kingback.item.KingbackGiftKindRewardItem;
   import manager.LanguageMgr;
   import managers.KingbackManager;
   import mvc.module.kingback.KingbackInfo;
   import mvc.module.kingback.KingbackModel;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.base.HRollItemPanel;
   
   public class KingbackGiftPage extends Sprite
   {
      
      public var _giftReward:KingbackGiftKindRewardItem;
      
      public var _giftLimitTxt:FilterFrameText;
      
      public var _giftTimeTxt:FilterFrameText;
      
      public var _noSealFlg:Bitmap;
      
      public var _giftBuyBtn:IconButton;
      
      private var _itemList:Array = [];
      
      private var _currInfo:KingbackInfo;
      
      private var _rollPane:HRollItemPanel;
      
      public function KingbackGiftPage()
      {
         super();
         initView();
         initData();
         initEvent();
         defaultSelect();
      }
      
      private function initView() : void
      {
         _giftReward = ComponentFactory.Instance.creatCustomObject("ui.kingback.giftReward");
         _giftLimitTxt = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.giftLimitTxt");
         _giftTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.giftTimeTxt");
         _noSealFlg = ComponentFactory.Instance.creatBitmap("asset.kingback.noSealFlg");
         _giftBuyBtn = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.giftBuyBtn");
         _rollPane = ComponentFactory.Instance.creatCustomObject("kingback.gift.HRollItemPanel");
         _rollPane.initParams("ui.kingback.giftItemBox","ui.kingback.dayLeftBtn","ui.kingback.dayRightBtn",3,139,155,0);
         _rollPane.maskWd = 475;
         addChild(_giftReward);
         addChild(_giftLimitTxt);
         addChild(_giftTimeTxt);
         addChild(_noSealFlg);
         addChild(_giftBuyBtn);
         addChild(_rollPane);
      }
      
      private function initData() : void
      {
         var _loc1_:KingbackGiftKindItem = null;
         var _loc3_:int = 0;
         var _loc4_:Array = model.getInfoListByType(3);
         var _loc2_:int = int(_loc4_ ? _loc4_.length : 0);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new KingbackGiftKindItem();
            _loc1_.data = _loc4_[_loc3_];
            _itemList[_loc3_] = _loc1_;
            _loc3_++;
         }
         _rollPane.updateList(_itemList);
         setRemainTime();
      }
      
      private function defaultSelect() : void
      {
         var _loc1_:KingbackGiftKindItem = _itemList[0];
         _loc1_.selected = true;
         if(_loc1_)
         {
            _currInfo = _loc1_.data;
            _giftReward.data = _currInfo;
         }
         refreshView();
      }
      
      public function setRemainTime() : void
      {
         var _loc1_:Number = model.endTime / 1000 - playerModel.sysCurTimeBySecond;
         _giftTimeTxt.text = DateFormatter.getFullTimeString(_loc1_);
      }
      
      public function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:String = null;
         if(_currInfo)
         {
            _loc3_ = int(_currInfo.tempInfo.Param2);
            _loc2_ = _loc3_ - _currInfo.needCounts;
            _loc1_ = _loc2_ + "/" + _loc3_;
            _giftLimitTxt.text = LanguageMgr.GetTranslation("kingback.gift.limit",_loc1_);
            if(_loc2_ <= 0)
            {
               _noSealFlg.visible = true;
               _giftBuyBtn.visible = false;
            }
            else
            {
               _noSealFlg.visible = false;
               _giftBuyBtn.visible = true;
            }
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get model() : KingbackModel
      {
         return KingbackManager.instance.model;
      }
      
      private function initEvent() : void
      {
         _giftBuyBtn.addEventListener("click",buyHandler);
         for each(var _loc1_:KingbackGiftKindItem in _itemList)
         {
            _loc1_.addEventListener("click",itemClickHandler);
         }
      }
      
      private function removeEvent() : void
      {
         _giftBuyBtn.removeEventListener("click",buyHandler);
         for each(var _loc1_:KingbackGiftKindItem in _itemList)
         {
            _loc1_.removeEventListener("click",itemClickHandler);
         }
      }
      
      private function buyHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(PlayerManager.instance.currentPlayerModel.playerInfo.point >= _currInfo.tempInfo.Point)
         {
            _loc2_ = LanguageMgr.GetTranslation("kingback.gift.buyTip",_currInfo.tempInfo.Point);
            SimpleAlertHelper.instance.data = [realBuy];
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,_loc4_,true,true);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function realBuy(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            KingbackManager.instance.sendOp(_currInfo.templateId,1);
         }
      }
      
      private function itemClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:KingbackGiftKindItem = param1.currentTarget as KingbackGiftKindItem;
         _loc2_.selected = true;
         _currInfo = _loc2_.data;
         _giftReward.data = _currInfo;
         refreshView();
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:KingbackGiftKindItem in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeObject(_giftReward);
         _giftReward = null;
         ObjectUtils.disposeObject(_giftLimitTxt);
         _giftLimitTxt = null;
         ObjectUtils.disposeObject(_giftTimeTxt);
         _giftTimeTxt = null;
         ObjectUtils.disposeObject(_noSealFlg);
         _noSealFlg = null;
         ObjectUtils.disposeObject(_giftBuyBtn);
         _giftBuyBtn = null;
         ObjectUtils.disposeObject(_rollPane);
         _rollPane = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _currInfo = null;
      }
   }
}

