package colosseum
{
   import colosseum.view.ColosseumPlayerItem;
   import colosseum.view.ColosseumSelfView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import mainBar.view.VipCoolDownFrame;
   import manager.LanguageMgr;
   import managers.VIPManager;
   import mvc.module.colosseum.ColosseumModel;
   import yishi.datas.playerinfo.BuildingOrderInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.BuildingManager;
   import yishi.manager.FrameControllerManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   
   public class ColosseumFrame extends Frame
   {
      
      private var _back1:Bitmap;
      
      private var _selfView:ColosseumSelfView;
      
      private var _order:BuildingOrderInfo;
      
      private var _orderback:Bitmap;
      
      private var _orderbutton:BaseButton;
      
      private var _ordertime:FilterFrameText;
      
      private var _effect:MovieClip;
      
      private var _itemList:Array;
      
      private var _timeId:int;
      
      public function ColosseumFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _itemList = [];
         _back1 = ComponentFactory.Instance.creatBitmap("asset.colosseum.FrameBack");
         _selfView = ComponentFactory.Instance.creatCustomObject("colosseum.SelfView");
         _orderback = ComponentFactory.Instance.creatBitmap("asset.queueBar.itemBgImg");
         _orderbutton = ComponentFactory.Instance.creatComponentByStylename("queueBar.StartBtn");
         _ordertime = ComponentFactory.Instance.creatComponentByStylename("queueBar.TimeTextOrder");
         _effect = ComponentFactory.Instance.creatCustomObject("queueBar.ItemMc");
         addToContent(_back1);
         addToContent(_selfView);
         initList();
         _effect.x = 201;
         _effect.y = 324;
         _orderback.width = 155;
         _orderbutton.x = 132;
         _orderbutton.y = 3;
         _ordertime.x = 9;
         _ordertime.y = 1;
         _ordertime.width = 130;
         _orderbutton.visible = true;
         _effect["pos"].addChild(_orderback);
         _effect["pos"].addChild(_orderbutton);
         _effect["pos"].addChild(_ordertime);
         _effect.gotoAndStop(1);
         addToContent(_effect);
         _orderbutton.tipData = LanguageMgr.GetTranslation("mainBar.view.QueueItem.QuickText");
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
      
      private function initList() : void
      {
         var _loc3_:int = 0;
         var _loc1_:ColosseumPlayerItem = null;
         var _loc4_:Vector.<ThaneInfo> = model.heroList;
         var _loc2_:int = int(_loc4_.length);
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("colosseum.PlayerItem_" + _loc3_);
            if(_loc3_ < _loc2_)
            {
               _loc1_.thane = _loc4_[_loc3_];
            }
            _itemList[_loc3_] = _loc1_;
            addToContent(_loc1_);
            _loc3_++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         for each(_order in BuildingManager.instance.model.colosseumOrderList)
         {
            if(_order.remainTime > 0)
            {
               _order.addEventListener("change",__onChange);
               _order.addEventListener("complete",__completeHandler);
               _orderbutton.addEventListener("click",__clickHandler);
               return;
            }
         }
         disposeOrder();
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
      
      protected function __onChange(param1:Event) : void
      {
         if(_order.remainTime > 0)
         {
            _ordertime.text = LanguageMgr.GetTranslation("colosseum.ColosseumFrame.ordertime.text") + DateFormatter.getCountDate(_order.remainTime);
         }
         else
         {
            __completeHandler(null);
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc7_:int = 0;
         var _loc3_:VipCoolDownFrame = null;
         var _loc6_:String = null;
         var _loc8_:String = null;
         var _loc2_:String = null;
         var _loc5_:String = null;
         SoundManager.instance.play("022");
         var _loc4_:Function = coolColosseBack;
         if(VIPManager.Instance.model.vipCoolPrivilege)
         {
            _loc4_(true,_order.orderId);
         }
         else
         {
            _loc7_ = Math.ceil(_order.remainTime / 60);
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("queueBar.VipCoolDownFrame");
            _loc6_ = LanguageMgr.GetTranslation("buildings.seminary.view.SeminaryFrameBottomView.quickFrameTipName");
            _loc8_ = LanguageMgr.GetTranslation("buildings.seminary.view.SeminaryFrameBottomView.quickFrameTipContent",_loc7_);
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc5_ = LanguageMgr.GetTranslation("public.cancel");
            _loc3_.initData(_loc6_,_loc8_,_order.orderId,_loc7_,_loc7_,_loc4_,_loc2_,_loc5_);
            _loc3_.show();
         }
      }
      
      private function coolColosseBack(param1:Boolean, param2:int = 0, param3:int = 0, param4:Boolean = true) : void
      {
         if(param1)
         {
            SocketSendManager.instance.sendCoolColosseun(param3,param4);
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
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_order)
         {
            _order.removeEventListener("change",__onChange);
            _order.removeEventListener("complete",__completeHandler);
         }
         if(_orderbutton)
         {
            _orderbutton.removeEventListener("click",__clickHandler);
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
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("colosseum.ColosseumFrame.titleText");
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      public function getColosseumItemByIndex(param1:int) : ColosseumPlayerItem
      {
         return _itemList[param1];
      }
      
      private function get model() : ColosseumModel
      {
         return FrameControllerManager.instance.colosseumControler.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back1);
         _back1 = null;
         ObjectUtils.disposeObject(_selfView);
         _selfView = null;
         for each(var _loc1_:ColosseumPlayerItem in _itemList)
         {
            _loc1_.dispose();
         }
         if(_itemList)
         {
            _itemList.length = 0;
         }
         _itemList = null;
         super.dispose();
      }
   }
}

