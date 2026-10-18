package view.subshop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.star.StarInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.StarTemplate;
   import yishi.manager.PlayerManager;
   import yishi.manager.StarManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StarHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.frame.NumBuyFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class StarShopItem extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _nameTxt:FilterFrameText;
      
      private var _buffTxt:FilterFrameText;
      
      private var _starPointTxt:FilterFrameText;
      
      private var _starPointImg:Bitmap;
      
      private var _buyBtn:IconButton;
      
      private var _overBack:Bitmap;
      
      private var _data:StarTemplate;
      
      public function StarShopItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.star.StarShopItemBg");
         _icon = ComponentFactory.Instance.creatCustomObject("star.StarShopItemIcon");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("star.StarShopItemNameTxt");
         _buffTxt = ComponentFactory.Instance.creatComponentByStylename("star.StarShopItemBuffTxt");
         _starPointTxt = ComponentFactory.Instance.creatComponentByStylename("star.StarShopItemStarPointTxt");
         _starPointImg = ComponentFactory.Instance.creatBitmap("asset.star.StarPointImg");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("star.StarShopItemBuyBtn");
         _overBack = ComponentFactory.Instance.creatBitmap("asset.star.StarShopItemOverBg");
         addChild(_bg);
         addChild(_icon);
         addChild(_nameTxt);
         addChild(_buffTxt);
         addChild(_starPointTxt);
      }
      
      private function addEvent() : void
      {
         addEventListener("rollOver",__itemRollOverHandler);
         addEventListener("rollOut",__itemRollOutHandler);
         _buyBtn.addEventListener("click",__buyClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__itemRollOverHandler);
         removeEventListener("rollOut",__itemRollOutHandler);
         _buyBtn.removeEventListener("click",__buyClick);
      }
      
      private function __itemRollOverHandler(param1:MouseEvent) : void
      {
         if(_overBack)
         {
            addChild(_overBack);
         }
      }
      
      private function __itemRollOutHandler(param1:MouseEvent) : void
      {
         if(_overBack && _overBack.parent)
         {
            _overBack.parent.removeChild(_overBack);
         }
      }
      
      private function __buyClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc3_:String = null;
         var _loc6_:String = null;
         if(_data)
         {
            _loc2_ = "";
            if(playerInfo.starPoint < _data.StarPoint)
            {
               _loc2_ = LanguageMgr.GetTranslation("star.view.StarShopItem.command01");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            if(StarManager.instance.checkStarPlayerBagIsFull())
            {
               _loc2_ = LanguageMgr.GetTranslation("star.view.StarShopItem.command02");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            if(_data.TemplateId == 4 || _data.TemplateId == 5)
            {
               CheckUIModuleUtil.instance.tryCall("numbuy",showBuyFrameCall);
               return;
            }
            if(_data.NeedGrades >= 80 && playerInfo.vocationGrades <= 0)
            {
               _loc4_ = LanguageMgr.GetTranslation("public.confirm");
               _loc5_ = LanguageMgr.GetTranslation("public.cancel");
               _loc3_ = LanguageMgr.GetTranslation("public.prompt");
               _loc6_ = LanguageMgr.GetTranslation("view.subshop.StarShopItem.alertContent");
               SimpleAlertHelper.instance.data = [alertFun];
               SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc6_,_loc4_,_loc5_,true,true);
               return;
            }
            alertFun(true,true);
         }
      }
      
      private function alertFun(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc5_:String = null;
         if(param1)
         {
            if(_data)
            {
               _loc3_ = LanguageMgr.GetTranslation("public.confirm");
               _loc4_ = LanguageMgr.GetTranslation("public.cancel");
               _loc6_ = LanguageMgr.GetTranslation("public.prompt");
               _loc7_ = LanguageMgr.GetTranslation("star.view.StarShopItem.str",_data.StarPoint);
               _loc5_ = _loc7_ + StarHelper.getStarHtmlName(_data);
               SimpleAlertHelper.instance.data = [buyResponseHandler];
               SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc5_,_loc3_,_loc4_,true,true);
            }
         }
      }
      
      private function showBuyFrameCall() : void
      {
         var _loc1_:NumBuyFrame = ComponentFactory.Instance.creatComponentByStylename("numbuy.numbuyFrame");
         _loc1_.data = _data;
         _loc1_.show();
      }
      
      private function buyResponseHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1 && _data)
         {
            StarManager.instance.sendExchangeStar(_data.TemplateId);
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function set data(param1:StarTemplate) : void
      {
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         refreshView();
      }
      
      public function refreshView() : void
      {
         var _loc1_:StarInfo = null;
         if(_data)
         {
            _loc1_ = new StarInfo();
            _loc1_.template = _data;
            _loc1_.bagType = 0;
            _loc1_.grade = 1;
            _icon.icon = IconFactory.getCommonIconPath(_data.Icon);
            _icon.tipData = {"starData":_loc1_};
            _nameTxt.text = _data.TemplateName;
            _nameTxt.setFrame(_data.Profile);
            _nameTxt.numLines == 2 ? (_nameTxt.y = 5) : (Number(_nameTxt.y = 10));
            _buffTxt.text = StarHelper.getStarAttributeAdd(_loc1_);
            if(_buffTxt.numLines > 3)
            {
               _buffTxt.y = 29;
            }
            else
            {
               _buffTxt.y = 42;
            }
            _starPointTxt.text = _data.StarPoint.toString();
            addChild(_starPointImg);
            addChild(_buyBtn);
         }
         else
         {
            _icon.icon = null;
            _icon.tipData = null;
            _nameTxt.text = "";
            _buffTxt.text = "";
            _starPointTxt.text = "";
            if(_starPointImg && _starPointImg.parent)
            {
               _starPointImg.parent.removeChild(_starPointImg);
            }
            if(_buyBtn && _buyBtn.parent)
            {
               _buyBtn.parent.removeChild(_buyBtn);
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _overBack = null;
         _starPointImg = null;
         _data = null;
         if(_icon)
         {
            _icon.dispose();
         }
         _icon = null;
         if(_nameTxt)
         {
            _nameTxt.dispose();
         }
         _nameTxt = null;
         if(_buffTxt)
         {
            _buffTxt.dispose();
         }
         _buffTxt = null;
         if(_starPointTxt)
         {
            _starPointTxt.dispose();
         }
         _starPointTxt = null;
         if(_buyBtn)
         {
            _buyBtn.dispose();
         }
         _buyBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

