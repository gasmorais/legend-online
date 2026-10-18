package heroroad
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.heroroad.HeroRoadInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.HeroRoadTemplateInfo;
   import yishi.manager.HeroRoadManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   
   public class HeroRoadItem extends Component
   {
      
      private var _data:HeroRoadInfo;
      
      private var _cardItemBg:Bitmap;
      
      private var _descriptTxt:FilterFrameText;
      
      private var _taskNoteTxt:FilterFrameText;
      
      private var _rewardTxt:FilterFrameText;
      
      private var _receiveBtn:IconButton;
      
      private var _priceTxt:FilterFrameText;
      
      private var _pointImg:Image;
      
      private var _buyBtn:IconButton;
      
      private var _template:HeroRoadTemplateInfo;
      
      private var _icon1:BaseIconView;
      
      private var _icon2:BaseIconView;
      
      public function HeroRoadItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _cardItemBg = ComponentFactory.Instance.creatBitmap("asset.heroroad.cardItemBg");
         _descriptTxt = ComponentFactory.Instance.creatComponentByStylename("heroroad.descriptTxt");
         _rewardTxt = ComponentFactory.Instance.creatComponentByStylename("heroroad.rewardTxt");
         _taskNoteTxt = ComponentFactory.Instance.creatComponentByStylename("heroroad.HeroRoadItem.taskNoteTxt");
         _receiveBtn = ComponentFactory.Instance.creatComponentByStylename("heroroad.receiveNormalBtn");
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("heroroad.HeroRoadItem.priceTxt");
         _pointImg = ComponentFactory.Instance.creatComponentByStylename("heroroad.HeroRoadItem.SmallPointImg");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("heroroad.buyNormalBtn");
         _icon1 = ComponentFactory.Instance.creatCustomObject("heroroad.HeroRoadItemIcon1");
         _icon2 = ComponentFactory.Instance.creatCustomObject("heroroad.HeroRoadItemIcon2");
         addChild(_cardItemBg);
         addChild(_descriptTxt);
         addChild(_rewardTxt);
         addChild(_taskNoteTxt);
         addChild(_receiveBtn);
         addChild(_priceTxt);
         addChild(_pointImg);
         addChild(_buyBtn);
         addChild(_icon1);
         addChild(_icon2);
         _taskNoteTxt.text = LanguageMgr.GetTranslation("heroroad.HeroRoadItem.taskNoteTxt");
      }
      
      private function initEvent() : void
      {
         _receiveBtn.addEventListener("click",__receiveHandler);
         _buyBtn.addEventListener("click",__buyHandler);
      }
      
      private function removeEvent() : void
      {
         _receiveBtn.removeEventListener("click",__receiveHandler);
         _buyBtn.removeEventListener("click",__buyHandler);
      }
      
      public function set data(param1:HeroRoadInfo) : void
      {
         _data = param1;
         _template = TempleteManager.instance.heroRoadTemplateCate.getTemplateByID(_data.taskTempId);
         _descriptTxt.text = _template.Describe;
         _priceTxt.text = _template.BuyNeedPoint.toString();
         _rewardTxt.text = LanguageMgr.GetTranslation("heroroad.HeroRoadItem.rewardTxt",_template.HeroRoadScore);
         _icon1.icon = IconFactory.getCommonIconPath(_template.TakeItemsIcon);
         _icon1.tipData = LanguageMgr.GetTranslation("magicpub.HeroRoadItem.openRewards2",getTimeStr(_template.TakeItems.split("|")));
         _buyBtn.enable = _data.buysItemsState == 1;
         _receiveBtn.enable = _data.takeItemsState == 1;
         if(_template.BuysItems == "0" || _data.buysItemsState == 2)
         {
            _icon2.icon = null;
            _icon2.tipData = null;
            _buyBtn.visible = false;
            _pointImg.visible = false;
            _priceTxt.visible = false;
         }
         else
         {
            _icon2.icon = IconFactory.getCommonIconPath(_template.BuysItemsIcon);
            _icon2.tipData = LanguageMgr.GetTranslation("magicpub.HeroRoadItem.openRewards2",getTimeStr(_template.BuysItems.split("|")));
            _buyBtn.visible = true;
            _pointImg.visible = true;
            _priceTxt.visible = true;
         }
      }
      
      private function __receiveHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_template.BuysItems == "0" || _data.buysItemsState == 2)
         {
            receiveOperate(true,false);
            return;
         }
         SimpleAlertHelper.instance.data = [receiveOperate];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("heroroad.HeroRoadItem.isReceive");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false,2);
      }
      
      private function receiveOperate(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(!_data)
            {
               return;
            }
            HeroRoadManager.instance.operateHandler(HeroRoadManager.OP_TAKE_REWARD,_data.taskTempId);
         }
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
            if(PlayerManager.instance.currentPlayerModel.playerInfo.point < _template.BuyNeedPoint)
            {
               RechargeAlertMannager.show();
               return;
            }
            HeroRoadManager.instance.operateHandler(HeroRoadManager.OP_BUYS_REWARD,_data.taskTempId);
         }
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
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_cardItemBg);
         _cardItemBg = null;
         ObjectUtils.disposeObject(_descriptTxt);
         _descriptTxt = null;
         ObjectUtils.disposeObject(_rewardTxt);
         _rewardTxt = null;
         ObjectUtils.disposeObject(_taskNoteTxt);
         _taskNoteTxt = null;
         ObjectUtils.disposeObject(_receiveBtn);
         _receiveBtn = null;
         ObjectUtils.disposeObject(_priceTxt);
         _priceTxt = null;
         ObjectUtils.disposeObject(_pointImg);
         _pointImg = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_icon1);
         _icon1 = null;
         ObjectUtils.disposeObject(_icon2);
         _icon2 = null;
         _data = null;
         _template = null;
         super.dispose();
      }
   }
}

