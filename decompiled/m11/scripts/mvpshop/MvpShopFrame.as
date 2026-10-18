package mvpshop
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MvpShopManager;
   import mvc.module.mvpshop.MvpShopItemInfo;
   import mvc.module.mvpshop.MvpShopModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.community.TimeDownView;
   import yishi.view.frame.TodayNotAlertFrame;
   
   public class MvpShopFrame extends Frame
   {
      
      private static const MAX_SHOW_NUM:int = 6;
      
      private static const MAX_RARE_NUM:int = 8;
      
      private static var needAlert:Boolean = true;
      
      private var _leftBg:Bitmap;
      
      private var _rareGoodsTxt:Bitmap;
      
      private var _txtBg:MutipleImage;
      
      private var _border:ScaleBitmapImage;
      
      private var _buyGoodsList:Vector.<MvpShopGoodsItem>;
      
      private var _bottomBg:Bitmap;
      
      private var _mvpPointBg:MutipleImage;
      
      private var _pointsShowTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      private var _freshTimeTxt:FilterFrameText;
      
      private var _downTime:TimeDownView;
      
      private var _quickRefreshBtn:IconButton;
      
      private var _freshPointTxt:FilterFrameText;
      
      private var _freshPointIcon:Bitmap;
      
      private var _rareGoodsList:Vector.<BaseItemView>;
      
      private var rewardScale:int;
      
      public function MvpShopFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("MvpShopFrame.titleTxt.txt");
         _leftBg = ComponentFactory.Instance.creatBitmap("asset.MvpShopFrame.leftBg");
         _rareGoodsTxt = ComponentFactory.Instance.creatBitmap("asset.MvpShopFrame.rareGoodsTxt");
         _txtBg = ComponentFactory.Instance.creatComponentByStylename("mvpShopFrame.txtBg");
         _border = ComponentFactory.Instance.creatComponentByStylename("mvpShopFrame.border");
         _bottomBg = ComponentFactory.Instance.creatBitmap("asset.MvpShopFrame.bottomBg");
         _mvpPointBg = ComponentFactory.Instance.creatComponentByStylename("mvpShopFrame.mvpPointBg");
         _pointsShowTxt = ComponentFactory.Instance.creatComponentByStylename("mvpShopFrame.displayShowTxt");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("mvpShopFrame.timeTxt");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("mvpShopFrame.descTxt");
         _freshTimeTxt = ComponentFactory.Instance.creatComponentByStylename("mvpShopFrame.freshTimeTxt");
         _downTime = ComponentFactory.Instance.creatComponentByStylename("mvpShopFrame.downTime");
         _quickRefreshBtn = ComponentFactory.Instance.creatComponentByStylename("mvpShopFrame.quickRefreshBtn");
         _freshPointTxt = ComponentFactory.Instance.creatComponentByStylename("mvpShopFrame.freshPointTxt");
         _freshPointIcon = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         addToContent(_leftBg);
         addToContent(_rareGoodsTxt);
         addToContent(_txtBg);
         addToContent(_border);
         addToContent(_bottomBg);
         addToContent(_mvpPointBg);
         addToContent(_pointsShowTxt);
         addToContent(_timeTxt);
         addToContent(_descTxt);
         addToContent(_freshTimeTxt);
         addToContent(_downTime);
         addToContent(_quickRefreshBtn);
         addToContent(_freshPointTxt);
         addToContent(_freshPointIcon);
         createGoodsList();
         rewardScale = ConfigInfoManager.instance.getMvpShopRewardScale();
         _descTxt.text = LanguageMgr.GetTranslation("MvpShopFrame.descTxt.txt",rewardScale);
         _freshTimeTxt.text = LanguageMgr.GetTranslation("MvpShopFrame.freshTimeTxt.txt");
         _freshPointIcon.x = 742;
         _freshPointIcon.y = 525;
      }
      
      private function createGoodsList() : void
      {
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:MvpShopGoodsItem = null;
         var _loc5_:int = 0;
         var _loc1_:BaseItemView = null;
         _buyGoodsList = new Vector.<MvpShopGoodsItem>();
         _loc4_ = 0;
         while(_loc4_ < 6)
         {
            _loc2_ = new MvpShopGoodsItem();
            _loc6_ = _loc4_ / 2;
            _loc3_ = _loc4_ % 2;
            _loc2_.x = 267 + _loc3_ * 251;
            _loc2_.y = 190 + _loc6_ * 100;
            _buyGoodsList.push(_loc2_);
            addToContent(_loc2_);
            _loc4_++;
         }
         _rareGoodsList = new Vector.<BaseItemView>();
         _loc5_ = 0;
         while(_loc5_ < 8)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("MvpShopFrame.BaseItemView");
            _loc6_ = _loc5_ / 4;
            _loc3_ = _loc5_ % 4;
            _loc1_.x = 18 + _loc3_ * 60;
            _loc1_.y = 455 + _loc6_ * 60;
            _rareGoodsList.push(_loc1_);
            addToContent(_loc1_);
            _loc5_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("MVPSHOP_INFO_CHANGE",this,__updateInfoChange);
         _downTime.addEventListener("timerDown_complete",__timeCompleteHandler);
         _quickRefreshBtn.addEventListener("click",__quickFreshHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("MVPSHOP_INFO_CHANGE",this,__updateInfoChange);
         _downTime.removeEventListener("timerDown_complete",__timeCompleteHandler);
         _quickRefreshBtn.removeEventListener("click",__quickFreshHandler);
      }
      
      private function __quickFreshHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(isRare)
         {
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("MvpShopFrame.rareGoods.refreshTxt");
            SimpleAlertHelper.instance.data = [isRefreshHandler];
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false);
            return;
         }
         refreshGoods();
      }
      
      private function isRefreshHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            refreshGoods();
         }
      }
      
      private function refreshGoods() : void
      {
         var _loc3_:TodayNotAlertFrame = null;
         var _loc1_:String = null;
         var _loc2_:String = null;
         if(needAlert)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert2");
            _loc1_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc2_ = LanguageMgr.GetTranslation("MvpShopFrame.refreshGoods.pointTxt",point);
            _loc3_.show(_loc2_,_loc1_,__todayNotAlertFresh,null,"center",2,true);
         }
         else
         {
            refreshResult();
         }
      }
      
      private function __todayNotAlertFresh(param1:Boolean) : void
      {
         if(param1)
         {
            needAlert = false;
         }
         refreshResult();
      }
      
      private function refreshResult() : void
      {
         var _loc1_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         if(_loc1_ >= point)
         {
            MvpShopManager.instance.sendRequest(2);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function __timeCompleteHandler(param1:Event) : void
      {
         _downTime.timeCount = 0;
      }
      
      private function __updateInfoChange(param1:String, param2:Object) : void
      {
         LayerManager.Instance.clearnStageDynamic();
         if(!model.isOpen)
         {
            dispose();
            return;
         }
         refreshView();
      }
      
      private function refreshView() : void
      {
         updateGoodsListData();
         _timeTxt.text = model.openTime + " - " + model.stopTime;
         _freshPointTxt.text = point + "";
         _pointsShowTxt.text = model.score + "";
         var _loc1_:Number = model.nextTime / 1000 - PlayerManager.instance.currentPlayerModel.sysSecond;
         _downTime.timeCount = _loc1_;
      }
      
      private function updateGoodsListData() : void
      {
         var _loc1_:int = 0;
         var _loc4_:GoodsInfo = null;
         var _loc3_:MvpShopItemInfo = null;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _buyGoodsList.length)
         {
            if(model.goodsList && model.goodsList[_loc1_])
            {
               _buyGoodsList[_loc1_].data = model.goodsList[_loc1_] as MvpShopItemInfo;
            }
            else
            {
               _buyGoodsList[_loc1_].data = null;
            }
            _loc1_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            if(model.itemList && model.itemList[_loc2_])
            {
               _loc3_ = model.itemList[_loc2_] as MvpShopItemInfo;
               _loc4_ = new GoodsInfo();
               _loc4_.templateId = _loc3_.itemId;
               _rareGoodsList[_loc2_].data = _loc4_;
            }
            _loc2_++;
         }
      }
      
      private function get model() : MvpShopModel
      {
         return MvpShopManager.instance.model;
      }
      
      private function get isRare() : Boolean
      {
         for each(var _loc1_:MvpShopItemInfo in model.goodsList)
         {
            if(_loc1_.isRare && !_loc1_.isBuy)
            {
               return true;
            }
         }
         return false;
      }
      
      private function get point() : int
      {
         var _loc1_:int = 100;
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("mvp_shop_random_consume");
         if(_loc2_ && _loc2_.ConfigValue)
         {
            return int(_loc2_.ConfigValue);
         }
         return _loc1_;
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_leftBg);
         _leftBg = null;
         ObjectUtils.disposeObject(_rareGoodsTxt);
         _rareGoodsTxt = null;
         ObjectUtils.disposeObject(_txtBg);
         _txtBg = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_bottomBg);
         _bottomBg = null;
         ObjectUtils.disposeObject(_mvpPointBg);
         _mvpPointBg = null;
         ObjectUtils.disposeObject(_pointsShowTxt);
         _pointsShowTxt = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeObject(_freshTimeTxt);
         _freshTimeTxt = null;
         ObjectUtils.disposeObject(_downTime);
         _downTime = null;
         ObjectUtils.disposeObject(_quickRefreshBtn);
         _quickRefreshBtn = null;
         ObjectUtils.disposeObject(_freshPointTxt);
         _freshPointTxt = null;
         ObjectUtils.disposeObject(_freshPointIcon);
         _freshPointIcon = null;
         LogicUtils.disposeDisplayCollection(_buyGoodsList);
         _buyGoodsList = null;
         LogicUtils.disposeDisplayCollection(_rareGoodsList);
         _rareGoodsList = null;
         super.dispose();
      }
   }
}

