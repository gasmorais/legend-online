package monster
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.campaign.MonsterAccessoryHammerMsg;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.VIPManager;
   import mvc.module.monster.MonsterModel;
   import yishi.comm.PackageIn;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.MonsterManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.TimerUtils;
   import yishi.view.tips.MessageTipManager;
   
   public class MonsterAutoHammerFrame extends Frame
   {
      
      private var _bg:Bitmap;
      
      private var _countBmp:Bitmap;
      
      private var _targetBmp:Bitmap;
      
      private var _countNumBg:Image;
      
      private var _countNumTxt:FilterFrameText;
      
      private var _targetComBox:ComboBox;
      
      private var _txt:FilterFrameText;
      
      private var _startBtn:IconButton;
      
      private var _stopBtn:IconButton;
      
      private var _index:int;
      
      private var _autoStopResult:int = 0;
      
      private var _count:int = -1;
      
      private var _grades:int = -1;
      
      private var _isStart:Boolean = false;
      
      public function MonsterAutoHammerFrame(param1:int)
      {
         super();
         _index = param1;
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("MonsterAutoHammerFrame.title.text");
         _bg = ComponentFactory.Instance.creatBitmap("asset.MonsterAccessoriesView.autoHammerbg");
         _countBmp = ComponentFactory.Instance.creatBitmap("asset.MonsterAccessoriesView.countBmp");
         _targetBmp = ComponentFactory.Instance.creatBitmap("asset.MonsterAccessoriesView.targetBmp");
         _countNumBg = ComponentFactory.Instance.creatComponentByStylename("MonsterAutoHammerFrame.countNumBg");
         _countNumTxt = ComponentFactory.Instance.creatComponentByStylename("MonsterAutoHammerFrame.countNumTxt");
         _targetComBox = ComponentFactory.Instance.creatComponentByStylename("MonsterAutoHammerFrame.targetComBox");
         _txt = ComponentFactory.Instance.creatComponentByStylename("MonsterAutoHammerFrame.txt");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterAutoHammerFrame.startBtn");
         _stopBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterAutoHammerFrame.stopBtn");
         addToContent(_bg);
         addToContent(_countBmp);
         addToContent(_targetBmp);
         addToContent(_countNumBg);
         addToContent(_countNumTxt);
         addToContent(_targetComBox);
         addToContent(_txt);
         addToContent(_stopBtn);
         _stopBtn.visible = false;
         addToContent(_startBtn);
         initData();
      }
      
      private function initData() : void
      {
         var _loc1_:int = 0;
         _countNumTxt.text = "1";
         _txt.text = LanguageMgr.GetTranslation("MonsterAutoHammerFrame.txt.text");
         if(_index > 0)
         {
            _loc1_ = 1;
            while(_loc1_ <= _index)
            {
               _targetComBox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("MonsterAutoHammerFrame.targetComBox.text" + _loc1_));
               _loc1_++;
            }
            _targetComBox.listPanel.list.defaultSelectItemByCellValue = _targetComBox.listPanel.vectorListModel.getElementAt(0);
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _countNumTxt.addEventListener("change",__textChangHandler);
         _startBtn.addEventListener("click",__startBtnClickHandler);
         _stopBtn.addEventListener("click",__stopBtnClickHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 186,__hammerResult);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_countNumTxt)
         {
            _countNumTxt.removeEventListener("change",__textChangHandler);
         }
         if(_startBtn)
         {
            _startBtn.removeEventListener("click",__startBtnClickHandler);
         }
         if(_stopBtn)
         {
            _stopBtn.removeEventListener("click",__stopBtnClickHandler);
         }
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 186,__hammerResult);
      }
      
      private function __hammerResult(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MonsterAccessoryHammerMsg = new MonsterAccessoryHammerMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MonsterAccessoryHammerMsg;
         if(!_loc2_.isAuto)
         {
            return;
         }
         if(_loc2_.success)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MonsterAutoHammerFrame.success.text"));
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MonsterAutoHammerFrame.fail.text"));
         }
         _autoStopResult = _loc2_.autoStopResult;
         if(_loc2_.autoStopResult == 0 && _isStart)
         {
            TimerUtils.setTimeout(hammer,1000);
         }
         else
         {
            TimerUtils.setTimeout(stop,500);
         }
      }
      
      private function stop() : void
      {
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("MonsterAutoHammerFrame.stopText" + _autoStopResult));
         closeButtonEnable = true;
         __stopBtnClickHandler(null);
      }
      
      private function __stopBtnClickHandler(param1:MouseEvent) : void
      {
         if(isDie)
         {
            return;
         }
         _isStart = false;
         _stopBtn.visible = false;
         _startBtn.visible = true;
         _count = -1;
         _grades = -1;
         _countNumTxt.mouseEnabled = true;
         _targetComBox.mouseChildren = _targetComBox.mouseEnabled = true;
      }
      
      private function __startBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc4_:String = null;
         if(_isStart)
         {
            return;
         }
         if(_index <= 0)
         {
            return;
         }
         if(tempIdArr.length == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MonsterAccessoriesView.push.goods"));
            return;
         }
         if(!VIPManager.Instance.model.vipInfo.IsVipAndNoExpirt || VIPManager.Instance.model.vipInfo.VipGrade < 4)
         {
            SimpleAlertHelper.instance.data = [__quickHammerHandler];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc4_ = LanguageMgr.GetTranslation("vip.newVipOpenView.monsterAutoHammer.alert");
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc4_,_loc2_,_loc3_,true,true);
            return;
         }
         _isStart = true;
         _startBtn.visible = false;
         _stopBtn.visible = true;
         closeButtonEnable = false;
         _countNumTxt.mouseEnabled = false;
         _targetComBox.mouseChildren = _targetComBox.mouseEnabled = false;
         hammer();
      }
      
      private function __quickHammerHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.openControllerByInfo("vip");
         }
      }
      
      private function hammer() : void
      {
         if(_count == -1)
         {
            _count = parseInt(_countNumTxt.text);
         }
         else
         {
            _count = _count - 1;
         }
         if(_grades == -1)
         {
            _grades = _targetComBox.currentSelectedIndex + 1;
         }
         MonsterManager.instance.sendMonsterHammer(_index,tempIdArr,_count,_grades,true);
      }
      
      private function __textChangHandler(param1:Event) : void
      {
         var _loc2_:int = parseInt(_countNumTxt.text);
         if(_loc2_ <= 0)
         {
            _countNumTxt.text = "1";
         }
         if(_loc2_ >= 9999)
         {
            _countNumTxt.text = "9999";
         }
      }
      
      private function refreshView() : void
      {
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
      
      public function show(param1:* = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      public function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      private function get tempIdArr() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:GoodsInfo = null;
         var _loc1_:Array = [];
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            _loc3_ = GoodsManager.instance.getHideBagItemByPos(_loc2_);
            if(_loc3_)
            {
               _loc1_.push(_loc3_.templateId);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         model.isAutoHammer = false;
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_countBmp);
         _countBmp = null;
         ObjectUtils.disposeObject(_targetBmp);
         _targetBmp = null;
         ObjectUtils.disposeObject(_countNumBg);
         _countNumBg = null;
         ObjectUtils.disposeObject(_countNumTxt);
         _countNumTxt = null;
         ObjectUtils.disposeObject(_targetComBox);
         _targetComBox = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_stopBtn);
         _stopBtn = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

