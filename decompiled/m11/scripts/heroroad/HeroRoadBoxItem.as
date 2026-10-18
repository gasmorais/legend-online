package heroroad
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.heroroad.HeroRoadInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.HeroRoadTemplateInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.HeroRoadManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class HeroRoadBoxItem extends Component
   {
      
      private var _data:HeroRoadInfo;
      
      private var _cardBoxImg:ScaleFrameImage;
      
      private var _cardItemBg:Image;
      
      private var _receiveBtn:IconButton;
      
      private var _buyBtn:IconButton;
      
      private var _template:HeroRoadTemplateInfo;
      
      private var _titleTxt:FilterFrameText;
      
      private var _priceTxt:FilterFrameText;
      
      private var _activeTxt:FilterFrameText;
      
      private var _diamondBg:Bitmap;
      
      private var _index:int;
      
      public function HeroRoadBoxItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _cardItemBg = ComponentFactory.Instance.creatComponentByStylename("heroroad.cardBoxItemBg");
         _cardBoxImg = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.cardBoxImg");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("heroroad.buyVipBtn");
         _receiveBtn = ComponentFactory.Instance.creatComponentByStylename("heroroad.receiveVipBtn");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("heroroad.HeroRoadBoxItem.titleTxt");
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("heroroad.HeroRoadBoxItem.priceTxt");
         _activeTxt = ComponentFactory.Instance.creatComponentByStylename("heroroad.HeroRoadBoxItem.activeTxt");
         _diamondBg = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         addChild(_cardItemBg);
         addChild(_cardBoxImg);
         addChild(_buyBtn);
         addChild(_receiveBtn);
         addChild(_titleTxt);
         addChild(_priceTxt);
         addChild(_activeTxt);
         addChild(_diamondBg);
         _diamondBg.x = 50;
         _diamondBg.y = 117;
         _cardBoxImg.buttonMode = true;
      }
      
      private function initEvent() : void
      {
         _cardBoxImg.addEventListener("click",__confirmHandler);
         _buyBtn.addEventListener("click",__buyHandler);
         _receiveBtn.addEventListener("click",__receiveHandler);
      }
      
      private function removeEvent() : void
      {
         _cardBoxImg.removeEventListener("click",__confirmHandler);
         _buyBtn.removeEventListener("click",__buyHandler);
         _receiveBtn.removeEventListener("click",__receiveHandler);
      }
      
      private function __confirmHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("heroroad",1,_data);
      }
      
      private function __receiveHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         HeroRoadManager.instance.operateHandler(HeroRoadManager.OP_TAKE_REWARD,_data.taskTempId);
      }
      
      private function __buyHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         SimpleAlertHelper.instance.data = [buyOperate];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("heroroad.HeroRoadItem.isBuy",_template.BuyNeedPoint);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false,2);
      }
      
      private function buyOperate(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(!_template || !_data)
            {
               return;
            }
            if(PlayerManager.instance.currentPlayerModel.playerInfo.point < _template.BuyNeedPoint)
            {
               RechargeAlertMannager.show();
               return;
            }
            HeroRoadManager.instance.operateHandler(HeroRoadManager.OP_BUYS_REWARD,_data.taskTempId);
         }
      }
      
      private function refreshView() : void
      {
         _priceTxt.visible = _data.buysItemsState == 1;
         _diamondBg.visible = _data.buysItemsState == 1;
         _buyBtn.visible = _data.buysItemsState == 1;
         _activeTxt.visible = _data.buysItemsState == 0;
         if(_data.masterType == HeroRoadManager.MASTER_DAY)
         {
            _receiveBtn.visible = _data.takeItemsState == 1 || _data.takeItemsState == 2;
            _receiveBtn.enable = _data.takeItemsState == 1;
         }
         else if(_data.masterType == HeroRoadManager.MASTER_VIP)
         {
            _receiveBtn.visible = false;
         }
         _priceTxt.text = String(_template.BuyNeedPoint);
         _activeTxt.htmlText = LanguageMgr.GetTranslation("heroroad.HeroRoadBoxItem.activeTxt",_template.Param1);
         var _loc1_:String = "";
         if((_template.MasterType == 6 || _template.MasterType == 7) && _template.QuestType == 2)
         {
            _loc1_ = LanguageMgr.GetTranslation("heroroad.HeroRoadItem.randomTypeTxt");
         }
         if(_template.SonType == 1000)
         {
            _titleTxt.text = LanguageMgr.GetTranslation("heroroad.HeroRoadItem.titleTxt1",_template.Param2,_loc1_);
            _cardBoxImg.tipData = LanguageMgr.GetTranslation("magicpub.HeroRoadItem.openRewards1",_template.Param2 - _data.takeNumbers,getTimeStr(_template.BuysItems.split("|")));
         }
         else if(_template.SonType == 1001)
         {
            _titleTxt.text = LanguageMgr.GetTranslation("heroroad.HeroRoadItem.titleTxt2",_template.Param2,_loc1_);
            _cardBoxImg.tipData = LanguageMgr.GetTranslation("magicpub.HeroRoadItem.openRewards2",getTimeStr(_template.BuysItems.split("|")));
         }
         _cardBoxImg.setFrame(_index);
      }
      
      private function getTimeStr(param1:Array) : String
      {
         var _loc2_:Array = null;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc4_:int = 0;
         var _loc5_:String = "";
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc2_ = String(param1[_loc4_]).split(",");
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_[0]);
            _loc5_ += _loc3_.TemplateName + "x" + _loc2_[1] + "  ";
            _loc4_++;
         }
         return _loc5_;
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
      }
      
      public function set data(param1:HeroRoadInfo) : void
      {
         _data = param1;
         _template = TempleteManager.instance.heroRoadTemplateCate.getTemplateByID(_data.taskTempId);
         refreshView();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_cardBoxImg);
         _cardBoxImg = null;
         ObjectUtils.disposeObject(_cardItemBg);
         _cardItemBg = null;
         ObjectUtils.disposeObject(_receiveBtn);
         _receiveBtn = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_priceTxt);
         _priceTxt = null;
         ObjectUtils.disposeObject(_activeTxt);
         _activeTxt = null;
         ObjectUtils.disposeObject(_diamondBg);
         _diamondBg = null;
         _data = null;
         _template = null;
         super.dispose();
      }
   }
}

