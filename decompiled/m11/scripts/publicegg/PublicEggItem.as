package publicegg
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.sumpassion.EggMsg;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.PublicEggManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.DateFormatter;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   
   public class PublicEggItem extends Component
   {
      
      private var _eggMsg:EggMsg;
      
      private var _itemBg:Bitmap;
      
      private var _beerImage:ScaleFrameImage;
      
      private var _freeBtn:IconButton;
      
      private var _exchargeBtn:IconButton;
      
      private var _receiveBtn:IconButton;
      
      private var _leftTimeTxt:FilterFrameText;
      
      private var _openingTxt:Bitmap;
      
      private var _timer:Timer;
      
      private var _numberAsset:BitmapData;
      
      private var _container1:Component;
      
      private var _leftTime:Number;
      
      public function PublicEggItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _itemBg = ComponentFactory.Instance.creatBitmap("asset.publicegg.egg.itemBg");
         _beerImage = ComponentFactory.Instance.creatComponentByStylename("publicegg.egg.beerFrameImage");
         _freeBtn = ComponentFactory.Instance.creatComponentByStylename("publicegg.egg.freeBtn");
         _exchargeBtn = ComponentFactory.Instance.creatComponentByStylename("publicegg.egg.exchargeBtn");
         _receiveBtn = ComponentFactory.Instance.creatComponentByStylename("publicegg.egg.receiveBtn");
         _openingTxt = ComponentFactory.Instance.creatBitmap("asset.publicegg.egg.openingTxt");
         _leftTimeTxt = ComponentFactory.Instance.creatComponentByStylename("publicegg.item.leftTimeTxt");
         _numberAsset = ComponentFactory.Instance.creatBitmapData("asset.publicegg.egg.exchargeNum");
         _container1 = new Component();
         addChild(_itemBg);
         addChild(_beerImage);
         addChild(_freeBtn);
         addChild(_exchargeBtn);
         addChild(_receiveBtn);
         addChild(_openingTxt);
         addChild(_leftTimeTxt);
         addChild(_container1);
         _container1.mouseEnabled = _container1.mouseChildren = false;
         _beerImage.buttonMode = true;
         if(_timer == null)
         {
            _timer = new Timer(1000);
            _timer.addEventListener("timer",timeHandler);
         }
      }
      
      private function initEvent() : void
      {
         _freeBtn.addEventListener("click",__freeHandler);
         _exchargeBtn.addEventListener("click",__exchargeHandler);
         _receiveBtn.addEventListener("click",__receiveHandler);
         _beerImage.addEventListener("click",__beerImageHandler);
      }
      
      private function removeEvent() : void
      {
         _freeBtn.removeEventListener("click",__freeHandler);
         _exchargeBtn.removeEventListener("click",__exchargeHandler);
         _receiveBtn.removeEventListener("click",__receiveHandler);
         _beerImage.removeEventListener("click",__beerImageHandler);
      }
      
      private function __freeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         PublicEggManager.instance.OperateEggReq(2,_eggMsg.profile);
      }
      
      private function __exchargeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         SimpleAlertHelper.instance.data = [alertHandler];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("publicegg.PublicEggItem.exchargeBtn",_eggMsg.needPoint);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true);
      }
      
      private function alertHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.point < _eggMsg.needPoint)
            {
               RechargeAlertMannager.show();
               return;
            }
            PublicEggManager.instance.OperateEggReq(2,_eggMsg.profile);
         }
      }
      
      private function __receiveHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         PublicEggManager.instance.OperateEggReq(2,_eggMsg.profile);
      }
      
      private function __beerImageHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("publicegg",3,_eggMsg);
      }
      
      public function set index(param1:int) : void
      {
         _beerImage.setFrame(param1);
      }
      
      public function set data(param1:EggMsg) : void
      {
         _eggMsg = param1;
         _freeBtn.visible = false;
         _exchargeBtn.visible = false;
         _receiveBtn.visible = false;
         _openingTxt.visible = false;
         _leftTimeTxt.visible = false;
         _container1.visible = false;
         _leftTime = _eggMsg.leftTime;
         if(_eggMsg.buttonState == 1)
         {
            _timer.start();
         }
         else
         {
            _timer.stop();
         }
         timeHandler(null);
         NumberViewUtils.refreshValue(_eggMsg.needPoint,_container1,_numberAsset,14,18,12,14,"0123456789");
         _container1.x = _eggMsg.needPoint > 100 ? 75 : 75;
         _container1.y = 141;
         switch(int(_eggMsg.buttonState))
         {
            case 0:
               _freeBtn.visible = true;
               _leftTimeTxt.visible = true;
               _leftTimeTxt.text = LanguageMgr.GetTranslation("publicegg.publicEggItem.startTime",_eggMsg.needTime);
               break;
            case 1:
               _openingTxt.visible = true;
               _leftTimeTxt.visible = true;
               break;
            case 2:
               _exchargeBtn.visible = true;
               _container1.visible = true;
               break;
            case 3:
               _receiveBtn.visible = true;
               _leftTimeTxt.visible = true;
         }
      }
      
      private function timeHandler(param1:TimerEvent) : void
      {
         var _loc4_:String = null;
         var _loc2_:int = _leftTime;
         var _loc3_:Number = _loc2_;
         if(_loc3_ > 0)
         {
            if(_loc3_ >= 60)
            {
               _leftTimeTxt.text = LanguageMgr.GetTranslation("publicegg.publicEggItem.checkRestTime",DateFormatter.getFullTimeString(_loc3_));
            }
            else
            {
               _loc4_ = LanguageMgr.GetTranslation("funny.groupbuy.buyRestTimeSecond",_loc3_);
               _leftTimeTxt.text = LanguageMgr.GetTranslation("publicegg.publicEggItem.checkRestTime",_loc4_);
            }
         }
         else
         {
            _leftTimeTxt.text = LanguageMgr.GetTranslation("publicegg.publicEggItem.checkOver");
            _timer.stop();
         }
         _leftTime = _leftTime - 1;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeObject(_beerImage);
         _beerImage = null;
         ObjectUtils.disposeObject(_freeBtn);
         _freeBtn = null;
         ObjectUtils.disposeObject(_exchargeBtn);
         _exchargeBtn = null;
         ObjectUtils.disposeObject(_receiveBtn);
         _receiveBtn = null;
         ObjectUtils.disposeObject(_leftTimeTxt);
         _leftTimeTxt = null;
         ObjectUtils.disposeObject(_openingTxt);
         _openingTxt = null;
         ObjectUtils.disposeObject(_numberAsset);
         _numberAsset = null;
         ObjectUtils.disposeObject(_container1);
         _container1 = null;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",timeHandler);
            _timer = null;
         }
         _eggMsg = null;
         super.dispose();
      }
   }
}

