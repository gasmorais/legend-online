package sevenyear.view.battleflag
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.SevenYearManager;
   import mvc.module.sevenyear.SevenYearModel;
   import sevenyear.SevenYearBuyFrame;
   import sevenyear.view.item.SevenYearFlagItem;
   import utils.LogicUtils;
   import yishi.datas.ConfigInfoManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.base.ProgressPanel;
   import yishi.view.frame.giftdonatio.GiftDonatioFrame;
   
   public class SevenYearGradeView extends Component
   {
      
      private var _bg:MutipleImage;
      
      private var _numBitmap:Bitmap;
      
      private var _numContainer:StripView;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _progress:ProgressPanel;
      
      private var _scoreDesc:FilterFrameText;
      
      private var _buyBtn:TextButton;
      
      private var _giftBtn:TextButton;
      
      private var _honeBtn:IconButton;
      
      private var _priceSp:Sprite;
      
      private var _flag:SevenYearFlagItem;
      
      private var _icon:Bitmap;
      
      private var _priceTxt:FilterFrameText;
      
      private var _point:int;
      
      public function SevenYearGradeView()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("SevenYearGradeView.bg");
         _numBitmap = ComponentFactory.Instance.creatBitmap("asset.SevenYearBattleFlagView.numberbmp");
         _numContainer = ComponentFactory.Instance.creatCustomObject("SevenYearBattleFlagView.numContainer");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearBattleFlagView.scoreTxt");
         _progress = ComponentFactory.Instance.creatCustomObject("SevenYearBattleFlagView.ProgressPanel");
         _scoreDesc = ComponentFactory.Instance.creatComponentByStylename("SevenYearBattleFlagView.scoreDesc");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearBattleFlagView.buyBtn");
         _giftBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearBattleFlagView.giftBtn");
         _icon = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearBuyItem.priceTxt");
         _honeBtn = ComponentFactory.Instance.creatComponentByStylename("Sevenyear.honrBuyBtn");
         _priceSp = new Sprite();
         _priceSp.mouseChildren = _priceSp.mouseEnabled = false;
         addChild(_bg);
         addChild(_scoreTxt);
         addChild(_progress);
         addChild(_scoreDesc);
         addChild(_buyBtn);
         addChild(_honeBtn);
         addChild(_priceSp);
         _priceSp.addChild(_icon);
         _priceSp.addChild(_priceTxt);
         _icon.x = 91;
         _icon.y = 253;
         _priceTxt.x = 110;
         _priceTxt.y = 253;
         _point = ConfigInfoManager.instance.getSevenYearFlagBuyCost()[0];
         _priceTxt.text = _point.toString();
         _progress.initView("asset.SevenYearBattleFlagView.progressBack","asset.SevenYearBattleFlagView.progressBar","");
         _progress.barPosxy(13,8);
         _scoreDesc.text = LanguageMgr.GetTranslation("SevenYearGradeView.scoreDesc.text");
         _giftBtn.text = LanguageMgr.GetTranslation("SevenYearGradeView.giftBtn.text");
         _flag = new SevenYearFlagItem();
         addChild(_flag);
         _flag.x = 104;
         _flag.y = 14;
      }
      
      public function refreshView() : void
      {
         _honeBtn.visible = !model.hasBuy;
         _buyBtn.visible = model.hasBuy;
         _buyBtn.text = LanguageMgr.GetTranslation("SevenYearGradeView.buyBtn.text2");
         if(model.hasBuy)
         {
            _priceSp.visible = false;
         }
         else
         {
            _priceSp.visible = true;
            _priceSp.x = -44;
            _priceSp.y = -20;
         }
         _flag.grade = model.flagGrade;
         var _loc2_:int = int(ConfigInfoManager.instance.getSevenYearGradeScore());
         var _loc1_:int = _loc2_ - model.flagScore;
         _scoreTxt.text = _loc1_.toString();
         _progress.progressValue(model.flagScore,_loc2_);
      }
      
      private function initEvent() : void
      {
         _buyBtn.addEventListener("click",__buyBtnClickHandler);
         _honeBtn.addEventListener("click",honrBuyHandler);
         _giftBtn.addEventListener("click",__giftBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",__buyBtnClickHandler);
         }
         if(_buyBtn)
         {
            _honeBtn.removeEventListener("click",honrBuyHandler);
         }
         if(_giftBtn)
         {
            _giftBtn.removeEventListener("click",__giftBtnClickHandler);
         }
      }
      
      private function honrBuyHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("sevenyear.honerBuy.tip",_point);
         SimpleAlertHelper.instance.data = [secondConfrimBuy];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true,false);
      }
      
      private function __buyBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:SevenYearBuyFrame = ComponentFactory.Instance.creatComponentByStylename("sevenyear.SevenYearBuyFrame");
         _loc2_.show();
      }
      
      private function secondConfrimBuy(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(!LogicUtils.judgePointEnoughToShowPay(_point,false))
            {
               return;
            }
            SevenYearManager.instance.sendBuyFlag(0);
         }
      }
      
      private function __giftBtnClickHandler(param1:MouseEvent) : void
      {
         if(!LogicUtils.judgePointEnoughToShowPay(_point,false))
         {
            return;
         }
         CheckUIModuleUtil.instance.tryCall("quickbuy",callBack);
      }
      
      private function callBack() : void
      {
         var _loc1_:GiftDonatioFrame = ComponentFactory.Instance.creatComponentByStylename("shop.GiftDonatioFrame");
         _loc1_.sevenYearCallBack = giftCallBack;
         _loc1_.show();
      }
      
      private function giftCallBack(param1:String) : void
      {
         SevenYearManager.instance.sendSendFlag(0,param1);
      }
      
      private function get model() : SevenYearModel
      {
         return SevenYearManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_numBitmap);
         _numBitmap = null;
         ObjectUtils.disposeObject(_numContainer);
         _numContainer = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_scoreDesc);
         _scoreDesc = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_giftBtn);
         _giftBtn = null;
         ObjectUtils.disposeObject(_flag);
         _flag = null;
         ObjectUtils.disposeObject(_honeBtn);
         _honeBtn = null;
         super.dispose();
      }
   }
}

