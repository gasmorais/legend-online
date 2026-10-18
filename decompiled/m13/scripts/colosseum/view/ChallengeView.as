package colosseum.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.VIPEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import mainBar.view.VipCoolDownFrame;
   import manager.LanguageMgr;
   import managers.ChallengeManager;
   import managers.VIPManager;
   import mvc.module.colosseum.ColosseumModel;
   import yishi.SwitchPageHelp;
   import yishi.datas.playerinfo.BuildingOrderInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.BuildingManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   
   public class ChallengeView extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _leftChallengeView:ChallengeLeftView;
      
      private var _topChallengeView:ChallengeTopView;
      
      private var _middleChallengeView:ChallengeMiddleView;
      
      private var _returnBtn:BaseButton;
      
      private var _hasNumTxt:Bitmap;
      
      private var _numTxtFiled:FilterFrameText;
      
      private var _numTxt:Bitmap;
      
      private var _order:BuildingOrderInfo;
      
      private var _orderback:Bitmap;
      
      private var _orderbutton:BaseButton;
      
      private var _ordertime:FilterFrameText;
      
      private var _effect:MovieClip;
      
      private var _hasBuyNumTxt:Bitmap;
      
      private var _timeId:int;
      
      public function ChallengeView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.challenge.bg");
         _topChallengeView = ComponentFactory.Instance.creatCustomObject("colosseum.ChallengeTopView");
         _returnBtn = ComponentFactory.Instance.creatComponentByStylename("colosseum.returnBtn");
         _leftChallengeView = ComponentFactory.Instance.creatCustomObject("colosseum.ChallengeLeftView");
         _middleChallengeView = ComponentFactory.Instance.creatCustomObject("colosseum.ChallengeMiddleView");
         _numTxt = ComponentFactory.Instance.creatBitmap("asset.colosseum.TodayCount2");
         _hasNumTxt = ComponentFactory.Instance.creatBitmap("asset.challenge.hasNumTxt");
         _hasBuyNumTxt = ComponentFactory.Instance.creatBitmap("asset.colosseum.BuyCountTxtImg");
         _numTxtFiled = ComponentFactory.Instance.creatComponentByStylename("colosseum.challengeMiddleView.hasNumTxt");
         _orderback = ComponentFactory.Instance.creatBitmap("asset.queueBar.itemBgImg");
         _orderbutton = ComponentFactory.Instance.creatComponentByStylename("queueBar.StartBtn");
         _ordertime = ComponentFactory.Instance.creatComponentByStylename("queueBar.TimeTextOrder");
         _effect = ComponentFactory.Instance.creatCustomObject("queueBar.ItemMc");
         addChild(_bg);
         addChild(_leftChallengeView);
         addChild(_topChallengeView);
         addChild(_returnBtn);
         addChild(_middleChallengeView);
         addChild(_hasNumTxt);
         _hasNumTxt.y = 161;
         addChild(_hasBuyNumTxt);
         _hasBuyNumTxt.visible = false;
         addChild(_numTxt);
         _numTxt.y = 165;
         addChild(_numTxtFiled);
         _numTxtFiled.text = "99";
         _orderback.width = 155;
         _orderbutton.x = 132;
         _orderbutton.y = 3;
         _ordertime.x = 3;
         _ordertime.y = 2;
         _ordertime.width = 130;
         _orderbutton.visible = true;
         _effect["pos"].addChild(_orderback);
         _effect["pos"].addChild(_orderbutton);
         _effect["pos"].addChild(_ordertime);
         _effect.gotoAndStop(1);
         _orderbutton.tipData = LanguageMgr.GetTranslation("mainBar.view.QueueItem.QuickText");
         addChild(_effect);
         for each(_order in BuildingManager.instance.model.colosseumOrderList)
         {
            if(_order.remainTime > 0)
            {
               _orderback.visible = true;
               _orderbutton.visible = true;
               _ordertime.visible = true;
               _order.addEventListener("change",__onChange);
               _order.addEventListener("complete",__completeHandler);
               _orderbutton.addEventListener("click",__clickHandler);
               __UpvipInfoHandler(null);
               return;
            }
            _orderback.visible = false;
            _orderbutton.visible = false;
            _ordertime.visible = false;
         }
      }
      
      private function __completeHandler(param1:Event) : void
      {
         disposeOrder();
         _order.removeEventListener("change",__onChange);
         _order.removeEventListener("complete",__completeHandler);
         if(_orderbutton)
         {
            _orderbutton.removeEventListener("click",__clickHandler);
         }
      }
      
      private function disposeOrder() : void
      {
         ObjectUtils.disposeObject(_orderback);
         _orderback = null;
         ObjectUtils.disposeObject(_orderbutton);
         _orderbutton = null;
         ObjectUtils.disposeObject(_ordertime);
         _ordertime = null;
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc3_:Array = null;
         var _loc8_:int = 0;
         var _loc4_:VipCoolDownFrame = null;
         var _loc7_:String = null;
         var _loc9_:String = null;
         var _loc2_:String = null;
         var _loc6_:String = null;
         SoundManager.instance.play("022");
         var _loc5_:Function = coolColosseBack;
         if(VIPManager.Instance.model.vipCoolPrivilege)
         {
            _loc5_(true,_order.orderId);
         }
         else
         {
            _loc3_ = TempleteManager.instance.getConfigInfoByConfigName("Challenge_Cool").ConfigValue.split(",");
            _loc8_ = Math.ceil(_order.remainTime / (60 * _loc3_[1])) * _loc3_[0];
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("queueBar.VipCoolDownFrame");
            _loc7_ = LanguageMgr.GetTranslation("buildings.seminary.view.SeminaryFrameBottomView.quickFrameTipName");
            _loc9_ = LanguageMgr.GetTranslation("buildings.seminary.view.SeminaryFrameBottomView.quickFrameTipContent",_loc8_);
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc6_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_.initData(_loc7_,_loc9_,_order.orderId,_loc8_,_loc8_,_loc5_,_loc2_,_loc6_);
            _loc4_.show();
         }
      }
      
      private function coolColosseBack(param1:Boolean, param2:int = 0, param3:int = 0, param4:Boolean = true) : void
      {
         if(param1)
         {
            SocketSendManager.instance.sendCoolColosseun(param3,param4);
         }
      }
      
      protected function __onChange(param1:Event) : void
      {
         if(!_order)
         {
            return;
         }
         if(_order.remainTime > 0)
         {
            if(!model)
            {
               return;
            }
            if(model.remainBuyCount <= 0 && model.remainFreeCount <= 0)
            {
               _orderback.visible = false;
               _orderbutton.visible = false;
               _ordertime.visible = false;
               __completeHandler(null);
            }
            _orderback.visible = true;
            _orderbutton.visible = true;
            _ordertime.visible = true;
            _ordertime.text = LanguageMgr.GetTranslation("colosseum.ColosseumFrame.ordertime.text") + DateFormatter.getCountDate(_order.remainTime);
         }
         else
         {
            _orderback.visible = false;
            _orderbutton.visible = false;
            _ordertime.visible = false;
            __completeHandler(null);
         }
      }
      
      public function showEffect() : void
      {
         stopEffect();
         _effect.play();
         _timeId = setTimeout(stopEffect,3000);
      }
      
      public function stopEffect() : void
      {
         clearTimeout(_timeId);
         _effect.gotoAndStop(1);
      }
      
      private function initEvent() : void
      {
         _returnBtn.addEventListener("click",__returnClick);
         NotificationManager.instance.addEventListener("REFRESH_CHALLENGE",refreshView);
         VIPManager.Instance.model.addEventListener("upframeview_change",__UpvipInfoHandler);
      }
      
      private function __UpvipInfoHandler(param1:VIPEvent) : void
      {
         if(VIPManager.Instance.model.vipInfo.IsVipAndNoExpirt)
         {
            SocketSendManager.instance.sendCoolColosseun(0,true);
         }
      }
      
      private function refreshView(param1:NotificationEvent) : void
      {
         if(model.remainFreeCount > 0)
         {
            _hasNumTxt.visible = true;
            _hasBuyNumTxt.visible = false;
            _numTxtFiled.text = model.remainFreeCount.toString();
         }
         else
         {
            _hasNumTxt.visible = false;
            _hasBuyNumTxt.visible = true;
            _numTxtFiled.text = model.remainBuyCount.toString();
            if(model.remainBuyCount <= 0 && model.currentBuyCount <= 0)
            {
               _orderback.visible = false;
               _orderbutton.visible = false;
               _ordertime.visible = false;
               _effect.visible = false;
            }
         }
         _numTxt.x = _numTxtFiled.x + _numTxtFiled.textWidth + 6;
      }
      
      private function removeEvent() : void
      {
         _returnBtn.removeEventListener("click",__returnClick);
         NotificationManager.instance.removeEventListener("REFRESH_CHALLENGE",refreshView);
         if(_order)
         {
            _order.removeEventListener("change",__onChange);
            _order.removeEventListener("complete",__completeHandler);
         }
         if(_orderbutton)
         {
            _orderbutton.removeEventListener("click",__clickHandler);
         }
         VIPManager.Instance.model.removeEventListener("upframeview_change",__UpvipInfoHandler);
      }
      
      private function __returnClick(param1:MouseEvent) : void
      {
         if(ChallengeManager.instance.enterScene == "CASTLE_SCENE")
         {
            SceneManager.instance.setScene("CASTLE_SCENE");
         }
         else
         {
            SwitchPageHelp.enterToSpace();
         }
         ChallengeManager.instance.enterScene = "";
      }
      
      public function resize(param1:int, param2:int) : void
      {
         if(param1 > 1248)
         {
            _bg.x = (param1 - 1248) / 2;
         }
         else
         {
            _bg.x = 0;
         }
         if(param2 > 790)
         {
            _bg.y = (param2 - 790) / 2;
         }
         else
         {
            _bg.y = 0;
         }
         _hasNumTxt.x = param1 - 510;
         _effect.x = param1 - 470;
         _effect.y = 166;
         _hasBuyNumTxt.x = param1 - 478;
         _numTxtFiled.x = param1 - 346;
         _numTxt.x = _numTxtFiled.x + _numTxtFiled.textWidth + 6;
         _hasNumTxt.y = 153;
         _hasBuyNumTxt.y = 155;
         _numTxt.y = 155;
         _numTxtFiled.y = 144;
         _returnBtn.x = param1 - 138;
         _returnBtn.y = 30;
         _middleChallengeView.y = (param2 - 247) / 2 + 247;
         if((param2 - 247) / 2 < 217)
         {
            _middleChallengeView.y = 464;
         }
         _topChallengeView.resize(param1,param2);
         _middleChallengeView.resize(param1,param2,_bg.x);
      }
      
      private function get model() : ColosseumModel
      {
         return ChallengeManager.instance.model;
      }
      
      public function get middleView() : ChallengeMiddleView
      {
         return _middleChallengeView;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_hasNumTxt);
         _hasNumTxt = null;
         ObjectUtils.disposeObject(_numTxtFiled);
         _numTxtFiled = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_hasBuyNumTxt);
         _hasBuyNumTxt = null;
         ObjectUtils.disposeObject(_returnBtn);
         _returnBtn = null;
         _leftChallengeView.dispose();
         ObjectUtils.disposeObject(_leftChallengeView);
         _leftChallengeView = null;
         _topChallengeView.dispose();
         ObjectUtils.disposeObject(_topChallengeView);
         _topChallengeView = null;
         _middleChallengeView.dispose();
         ObjectUtils.disposeObject(_middleChallengeView);
         _middleChallengeView = null;
         __completeHandler(null);
      }
   }
}

