package timebox
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.TimeBoxEvent;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.BoxManager;
   import managers.BoxSocketOutManager;
   import mvc.controler.TimeBoxControler;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.base.BaseBoxGoodsItem;
   import yishi.view.community.TimeDownView;
   
   public class TimeBoxFrame extends Frame
   {
      
      private var _bg:MutipleImage;
      
      private var _receiveBtn:SelectedIconButton;
      
      private var _countDownTxt:FilterFrameText;
      
      private var _countDownValue:TimeDownView;
      
      private var _countDownBack:Bitmap;
      
      private var _list:SimpleTileList;
      
      private var _canReciveBoxIDArr:Array;
      
      private var _boxType:int;
      
      private var _keyValue:int;
      
      private var _boxTemplateList:Dictionary;
      
      public function TimeBoxFrame()
      {
         super();
         initView();
         initEvents();
         refreshView();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get controler() : TimeBoxControler
      {
         return FrameControllerManager.instance.timeBoxControler;
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("box.BG");
         _countDownBack = ComponentFactory.Instance.creatBitmap("asset.box.GetCountDownBg");
         _countDownBack.width = 145;
         _receiveBtn = ComponentFactory.Instance.creatComponentByStylename("box.GetRewardBtn");
         _countDownTxt = ComponentFactory.Instance.creatComponentByStylename("box.CountDownTxt");
         _countDownValue = ComponentFactory.Instance.creatComponentByStylename("box.CountDownValue");
         _list = ComponentFactory.Instance.creatCustomObject("timeBox.goodsList",[4]);
         _countDownTxt.text = LanguageMgr.GetTranslation("securitycode.view.TimeDownTxt");
         _countDownValue.viewLen = 3;
         _countDownValue.x = _countDownTxt.x + _countDownTxt.width + 1;
         _countDownValue.y = _countDownTxt.y;
         addToContent(_bg);
         addToContent(_countDownBack);
         addToContent(_receiveBtn);
         addToContent(_countDownTxt);
         addToContent(_countDownValue);
         addToContent(_list);
      }
      
      private function initEvents() : void
      {
         addEventListener("response",__response);
         _receiveBtn.addEventListener("click",__receiveHandler);
         BoxManager.instance.addEventListener("TIME_COMPLETE",__timerCompleteHandler);
         BoxManager.instance.addEventListener("UPDATE_TIME_BOX",__getHaveTimeBox);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__response);
         _receiveBtn.removeEventListener("click",__receiveHandler);
         BoxManager.instance.removeEventListener("TIME_COMPLETE",__timerCompleteHandler);
         BoxManager.instance.removeEventListener("UPDATE_TIME_BOX",__getHaveTimeBox);
      }
      
      private function __response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 1 || param1.responseCode == 0)
         {
            dispose();
         }
      }
      
      private function __receiveHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(BoxManager.instance.remainTime > 0)
         {
            dispose();
            return;
         }
         if(playerInfo.timeProgress == 0)
         {
            _loc2_ = int(BoxManager.instance.timeBoxList[0]);
         }
         else if(playerInfo.timeGet)
         {
            _loc2_ = int(BoxManager.instance.nextTimePeriod);
         }
         BoxSocketOutManager.sendBoxTime(true,_loc2_);
      }
      
      private function __getHaveTimeBox(param1:TimeBoxEvent) : void
      {
         if(BoxManager.instance.needCountTime)
         {
            refreshView();
         }
         else
         {
            dispose();
         }
      }
      
      private function __timerCompleteHandler(param1:Event) : void
      {
         reveiveEnble = true;
         _countDownValue.timeCount = 0;
         _countDownBack.visible = false;
         _countDownValue.visible = false;
         _countDownTxt.visible = false;
      }
      
      public function set reveiveEnble(param1:Boolean) : void
      {
         _receiveBtn.selected = param1;
         _closeButton.visible = !param1;
         escEnable = !param1;
      }
      
      private function refreshView() : void
      {
         var _loc2_:BaseBoxGoodsItem = null;
         var _loc6_:GoodsInfo = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _list.disposeAllChildren();
         _list.beginChanges();
         var _loc3_:int = int(BoxManager.instance.getCurrentTimePeriod());
         var _loc1_:Array = TempleteManager.instance.timeBoxTemplateCate.getTemplatesByIndex(_loc3_);
         if(_loc1_ == null || _loc1_.length == 0)
         {
            dispose();
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = int(_loc1_[_loc4_].TemplateId);
            _loc6_.count = int(_loc1_[_loc4_].Data);
            _loc2_ = new BaseBoxGoodsItem();
            _loc2_.data = _loc6_;
            _list.addChild(_loc2_);
            _loc4_++;
         }
         _loc5_ = int(_loc1_.length);
         while(_loc5_ < 6)
         {
            _loc2_ = new BaseBoxGoodsItem();
            _list.addChild(_loc2_);
            _loc5_++;
         }
         _list.commitChanges();
         _countDownValue.timeCount = BoxManager.instance.remainTime;
         if(BoxManager.instance.remainTime <= 0)
         {
            _receiveBtn.selected = true;
            _countDownBack.visible = false;
            _countDownValue.visible = false;
            _countDownTxt.visible = false;
         }
         else
         {
            _receiveBtn.selected = false;
            _countDownBack.visible = true;
            _countDownValue.visible = true;
            _countDownTxt.visible = true;
         }
      }
      
      public function show() : void
      {
         SoundManager.instance.play("020",true);
         LayerManager.Instance.addToLayer(this,3,true,false,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvents();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_receiveBtn);
         _receiveBtn = null;
         ObjectUtils.disposeObject(_countDownTxt);
         _countDownTxt = null;
         ObjectUtils.disposeObject(_countDownValue);
         _countDownValue = null;
         ObjectUtils.disposeObject(_countDownBack);
         _countDownBack = null;
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         _canReciveBoxIDArr = null;
         _boxTemplateList = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

