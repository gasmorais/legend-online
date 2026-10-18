package consortia.view.myConsortia.building
{
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import consortia.helper.ConsortiaAltarHelper;
   import consortia.manager.TurnControl;
   import events.ConsortiaEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.clearInterval;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.VIPManager;
   import mvc.controler.ConsortiaControler;
   import mvc.module.consortia.ConsortiaInfo;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.vip.VIPModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   
   public class ConsortiaAltarFrame extends Frame
   {
      
      public static const QUICK_BLESS_COUNT:int = 10;
      
      public static const QUICK_BLESS_VIP_GRADE:int = 4;
      
      private var _goodsItemList:Vector.<ConsortiaAltarGoodsItem>;
      
      private var _data:ConsortiaModel;
      
      private var _vipModel:VIPModel;
      
      private var _selectedIcon:Sprite;
      
      private var _turnControl:TurnControl;
      
      private var _timeId:uint;
      
      private var _view:ConsortiaAltarView;
      
      private var _numList:Array;
      
      private var _goodsList:Array;
      
      private var _selectedItem:BaseItemView;
      
      private var _quickBlessFlag:Boolean;
      
      private var _quickBlessBlinkTimeId:int;
      
      private var _blessHandler:Function;
      
      public function ConsortiaAltarFrame()
      {
         super();
         initView();
         addEvent();
         initData();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _data = FrameControllerManager.instance.consortiaController.model;
         _vipModel = VIPManager.Instance.model;
         titleText = "";
         _view = new ConsortiaAltarView();
         addToContent(_view);
      }
      
      private function get controller() : ConsortiaControler
      {
         return FrameControllerManager.instance.consortiaController;
      }
      
      private function uninit() : void
      {
         _numList = null;
         clearTimeout(_timeId);
         if(_quickBlessBlinkTimeId > 0)
         {
            clearInterval(_quickBlessBlinkTimeId);
         }
         _quickBlessBlinkTimeId = 0;
         TweenLite.killTweensOf(_selectedIcon);
         TweenLite.killTweensOf(_selectedItem);
         ObjectUtils.disposeObject(_selectedIcon);
         _selectedIcon = null;
         ObjectUtils.disposeObject(_selectedItem);
         _selectedItem = null;
         ObjectUtils.disposeObject(_turnControl);
         _turnControl = null;
         ObjectUtils.disposeObject(_view);
         _view = null;
         _data = null;
         _vipModel = null;
         _goodsItemList = null;
         _goodsList = null;
      }
      
      private function __setGoods(param1:ConsortiaEvent) : void
      {
         _goodsList = param1.data as Array;
      }
      
      private function get consume() : int
      {
         return TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(3,consortiaInfo.altarLevel).Property1;
      }
      
      private function get totalTime() : int
      {
         return TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(3,consortiaInfo.altarLevel).Property2;
      }
      
      private function checkEnable() : void
      {
         if(_data.isBlessing)
         {
            _view.blessBtn.enable = false;
         }
         else
         {
            _view.blessBtn.enable = true;
         }
      }
      
      public function refreshGoods() : void
      {
         _data.lastaltarGoods = _data.altarGoods;
         clearGoods();
         _data.isBlessing = false;
         _closeButton.enable = true;
         checkEnable();
      }
      
      private function clearGoods() : void
      {
         for each(var _loc1_:ConsortiaAltarGoodsItem in _goodsItemList)
         {
            _loc1_.data = null;
         }
      }
      
      private function get consortiaInfo() : ConsortiaInfo
      {
         return _data.consortiaInfo;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _view.blessBtn.addEventListener("click",__onBlessClickHandler);
         _view.quickBlessBtn.addEventListener("click",__onQuickBlessClickHandler);
         _data.addEventListener("UPDA_ALTAR_BLESS_INFO",__onBlessInfoCallback);
         _data.addEventListener("UPDA_ALTAR_BLESS",__onBlessCallback);
         NotificationManager.instance.addEventListener("ON_BLESS_COMPLETE",__onBlessComplete);
         NotificationManager.instance.addEventListener("GET_ALTAR_GOODS",__onGetGoodsHandler);
         NotificationManager.instance.addEventListener("UPDE_ALTAR_SIZE",__setGoods);
         playerInfo.addEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _view.blessBtn.removeEventListener("click",__onBlessClickHandler);
         _view.quickBlessBtn.removeEventListener("click",__onQuickBlessClickHandler);
         _data.removeEventListener("UPDA_ALTAR_BLESS_INFO",__onBlessInfoCallback);
         _data.removeEventListener("UPDA_ALTAR_BLESS",__onBlessCallback);
         NotificationManager.instance.removeEventListener("ON_BLESS_COMPLETE",__onBlessComplete);
         NotificationManager.instance.removeEventListener("GET_ALTAR_GOODS",__onGetGoodsHandler);
         NotificationManager.instance.removeEventListener("UPDE_ALTAR_SIZE",__setGoods);
         playerInfo.removeEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
      }
      
      private function __existConsortiaHandler(param1:PlayerEvent) : void
      {
         if(playerInfo.consortiaID == 0)
         {
            dispose();
         }
      }
      
      private function initData() : void
      {
         FrameControllerManager.instance.consortiaController.initAltarFrameInfo();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               if(_closeButton.enable)
               {
                  dispose();
               }
         }
      }
      
      private function __onBlessClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!ConsortiaAltarHelper.canBless(_data,totalTime,consume,playerInfo.consortiaOffer,__resposeHandler))
         {
            _blessHandler = __onBlessClickHandler;
            return;
         }
         FrameControllerManager.instance.consortiaController.consortiaAltarBless();
         _view.blessBtn.enable = false;
         _closeButton.enable = false;
      }
      
      private function __onQuickBlessClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc6_:String = null;
         var _loc4_:String = null;
         SoundManager.instance.play("022");
         if(!VIPManager.Instance.model.vipInfo.IsVipAndNoExpirt || VIPManager.Instance.model.vipInfo.VipGrade < 4)
         {
            SimpleAlertHelper.instance.data = [__quickBlessHandler];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc6_ = LanguageMgr.GetTranslation("public.prompt");
            _loc4_ = LanguageMgr.GetTranslation("vip.newVipOpenView.alert3");
            SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc4_,_loc2_,_loc3_,true,true);
            return;
         }
         if(_data.isBlessing)
         {
            return;
         }
         if(!ConsortiaAltarHelper.canBless(_data,totalTime,consume,playerInfo.consortiaOffer,__resposeHandler))
         {
            _blessHandler = __onQuickBlessClickHandler;
            return;
         }
         if(_quickBlessBlinkTimeId > 0)
         {
            clearInterval(_quickBlessBlinkTimeId);
         }
         _quickBlessFlag = true;
         var _loc5_:int = Math.min(totalTime - _data.alTarBlessLeftTime,playerInfo.consortiaOffer / consume);
         FrameControllerManager.instance.consortiaController.consortiaAltarBless(_loc5_);
         _view.blessBtn.enable = false;
         _view.quickBlessBtn.enable = false;
         _closeButton.enable = true;
      }
      
      private function __quickBlessHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.openControllerByInfo("vip");
         }
      }
      
      private function flicker() : void
      {
         for each(var _loc1_:ConsortiaAltarGoodsItem in _goodsItemList)
         {
            _loc1_.flicker();
         }
         _quickBlessBlinkTimeId = setTimeout(flickerComplete,1000);
      }
      
      private function flickerComplete() : void
      {
         for each(var _loc1_:ConsortiaAltarGoodsItem in _goodsItemList)
         {
            _loc1_.stopFlicker();
         }
         clearTimeout(_quickBlessBlinkTimeId);
         _quickBlessFlag = false;
         __onBlessCallback(null);
         _quickBlessBlinkTimeId = 0;
         _turnControl.defaultTurn(_goodsItemList);
      }
      
      public function __resposeHandler() : void
      {
         _view.__onDrawClickHandler(null);
      }
      
      private function __onBlessCallback(param1:ConsortiaEvent) : void
      {
         _view.blessBtn.enable = true;
         _view.quickBlessBtn.enable = true;
         _closeButton.enable = true;
         _data.isBlessing = false;
      }
      
      private function __onBlessInfoCallback(param1:ConsortiaEvent) : void
      {
         _view.playAltarEffect();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __onGetGoodsHandler(param1:ConsortiaEvent) : void
      {
         if(param1.data)
         {
            _view.clearCenterGoods();
         }
      }
      
      private function __onBlessComplete(param1:ConsortiaEvent) : void
      {
         var _loc3_:int = int(_numList[_data.blessInfo.site]);
         var _loc2_:ConsortiaAltarGoodsItem = _goodsItemList[_loc3_];
         _selectedIcon = _loc2_.iconSprite;
         _selectedItem = ComponentFactory.Instance.creatCustomObject("consortia.AltarViewBaseItemView");
         _selectedItem.data = _data.altarGoods;
         _loc2_.addChild(_selectedItem);
         ConsortiaAltarHelper.tweenItem(_selectedItem,this,showGoods);
      }
      
      private function showGoods() : void
      {
         if(!_view)
         {
            return;
         }
         _view.setCenterItem();
         _selectedIcon.parent.removeChild(_selectedIcon);
         _selectedIcon = null;
         _selectedItem.parent.removeChild(_selectedItem);
         _selectedItem = null;
         _timeId = setTimeout(refreshGoods,500);
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         _view.__onDrawClickHandler(null);
         removeEvent();
         uninit();
         super.dispose();
         KeyBoardRegister.instance.keyEnable = true;
         FrameControllerManager.instance.consortiaController.closeAltarFrame();
      }
   }
}

