package llk.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.LlkManager;
   import mvc.module.llk.LlkModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class LlkGoodsItem extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _goodsIcon:ScaleFrameImage;
      
      private var _goodsName:FilterFrameText;
      
      private var _goodsCount:FilterFrameText;
      
      private var _useBtn:IconButton;
      
      private var _buyBtn:IconButton;
      
      private var _type:int;
      
      private var _bomoPoint:int;
      
      private var _resetPoint:int;
      
      public function LlkGoodsItem()
      {
         super();
         initData();
         initView();
         initEvent();
      }
      
      private function initData() : void
      {
         var _loc1_:ConfigInfosTempInfo = null;
         _bomoPoint = 10;
         _resetPoint = 10;
         _loc1_ = TempleteManager.instance.getConfigInfoByConfigName("linkgame_bomb_need");
         if(_loc1_ && parseInt(_loc1_.ConfigValue))
         {
            _bomoPoint = parseInt(_loc1_.ConfigValue);
         }
         _loc1_ = TempleteManager.instance.getConfigInfoByConfigName("linkgame_reset_need");
         if(_loc1_ && parseInt(_loc1_.ConfigValue))
         {
            _resetPoint = parseInt(_loc1_.ConfigValue);
         }
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.llk.LlkGoodsItemBg");
         _goodsIcon = ComponentFactory.Instance.creatComponentByStylename("LlkGoodsItem.goodsIcon");
         _goodsName = ComponentFactory.Instance.creatComponentByStylename("LlkGoodsItem.goodsName");
         _goodsCount = ComponentFactory.Instance.creatComponentByStylename("LlkGoodsItem.goodsCount");
         _useBtn = ComponentFactory.Instance.creatComponentByStylename("LlkGoodsItem.useBtn");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("LlkGoodsItem.buyBtn");
         addChild(_bg);
         addChild(_goodsIcon);
         addChild(_goodsName);
         addChild(_goodsCount);
         addChild(_useBtn);
         addChild(_buyBtn);
      }
      
      public function refresh() : void
      {
         if(_type == 1)
         {
            if(_goodsIcon)
            {
               _goodsIcon.setFrame(1);
            }
            if(_goodsName)
            {
               _goodsName.text = LanguageMgr.GetTranslation("llk.view.LlkGoodsItem.GoodsName1");
            }
            if(_goodsCount)
            {
               _goodsCount.text = "x" + model.info.bombCount;
            }
         }
         else if(_type == 2)
         {
            if(_goodsIcon)
            {
               _goodsIcon.setFrame(2);
            }
            if(_goodsName)
            {
               _goodsName.text = LanguageMgr.GetTranslation("llk.view.LlkGoodsItem.GoodsName2");
            }
            if(_goodsCount)
            {
               _goodsCount.text = "x" + model.info.resetCount;
            }
         }
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
         refresh();
      }
      
      private function initEvent() : void
      {
         if(_useBtn)
         {
            _useBtn.addEventListener("click",__useClickHandler);
         }
         if(_buyBtn)
         {
            _buyBtn.addEventListener("click",__buyClickHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_useBtn)
         {
            _useBtn.removeEventListener("click",__useClickHandler);
         }
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",__buyClickHandler);
         }
      }
      
      private function __useClickHandler(param1:MouseEvent) : void
      {
         if(_type == 1)
         {
            if(model.info.bombCount <= 0)
            {
               __buyClickHandler(null);
            }
            else if(isNullMap)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("llk.view.LlkGoodsItem.gateNotStart"));
            }
            else
            {
               LlkManager.llkOp(2);
            }
         }
         else if(_type == 2)
         {
            if(model.info.resetCount <= 0)
            {
               __buyClickHandler(null);
            }
            else if(isNullMap)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("llk.view.LlkGoodsItem.gateNotStart"));
            }
            else
            {
               LlkManager.llkOp(3);
            }
         }
      }
      
      private function __buyClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:String = null;
         var _loc2_:String = null;
         var _loc5_:TodayNotAlertFrame = null;
         var _loc3_:Boolean = false;
         if(_type == 1)
         {
            _loc3_ = Boolean(SharedManager.instance.llkBuyBombAlert);
            if(!_loc3_)
            {
               _loc5_ = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopRefreshAlertFrame");
               _loc4_ = LanguageMgr.GetTranslation("llk.view.LlkGoodsItem.buyBombTips",_bomoPoint);
               _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
               _loc5_.show(_loc4_,_loc2_,buyAlertBack,null,"center");
            }
            else
            {
               buyAlertBack(true,SharedManager.instance.llkBuyBombUseBind);
            }
         }
         else if(_type == 2)
         {
            _loc3_ = Boolean(SharedManager.instance.llkBuyResetAlert);
            if(!_loc3_)
            {
               _loc5_ = ComponentFactory.Instance.creatComponentByStylename("auction.MysteryShopRefreshAlertFrame");
               _loc4_ = LanguageMgr.GetTranslation("llk.view.LlkGoodsItem.buyResetTips",_resetPoint);
               _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
               _loc5_.show(_loc4_,_loc2_,buyAlertBack,null,"center");
            }
            else
            {
               buyAlertBack(true,SharedManager.instance.llkBuyResetUseBind);
            }
         }
      }
      
      private function buyAlertBack(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         if(param2)
         {
            _loc3_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
         }
         if(_type == 1)
         {
            if(_loc3_ < _bomoPoint)
            {
               RechargeAlertMannager.show();
               return;
            }
            SharedManager.instance.llkBuyBombAlert = param1;
            if(param1)
            {
               SharedManager.instance.llkBuyBombUseBind = param2;
            }
            LlkManager.llkBuy(6,param2);
         }
         else if(_type == 2)
         {
            if(_loc3_ < _resetPoint)
            {
               RechargeAlertMannager.show();
               return;
            }
            SharedManager.instance.llkBuyResetAlert = param1;
            if(param1)
            {
               SharedManager.instance.llkBuyResetUseBind = param2;
            }
            LlkManager.llkBuy(7,param2);
         }
      }
      
      private function get isNullMap() : Boolean
      {
         var _loc3_:int = 0;
         if(StringHelper.isNullOrEmpty(model.info.points))
         {
            return true;
         }
         var _loc1_:Array = [];
         var _loc2_:Boolean = true;
         _loc1_ = model.info.points.split(",");
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            if(_loc1_[_loc3_] != 0)
            {
               _loc2_ = false;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function get model() : LlkModel
      {
         return LlkManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_goodsIcon);
         _goodsIcon = null;
         ObjectUtils.disposeObject(_goodsName);
         _goodsName = null;
         ObjectUtils.disposeObject(_goodsCount);
         _goodsCount = null;
         ObjectUtils.disposeObject(_useBtn);
         _useBtn = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

