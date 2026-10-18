package consortia.view.myConsortia.treasure
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import consortia.net.ConsortiaSocektSendManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.OthersTreasureInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ConsortiaTreasureTemplateInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.community.TimeDownView;
   import yishi.view.tips.MessageTipManager;
   
   public class TreasureHelpItem extends Component
   {
      
      private var _data:OthersTreasureInfo;
      
      private var bg:Bitmap;
      
      private var _ProgressBg:Bitmap;
      
      private var _ProgressShape:Bitmap;
      
      private var _ProgressRec:Sprite;
      
      private var _ProgressTotal:Number;
      
      private var _itemView:BaseItemView;
      
      private var _SpeedUptn:IconButton;
      
      private var _ReceiveBtn:IconButton;
      
      private var _OpenBtn:IconButton;
      
      private var _title:FilterFrameText;
      
      private var _name:FilterFrameText;
      
      private var _time:FilterFrameText;
      
      private var _ProgressTxt:FilterFrameText;
      
      private var _Progress:TimeDownView;
      
      private var _timeTimeDown:TimeDownView;
      
      private var _hbox:HBox;
      
      public var index:int;
      
      private var tmpinfo:ConsortiaTreasureTemplateInfo;
      
      private var NowTime:Number;
      
      private var result:Number;
      
      public function TreasureHelpItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         bg = ComponentFactory.Instance.creatBitmap("asset.consortia.TreasureItemBg2");
         _ProgressBg = ComponentFactory.Instance.creatBitmap("asset.consortia.HelpItemProgressBg");
         _ProgressShape = ComponentFactory.Instance.creatBitmap("asset.consortia.HelpItemProgress");
         _ProgressRec = new Sprite();
         _ProgressRec.graphics.beginFill(16711680);
         _ProgressRec.graphics.drawRect(0,0,_ProgressShape.width,_ProgressShape.height);
         _itemView = ComponentFactory.Instance.creatCustomObject("consortia.TreasureHelpItem.ItemView");
         _SpeedUptn = ComponentFactory.Instance.creatComponentByStylename("consortia.TreasureHelpItem.SpeedUptn");
         _ReceiveBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.TreasureHelpItem.ReceiveBtn");
         _OpenBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.TreasureHelpItem.OpenBtn");
         _title = ComponentFactory.Instance.creatComponentByStylename("consortia.TreasureHelpItem.title");
         _name = ComponentFactory.Instance.creatComponentByStylename("consortia.TreasureHelpItem.name");
         _time = ComponentFactory.Instance.creatComponentByStylename("consortia.TreasureHelpItem.time");
         _ProgressTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.TreasureItem.ProgressTxt");
         _Progress = ComponentFactory.Instance.creatComponentByStylename("consortia.TreasureItem.ProgressTimeDown");
         _timeTimeDown = ComponentFactory.Instance.creatComponentByStylename("consortia.MyTreasureItem.timeTimeDown");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("consortia.TreasureHelpItem.Hbox");
         addChild(bg);
         addChild(_ProgressBg);
         addChild(_ProgressShape);
         addChild(_ProgressRec);
         _ProgressRec.x = _ProgressShape.x;
         _ProgressRec.y = _ProgressShape.y;
         _ProgressRec.scaleX = 0;
         _ProgressShape.mask = _ProgressRec;
         addChild(_itemView);
         addChild(_ReceiveBtn);
         addChild(_SpeedUptn);
         addChild(_OpenBtn);
         addChild(_title);
         _title.text = "";
         addChild(_time);
         _time.text = "";
         addChild(_name);
         _name.text = "";
         addChild(_ProgressTxt);
         _ProgressTxt.text = "";
         addChild(_Progress);
         _ProgressTxt.text = "";
         _timeTimeDown.visible = false;
         addChild(_timeTimeDown);
         addChild(_hbox);
      }
      
      public function set data(param1:OthersTreasureInfo) : void
      {
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:GoodsInfo = null;
         var _loc3_:BaseItemView = null;
         if(!param1)
         {
            return;
         }
         _data = param1;
         tmpinfo = ConsortiaManager.instance.getTreasureTempByID(_data.treasureTemplateId);
         _title.text = tmpinfo.TemplateName;
         _title.setFrame(tmpinfo.Quality);
         _name.text = _data.ownerName;
         NowTime = PlayerManager.instance.currentPlayerModel.nowDate;
         result = _data.openTime + tmpinfo.RewardSeconds * 1000 - NowTime;
         if(_data.status == 2)
         {
            openTreasure(2);
         }
         else if(_data.status == 1)
         {
            openTreasure(1);
         }
         else
         {
            openTreasure(0);
            _timeTimeDown.timeCount = Math.ceil(result / 1000);
         }
         var _loc2_:String = IconFactory.getPlayerIcon(_data.ownerHeadId,"head");
         _itemView.icon.icon = _loc2_;
         var _loc4_:Array = tmpinfo.HelperDrop.split("|");
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc6_ = _loc4_[_loc5_].split(",");
            _loc7_ = new GoodsInfo();
            _loc7_.templateId = int(_loc6_[0]);
            _loc7_.count = int(_loc6_[1]);
            _loc3_ = ComponentFactory.Instance.creatCustomObject("consortia.TreasureItem.HBoxItem");
            _loc3_.data = _loc7_;
            _hbox.addChild(_loc3_);
            _loc5_++;
         }
         refesh();
      }
      
      public function set noOpen(param1:Boolean) : void
      {
         if(param1)
         {
            _OpenBtn.enable = true;
         }
         else
         {
            _OpenBtn.enable = false;
         }
      }
      
      private function openTreasure(param1:int) : void
      {
         if(param1 == 0)
         {
            _time.text = LanguageMgr.GetTranslation("consortia.TreasureItem.time") + refreshTime(tmpinfo.RewardSeconds);
            _ProgressTxt.text = "";
            _Progress.pause();
            _ReceiveBtn.visible = false;
            _OpenBtn.visible = true;
            _SpeedUptn.visible = _ProgressShape.visible = _ProgressBg.visible = false;
         }
         else if(param1 == 1)
         {
            _time.text = "";
            _ProgressTxt.text = LanguageMgr.GetTranslation("consortia.MyTreasureItem.ProgressTxt");
            _ProgressTotal = tmpinfo.RewardSeconds;
            _Progress.timeCount = int((_data.newHelpRewardTime - NowTime) / 1000) - 2;
            _ProgressRec.scaleX = 1 - _Progress.timeCount / _ProgressTotal;
            _ReceiveBtn.visible = false;
            _OpenBtn.visible = false;
            _SpeedUptn.visible = _ProgressShape.visible = _ProgressBg.visible = true;
         }
         else if(param1 == 2)
         {
            _time.text = "";
            _ProgressTxt.text = "";
            _Progress.pause();
            _ReceiveBtn.visible = true;
            _OpenBtn.visible = false;
            _SpeedUptn.visible = _ProgressShape.visible = _ProgressBg.visible = false;
         }
         refesh();
      }
      
      private function refesh() : void
      {
         if(_Progress.timeCount == 0)
         {
            _ProgressRec.scaleX = 1;
         }
      }
      
      private function _SpeedUptnHandle(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc4_:int = model.speed_up_costArr[0] * Math.ceil(_Progress.timeCount / 600);
         SimpleAlertHelper.instance.data = [_BtnResultHandle,_loc4_];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc6_:String = LanguageMgr.GetTranslation("consortia.TreasureList.speedup.alertText",_loc4_);
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,true,true,2);
      }
      
      private function _BtnResultHandle(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(param1)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.point >= param3)
            {
               ConsortiaSocektSendManager.sendOpenTreasure(7,1,_data.treasureId);
               NotificationManager.instance.sendNotification("MYTREASURE_REMOVE",index);
            }
            else
            {
               RechargeAlertMannager.show();
            }
         }
      }
      
      private function _ReceiveBtnHandle(param1:MouseEvent) : void
      {
         _ReceiveBtn.enable = false;
         ConsortiaSocektSendManager.sendOpenTreasure(6,-1,_data.treasureId);
      }
      
      private function _OpenBtnHandle(param1:MouseEvent) : void
      {
         if(model.treasureGroupInfo.helpLeftCount <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.TreasureHelp.leftCount"));
         }
         else
         {
            _OpenBtn.enable = false;
            ConsortiaSocektSendManager.sendOpenTreasure(5,-1,_data.treasureId);
         }
      }
      
      private function __ProgressCompleteHandler(param1:Event) : void
      {
         openTreasure(2);
         ConsortiaSocektSendManager.sendOpenTreasure(2);
      }
      
      private function __ProgressUpDataHandler(param1:Event) : void
      {
         _ProgressRec.scaleX = 1 - _Progress.timeCount / _ProgressTotal;
      }
      
      private function __timeCompleteHandler(param1:Event) : void
      {
         ConsortiaSocektSendManager.sendOpenTreasure(2);
      }
      
      private function initEvent() : void
      {
         _ReceiveBtn.addEventListener("click",_ReceiveBtnHandle);
         _SpeedUptn.addEventListener("click",_SpeedUptnHandle);
         _OpenBtn.addEventListener("click",_OpenBtnHandle);
         _Progress.addEventListener("timerDown_updata",__ProgressUpDataHandler);
         _Progress.addEventListener("timerDown_complete",__ProgressCompleteHandler);
         _timeTimeDown.addEventListener("timerDown_complete",__timeCompleteHandler);
      }
      
      private function removeEvent() : void
      {
         if(_ReceiveBtn)
         {
            _ReceiveBtn.removeEventListener("click",_ReceiveBtnHandle);
         }
         if(_SpeedUptn)
         {
            _SpeedUptn.removeEventListener("click",_SpeedUptnHandle);
         }
         if(_OpenBtn)
         {
            _OpenBtn.removeEventListener("click",_OpenBtnHandle);
         }
         if(_Progress)
         {
            _Progress.removeEventListener("timerDown_updata",__ProgressUpDataHandler);
         }
         if(_Progress)
         {
            _Progress.removeEventListener("timerDown_complete",__ProgressCompleteHandler);
         }
         if(_timeTimeDown)
         {
            _timeTimeDown.removeEventListener("timerDown_complete",__timeCompleteHandler);
         }
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      private function refreshTime(param1:int) : String
      {
         var _loc5_:* = null;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         if(param1 >= 3600)
         {
            _loc3_ = param1 / 3600;
         }
         if(param1 >= 60)
         {
            _loc7_ = param1 % 3600 / 60;
         }
         _loc6_ = param1 % 3600 % 60;
         var _loc4_:String = _loc3_ >= 10 ? _loc3_.toString() : "0" + _loc3_;
         var _loc8_:String = _loc7_ >= 10 ? _loc7_.toString() : "0" + _loc7_;
         var _loc2_:String = _loc6_ >= 10 ? _loc6_.toString() : "0" + _loc6_;
         return _loc4_ + ": " + _loc8_ + ": " + _loc2_;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(bg)
         {
            ObjectUtils.disposeObject(bg);
         }
         bg = null;
         if(_ProgressBg)
         {
            ObjectUtils.disposeObject(_ProgressBg);
         }
         _ProgressBg = null;
         if(_ProgressShape)
         {
            ObjectUtils.disposeObject(_ProgressShape);
         }
         _ProgressShape = null;
         if(_ProgressRec)
         {
            ObjectUtils.disposeObject(_ProgressRec);
         }
         _ProgressRec = null;
         if(_itemView)
         {
            ObjectUtils.disposeObject(_itemView);
         }
         _itemView = null;
         if(_SpeedUptn)
         {
            ObjectUtils.disposeObject(_SpeedUptn);
         }
         _SpeedUptn = null;
         if(_OpenBtn)
         {
            ObjectUtils.disposeObject(_OpenBtn);
         }
         _OpenBtn = null;
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = null;
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
         }
         _name = null;
         if(_time)
         {
            ObjectUtils.disposeObject(_time);
         }
         _time = null;
         if(_ProgressTxt)
         {
            ObjectUtils.disposeObject(_ProgressTxt);
         }
         _ProgressTxt = null;
         if(_Progress)
         {
            ObjectUtils.disposeObject(_Progress);
         }
         _Progress = null;
         if(_timeTimeDown)
         {
            ObjectUtils.disposeObject(_timeTimeDown);
         }
         _timeTimeDown = null;
         if(_hbox)
         {
            ObjectUtils.disposeObject(_hbox);
         }
         _hbox = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

