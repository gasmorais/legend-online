package dayguide
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quart;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import dayguide.manager.DayGuideTurnControl;
   import events.DayGuideEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.net.FileReference;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.DayGuideManager;
   import managers.VIPManager;
   import mvc.controler.DayGuideController;
   import mvc.module.dayGuide.DayGuideCatecory;
   import mvc.module.dayGuide.LeadRewardTempInfo;
   import mvc.module.vip.VIPModel;
   import ui.maintoolbar.MainToolBar;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.InfoTipsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class LuckDrawView extends Sprite implements Disposeable
   {
      
      private var _callBack:Function = null;
      
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
      
      private var _getGoodsChacle:Boolean;
      
      private var _container:Sprite;
      
      private var _leftTimesBg:Bitmap;
      
      private var _index:int = 1;
      
      private var _templateId:int;
      
      public function LuckDrawView(param1:Function = null)
      {
         _callBack = param1;
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:LuckDrawGoodsItem = null;
         _back = ComponentFactory.Instance.creatComponentByStylename("dayGuide.LuckDrawView.Back");
         _luckDrawBg = ComponentFactory.Instance.creatBitmap("asset.dayGuide.LuckDrawBg");
         _drawBack = ComponentFactory.Instance.creatBitmap("asset.dayGuide.luckDrawBack");
         _drawItemBack = ComponentFactory.Instance.creatBitmap("asset.dayGuide.luckDrawBack1");
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("dayGuide.tipText");
         _drawTimeTxt = ComponentFactory.Instance.creatBitmap("asset.dayGuide.drawTimeText");
         _drawTimeValue = ComponentFactory.Instance.creatComponentByStylename("dayGuide.drawTimeValueText");
         _drawButton = ComponentFactory.Instance.creatComponentByStylename("dayGuide.DrawButton");
         _container = new Sprite();
         _leftTimesBg = ComponentFactory.Instance.creatBitmap("asset.dayGuide.leftTimesBg");
         addChild(_back);
         addChild(_luckDrawBg);
         addChild(_container);
         _container.x = 16;
         _container.y = -20;
         _container.addChild(_drawBack);
         _container.addChild(_drawItemBack);
         _container.addChild(_drawButton);
         addChild(_leftTimesBg);
         addChild(_drawTimeTxt);
         addChild(_drawTimeValue);
         addChild(_tipTxt);
         _tipTxt.text = LanguageMgr.GetTranslation("dayGuide.view.luckDrawTimeWarn");
         _goodsItemList = new Vector.<LuckDrawGoodsItem>();
         _loc2_ = 1;
         while(_loc2_ < 10)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("dayGuide.LuckDrawGoodsItem" + _loc2_);
            _loc1_.scaleX = _loc1_.scaleY = 0.6;
            _loc1_.name = "LuckDrawGoodsItem" + _loc2_;
            _container.addChild(_loc1_);
            _goodsItemList.push(_loc1_);
            _loc2_++;
         }
         _setGoods();
         refreshDrawTimes(playerInfo.leadExtractTimes);
         _turnControl = new DayGuideTurnControl();
         _turnControl.defaultTurn(_goodsItemList);
      }
      
      private function _setGoods() : void
      {
         var _loc1_:LeadRewardTempInfo = null;
         var _loc4_:Dictionary = TempleteManager.instance.dayGuideDropTemplateCate.getTemplates();
         var _loc2_:int = 0;
         for(var _loc3_:String in _loc4_)
         {
            _loc1_ = _loc4_[_loc3_] as LeadRewardTempInfo;
            _goodsItemList[_loc2_].data1 = null;
            _loc2_ += 1;
         }
      }
      
      private function initEvents() : void
      {
         _drawButton.addEventListener("click",_darawHandler);
         cate.addEventListener("REWARDPOS_CHANGE",__onPosChangeHandler);
         cate.addEventListener("ACTIVE_CHANGE",__onUpdataHandler);
         cate.addEventListener("ExtractTimes_CHANGE",__onUpdataHandler);
         NotificationManager.instance.addEventListener("ON_DRAW_COMPLETE",__onBlessComplete);
         NotificationManager.instance.addEventListener("POP_GOODS",__onGoosComplete);
      }
      
      private function removeEvent() : void
      {
         if(_drawButton)
         {
            _drawButton.removeEventListener("click",_darawHandler);
         }
         cate.removeEventListener("REWARDPOS_CHANGE",__onPosChangeHandler);
         cate.removeEventListener("ACTIVE_CHANGE",__onUpdataHandler);
         cate.removeEventListener("ExtractTimes_CHANGE",__onUpdataHandler);
         NotificationManager.instance.removeEventListener("ON_DRAW_COMPLETE",__onBlessComplete);
         NotificationManager.instance.removeEventListener("POP_GOODS",__onGoosComplete);
      }
      
      private function _darawHandler(param1:MouseEvent) : void
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
         control.sendLuckDraw(1);
         _getGoodsChacle = true;
         _callBack(false);
         _drawButton.enable = false;
         NotificationManager.instance.dispatchEvent(new DayGuideEvent("POP_GOODS_MOVIE"));
      }
      
      private function _gifHandler(param1:MouseEvent) : void
      {
         if(vipModel.vipInfo.IsTakeGift && Boolean(vipModel.vipInfo.IsVipAndNoExpirt))
         {
            FrameControllerManager.instance.openControllerByInfo("vip",VIPModel.OPEN_GIFT_FRAME);
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("vip");
         }
      }
      
      private function _clientDownClick(param1:MouseEvent) : void
      {
         var _loc6_:String = null;
         var _loc4_:String = null;
         SoundManager.instance.play("022");
         var _loc7_:String = PathManager.getClientLoginPath();
         var _loc3_:String = PathManager.getClientLoginName() + ".exe";
         if(_loc7_.substr(-3) != "exe")
         {
            _loc6_ = PlayerManager.instance.currentPlayerModel.userInfo.user;
            _loc4_ = PlayerManager.instance.currentPlayerModel.userInfo.site;
            if(_loc7_.indexOf("?") == -1)
            {
               _loc7_ += "?";
            }
            else
            {
               _loc7_ += "&";
            }
            _loc7_ += "u=" + _loc6_ + "&site=" + _loc4_;
         }
         _loc7_ = encodeURI(_loc7_);
         var _loc2_:URLRequest = new URLRequest(_loc7_);
         var _loc5_:FileReference = new FileReference();
         _loc5_.download(_loc2_,_loc3_);
      }
      
      private function __onUpdataHandler(param1:DayGuideEvent) : void
      {
         refreshDrawTimes(cate.leadExtractTimes);
      }
      
      private function __onPosChangeHandler(param1:DayGuideEvent) : void
      {
         if(cate.rewardTemplateId == 0)
         {
            if(_drawButton)
            {
               _drawButton.enable = true;
            }
            _callBack(true);
            return;
         }
         _index = 1;
         var _loc3_:Dictionary = TempleteManager.instance.dayGuideDropTemplateCate.getTemplates();
         for(var _loc2_:String in _loc3_)
         {
            if(int(_loc2_) == cate.rewardTemplateId)
            {
               break;
            }
            _index += 1;
         }
         _turnControl.turnPlate(_index);
         refreshDrawTimes(cate.leadExtractTimes);
      }
      
      private function __onBlessComplete(param1:DayGuideEvent) : void
      {
         var icon:BaseIconView;
         var _timeId:uint;
         var evt:DayGuideEvent = param1;
         _callBack(true);
         control.sendLuckDraw(2);
         _getGoodsChacle = false;
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
      
      private function refreshDrawTimes(param1:int) : void
      {
         var _loc3_:int = int(cate.active);
         var _loc2_:int = 0;
         if(vipModel.vipInfo.IsVipAndNoExpirt)
         {
            _loc2_ += 2;
         }
         if(_loc3_ >= 115)
         {
            _loc2_ += 4;
         }
         else if(_loc3_ >= 85)
         {
            _loc2_ += 3;
         }
         else if(_loc3_ >= 45)
         {
            _loc2_ += 2;
         }
         else if(_loc3_ >= 15)
         {
            _loc2_ += 1;
         }
         InfoTipsManager.instance.updateValue(27,_loc2_ - param1);
         _drawTimeValue.text = (_loc2_ - param1).toString();
      }
      
      public function getInitDrawTime() : int
      {
         var _loc2_:int = int(cate.active);
         var _loc1_:int = 0;
         if(vipModel.vipInfo.IsVipAndNoExpirt)
         {
            _loc1_ += 2;
         }
         if(_loc2_ >= 115)
         {
            _loc1_ += 4;
         }
         else if(_loc2_ >= 85)
         {
            _loc1_ += 3;
         }
         else if(_loc2_ >= 45)
         {
            _loc1_ += 2;
         }
         else if(_loc2_ >= 15)
         {
            _loc1_ += 1;
         }
         return _loc1_ - playerInfo.leadExtractTimes;
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
            _loc3_ = this._container.getChildByName("LuckDrawGoodsItem" + _index) as LuckDrawGoodsItem;
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
      
      private function get vipModel() : VIPModel
      {
         return VIPManager.Instance.model;
      }
      
      private function get cate() : DayGuideCatecory
      {
         return DayGuideManager.instance.cate;
      }
      
      private function get control() : DayGuideController
      {
         return FrameControllerManager.instance.dayGuideController;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         _callBack = null;
         if(_getGoodsChacle)
         {
            control.sendLuckDraw(2);
            _getGoodsChacle = false;
         }
         removeEvent();
         if(_goodsItemList != null)
         {
            _loc1_ = 0;
            while(_loc1_ < _goodsItemList.length)
            {
               ObjectUtils.disposeObject(_goodsItemList[_loc1_]);
               _goodsItemList[_loc1_] = null;
               _loc1_++;
            }
            _goodsItemList = null;
         }
         ObjectUtils.disposeObject(_turnControl);
         _turnControl = null;
         ObjectUtils.disposeObject(_leftTimesBg);
         _leftTimesBg = null;
         ObjectUtils.disposeObject(_tipTxt);
         _tipTxt = null;
         ObjectUtils.disposeObject(_drawTimeValue);
         _drawTimeValue = null;
         ObjectUtils.disposeObject(_drawTimeTxt);
         _drawTimeTxt = null;
         ObjectUtils.disposeObject(_drawBack);
         _drawBack = null;
         ObjectUtils.disposeObject(_luckDrawBg);
         _luckDrawBg = null;
         ObjectUtils.disposeObject(_drawItemBack);
         _drawItemBack = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_drawButton);
         _drawButton = null;
         ObjectUtils.disposeAllChildren(_container);
         _container = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

