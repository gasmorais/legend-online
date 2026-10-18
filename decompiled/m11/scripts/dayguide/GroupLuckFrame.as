package dayguide
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quart;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.leed.LeadRewardMsg;
   import com.road.yishi.proto.vip.VipItemInfoMsg;
   import dayguide.manager.DayGuideTurnControl;
   import events.DayGuideEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import ui.maintoolbar.MainToolBar;
   import yishi.comm.PackageIn;
   import yishi.datas.ComponentGroupType;
   import yishi.events.SLGSocketEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class GroupLuckFrame extends Frame
   {
      
      private var _items:Array;
      
      private var _drawBack:Bitmap;
      
      private var _luckDrawBg:Bitmap;
      
      private var _drawItemBack:Bitmap;
      
      private var _drawTimeTxt:Bitmap;
      
      private var _back:ScaleBitmapImage;
      
      private var _drawButton:IconButton;
      
      private var _tipTxt:FilterFrameText;
      
      private var _drawTimeValue:FilterFrameText;
      
      private var _turnControl:DayGuideTurnControl;
      
      private var _goodsItemList:Vector.<LuckDrawGoodsItem>;
      
      private var _contain:Sprite;
      
      private var _leftTimesBg:Bitmap;
      
      private var _index:int = 0;
      
      private var _templateId:int;
      
      public function GroupLuckFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:LuckDrawGoodsItem = null;
         titleText = LanguageMgr.GetTranslation("dayguide.GroupLuckFrame.titleText");
         _back = ComponentFactory.Instance.creatComponentByStylename("dayGuide.LuckDrawView.Back");
         _luckDrawBg = ComponentFactory.Instance.creatBitmap("asset.dayGuide.LuckDrawBg");
         _drawBack = ComponentFactory.Instance.creatBitmap("asset.dayGuide.luckDrawBack");
         _drawItemBack = ComponentFactory.Instance.creatBitmap("asset.dayGuide.luckDrawBack1");
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("dayGuide.tipText");
         _drawTimeTxt = ComponentFactory.Instance.creatBitmap("asset.dayGuide.drawTimeText");
         _drawTimeValue = ComponentFactory.Instance.creatComponentByStylename("dayGuide.drawTimeValueText");
         _drawButton = ComponentFactory.Instance.creatComponentByStylename("dayGuide.DrawButton");
         _contain = new Sprite();
         _leftTimesBg = ComponentFactory.Instance.creatBitmap("asset.dayGuide.leftTimesBg");
         addToContent(_back);
         addToContent(_luckDrawBg);
         addToContent(_contain);
         _contain.x = 16;
         _contain.y = -20;
         _contain.addChild(_drawBack);
         _contain.addChild(_drawItemBack);
         _contain.addChild(_drawButton);
         addToContent(_leftTimesBg);
         addToContent(_drawTimeTxt);
         addToContent(_drawTimeValue);
         addToContent(_tipTxt);
         _tipTxt.text = LanguageMgr.GetTranslation("dayGuide.view.GroupLuckFrameWarn");
         _goodsItemList = new Vector.<LuckDrawGoodsItem>();
         _loc2_ = 1;
         while(_loc2_ < 10)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("dayGuide.LuckDrawGoodsItem" + _loc2_);
            _loc1_.scaleX = _loc1_.scaleY = 0.6;
            _loc1_.name = "LuckDrawGoodsItem" + _loc2_;
            _contain.addChild(_loc1_);
            _goodsItemList.push(_loc1_);
            _loc2_++;
         }
         _turnControl = new DayGuideTurnControl();
         _turnControl.defaultTurn(_goodsItemList);
         refreshDrawTimes();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _drawButton.addEventListener("click",_darawBtnHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4936,__luckDrawHandler);
         NotificationManager.instance.addEventListener("ON_DRAW_COMPLETE",__onBlessComplete);
         NotificationManager.instance.addEventListener("POP_GOODS",__onGoosComplete);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _drawButton.removeEventListener("click",_darawBtnHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4936,__luckDrawHandler);
         NotificationManager.instance.removeEventListener("ON_DRAW_COMPLETE",__onBlessComplete);
         NotificationManager.instance.removeEventListener("POP_GOODS",__onGoosComplete);
      }
      
      private function setGoods() : void
      {
         var _loc1_:VipItemInfoMsg = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _items.length)
         {
            _loc1_ = _items[_loc2_] as VipItemInfoMsg;
            _goodsItemList[_loc2_].data1 = _loc1_;
            _loc2_++;
         }
      }
      
      private function _darawBtnHandler(param1:MouseEvent) : void
      {
         if(GoodsManager.instance.findEmputyPos() == -1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.view.luckDrawFullBagTip"));
            return;
         }
         if(int(_drawTimeValue.text) <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.view.luckDrawTimesUseOff"));
            return;
         }
         SoundManager.instance.play("022");
         FrameControllerManager.instance.funnyControler.sendLuckDraw(1);
         _drawButton.enable = false;
         NotificationManager.instance.dispatchEvent(new DayGuideEvent("POP_GOODS_MOVIE"));
      }
      
      private function __luckDrawHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:VipItemInfoMsg = null;
         var _loc4_:int = 0;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:LeadRewardMsg = new LeadRewardMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as LeadRewardMsg;
         _loc4_ = 0;
         while(_loc4_ < _items.length)
         {
            _loc3_ = _items[_loc4_] as VipItemInfoMsg;
            if(_loc3_.tempId == _loc2_.templateId && _loc3_.count == _loc2_.count)
            {
               _index = _loc4_;
            }
            _loc4_++;
         }
         _turnControl.turnPlate(_index + 1);
         FrameControllerManager.instance.funnyControler.luckDrawCount = _loc2_.leadExtractTimes;
         refreshDrawTimes();
      }
      
      private function __onBlessComplete(param1:DayGuideEvent) : void
      {
         var icon:BaseIconView;
         var _timeId:uint;
         var evt:DayGuideEvent = param1;
         FrameControllerManager.instance.funnyControler.sendLuckDraw(2);
         icon = ComponentFactory.Instance.creatCustomObject("core.BaseIcon",[iconComplete]);
         icon.icon = IconFactory.getGoodsIconByTID(_templateId);
         _timeId = setTimeout(function():void
         {
            clearTimeout(_timeId);
            _turnControl.defaultTurn(_goodsItemList);
            if(_drawButton)
            {
               _drawButton.enable = true;
            }
         },500);
      }
      
      private function __onGoosComplete(param1:DayGuideEvent) : void
      {
         _templateId = param1.data.templateId;
      }
      
      private function iconComplete(param1:BaseIconView = null) : void
      {
         var _loc3_:LuckDrawGoodsItem = null;
         var _loc5_:Point = null;
         var _loc2_:DisplayObject = null;
         var _loc4_:Point = null;
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            if(param1)
            {
               param1.dispose();
            }
            param1 = null;
            return;
         }
         try
         {
            _loc3_ = this._contain.getChildByName("LuckDrawGoodsItem" + _index) as LuckDrawGoodsItem;
            _loc5_ = this.parent.localToGlobal(new Point(_loc3_.x,_loc3_.y));
            param1.x = _loc5_.x + 319;
            param1.y = _loc5_.y + 31;
            param1.mouseChildren = param1.mouseEnabled = false;
            StageReferance.stage.addChild(param1);
            _loc2_ = MainToolBar.instance.getButtnByType(2) as DisplayObject;
            _loc4_ = _loc2_.parent.localToGlobal(new Point(_loc2_.getBounds(_loc2_.parent).x,_loc2_.getBounds(_loc2_.parent).y));
            TweenMax.to(param1,2,{
               "bezierThrough":[{
                  "x":param1.x,
                  "y":param1.y
               },{
                  "x":_loc4_.x,
                  "y":_loc4_.y
               }],
               "scaleX":0.6,
               "scaleY":0.6,
               "orientToBezier":false,
               "ease":Quart.easeOut,
               "onComplete":_moveComplete,
               "onCompleteParams":[param1]
            });
         }
         catch(e:Error)
         {
         }
      }
      
      private function _moveComplete(param1:BaseIconView) : void
      {
         TweenMax.to(param1,0.5,{
            "alpha":0,
            "onComplete":disapearComplete,
            "onCompleteParams":[param1]
         });
      }
      
      private function disapearComplete(param1:BaseIconView) : void
      {
         ObjectUtils.disposeObject(param1);
      }
      
      private function refreshDrawTimes() : void
      {
         _drawTimeValue.text = "" + FrameControllerManager.instance.funnyControler.luckDrawCount;
         if(int(_drawTimeValue.text) <= 0)
         {
            _drawButton.enable = false;
         }
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
      
      public function show(param1:*) : void
      {
         _items = param1 as Array;
         setGoods();
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeObject(_turnControl);
         _turnControl = null;
         ObjectUtils.disposeObject(_drawBack);
         _drawBack = null;
         ObjectUtils.disposeObject(_luckDrawBg);
         _luckDrawBg = null;
         ObjectUtils.disposeObject(_drawItemBack);
         _drawItemBack = null;
         ObjectUtils.disposeObject(_drawTimeTxt);
         _drawTimeTxt = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_drawButton);
         _drawButton = null;
         ObjectUtils.disposeObject(_tipTxt);
         _tipTxt = null;
         ObjectUtils.disposeObject(_drawTimeValue);
         _drawTimeValue = null;
         ObjectUtils.disposeAllChildren(_contain);
         ObjectUtils.disposeObject(_contain);
         _contain = null;
         ObjectUtils.disposeObject(_leftTimesBg);
         _leftTimesBg = null;
         if(_goodsItemList)
         {
            while(_goodsItemList.length)
            {
               ObjectUtils.disposeObject(_goodsItemList.pop());
            }
         }
         _goodsItemList = null;
         _items = null;
         super.dispose();
      }
   }
}

