package sevenyear.view.battleflag
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SevenYearManager;
   import mvc.module.sevenyear.SevenYearModel;
   import sevenyear.view.item.SevenYearFlagItem;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.giftdonatio.GiftDonatioFrame;
   
   public class SevenYearFlagHandleFrame extends Frame
   {
      
      public static const TYPE_BUY:int = 1;
      
      public static const TYPE_SEND:int = 2;
      
      private var _btnBuy1L:IconButton;
      
      private var _btnBuy40L:IconButton;
      
      private var _btnSend1L:IconButton;
      
      private var _btnSend40L:IconButton;
      
      private var _imgFlagPic1:MutipleImage;
      
      private var _txtFlagCost1:FilterFrameText;
      
      private var _txtFlagCost40:FilterFrameText;
      
      private var _txtFlagCost40_2:FilterFrameText;
      
      private var _txtFlagStr1:FilterFrameText;
      
      private var _txtFlagStr40:FilterFrameText;
      
      private var _bit0:Bitmap;
      
      private var _bit1:Bitmap;
      
      private var flag1:SevenYearFlagItem;
      
      private var flag40:SevenYearFlagItem;
      
      private var _list1:SimpleTileList;
      
      private var _list40:SimpleTileList;
      
      public var type:int;
      
      private var opType:int;
      
      public function SevenYearFlagHandleFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:Array = null;
         var _loc3_:BaseItemView = null;
         var _loc4_:GoodsInfo = null;
         var _loc2_:* = null;
         _btnBuy1L = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.btnBuy1L");
         _btnBuy40L = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.btnBuy40L");
         _btnSend1L = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.btnSend1L");
         _btnSend40L = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.btnSend40L");
         _imgFlagPic1 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.imgFlagPic1");
         _txtFlagCost1 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtFlagCost1");
         _txtFlagCost40 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtFlagCost40");
         _txtFlagCost40_2 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtFlagCost40_2");
         _txtFlagStr1 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtFlagStr1");
         _txtFlagStr40 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtFlagStr40");
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.SevenYearFlagHandleFrame.bg2");
         _bit1 = ComponentFactory.Instance.creatBitmap("asset.SevenYearFlagHandleFrame.bg1");
         addToContent(_bit0);
         addToContent(_bit1);
         addToContent(_btnBuy1L);
         addToContent(_btnBuy40L);
         addToContent(_btnSend1L);
         addToContent(_btnSend40L);
         addToContent(_txtFlagCost1);
         addToContent(_txtFlagCost40);
         addToContent(_txtFlagStr1);
         addToContent(_txtFlagStr40);
         addToContent(_txtFlagCost40_2);
         addToContent(_imgFlagPic1);
         _txtFlagStr1.text = LanguageMgr.GetTranslation("SevenYearFlagHandleFrame.str1");
         _txtFlagStr40.text = LanguageMgr.GetTranslation("SevenYearFlagHandleFrame.str2");
         _txtFlagCost1.text = ConfigInfoManager.instance.getSevenYearFlagBuyCost()[0];
         _txtFlagCost40.text = ConfigInfoManager.instance.getSevenYearFlagBuyCost()[1];
         _txtFlagCost40_2.text = ConfigInfoManager.instance.getSevenYearFlagBuyCost()[2];
         flag1 = ComponentFactory.Instance.creatComponentByStylename("SevenYearFlagHandleFrame.flag1");
         flag40 = ComponentFactory.Instance.creatComponentByStylename("SevenYearFlagHandleFrame.flag40");
         addToContent(flag1);
         addToContent(flag40);
         flag1.grade = 1;
         flag40.grade = 40;
         _list1 = ComponentFactory.Instance.creatCustomObject("SevenYearFlagHandleFrame.list1",[6]);
         _list40 = ComponentFactory.Instance.creatCustomObject("SevenYearFlagHandleFrame.list40",[6]);
         addToContent(_list1);
         addToContent(_list40);
         _loc1_ = ConfigInfoManager.instance.getSevenYearBuyFlagAward1();
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("SevenYearFlagHandleFrame.item");
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc2_.split(",")[0];
            _loc4_.count = _loc2_.split(",")[1];
            _loc3_.data = _loc4_;
            _list1.addChild(_loc3_);
         }
         _loc1_ = ConfigInfoManager.instance.getSevenYearBuyFlagAward40();
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("SevenYearFlagHandleFrame.item");
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc2_.split(",")[0];
            _loc4_.count = _loc2_.split(",")[1];
            _loc3_.data = _loc4_;
            _list40.addChild(_loc3_);
         }
      }
      
      private function refreshView() : void
      {
         if(type == 1)
         {
            DisplayUtils.handleDisplay(false,_btnSend1L,_btnSend40L,_bit0);
            titleText = LanguageMgr.GetTranslation("SevenYearFlagHandleFrame.str3");
         }
         else
         {
            DisplayUtils.handleDisplay(false,_btnBuy1L,_btnBuy40L,_bit1);
            titleText = LanguageMgr.GetTranslation("SevenYearFlagHandleFrame.str4");
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         this.addEventListener("click",onClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         this.removeEventListener("click",onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(param1.target == _btnBuy1L)
         {
            opType = 0;
            alertBuy(ConfigInfoManager.instance.getSevenYearFlagBuyCost()[0]);
         }
         else if(param1.target == _btnBuy40L)
         {
            opType = 1;
            alertBuy(ConfigInfoManager.instance.getSevenYearFlagBuyCost()[1]);
         }
         else if(param1.target == _btnSend1L)
         {
            opType = 0;
            CheckUIModuleUtil.instance.tryCall("quickbuy",callBack);
         }
         else if(param1.target == _btnSend40L)
         {
            opType = 1;
            CheckUIModuleUtil.instance.tryCall("quickbuy",callBack);
         }
      }
      
      private function alertBuy(param1:int) : void
      {
         SimpleAlertHelper.instance.data = [buyCallBack,param1];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("SevenYearGradeView.buyBtnClick.text",param1);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_);
      }
      
      private function buyCallBack(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(param1)
         {
            if(!LogicUtils.judgePointEnoughToShowPay(param3,false))
            {
               return;
            }
            SevenYearManager.instance.sendBuyFlag(opType);
            dispose();
         }
      }
      
      private function callBack() : void
      {
         var _loc1_:GiftDonatioFrame = ComponentFactory.Instance.creatComponentByStylename("shop.GiftDonatioFrame");
         _loc1_.sevenYearCallBack = giftCallBack;
         _loc1_.show();
      }
      
      private function giftCallBack(param1:String) : void
      {
         SevenYearManager.instance.sendSendFlag(opType,param1);
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function get model() : SevenYearModel
      {
         return SevenYearManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_btnBuy1L);
         _btnBuy1L = null;
         ObjectUtils.disposeObject(_btnBuy40L);
         _btnBuy40L = null;
         ObjectUtils.disposeObject(_btnSend1L);
         _btnSend1L = null;
         ObjectUtils.disposeObject(_btnSend40L);
         _btnSend40L = null;
         ObjectUtils.disposeObject(_imgFlagPic1);
         _imgFlagPic1 = null;
         ObjectUtils.disposeObject(_txtFlagCost1);
         _txtFlagCost1 = null;
         ObjectUtils.disposeObject(_txtFlagCost40);
         _txtFlagCost40 = null;
         ObjectUtils.disposeObject(_txtFlagCost40_2);
         _txtFlagCost40_2 = null;
         ObjectUtils.disposeObject(_txtFlagStr1);
         _txtFlagStr1 = null;
         ObjectUtils.disposeObject(_txtFlagStr40);
         _txtFlagStr40 = null;
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_bit1);
         _bit1 = null;
         ObjectUtils.disposeObject(flag1);
         flag1 = null;
         ObjectUtils.disposeObject(flag40);
         flag40 = null;
         ObjectUtils.disposeObject(_list1);
         _list1 = null;
         ObjectUtils.disposeObject(_list40);
         _list40 = null;
         super.dispose();
      }
   }
}

