package regress
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.CustomBitmap;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.regress.RegressRecordListMsg;
   import com.road.yishi.proto.regress.RegressRecordMsg;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.RegressTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.RegressManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   
   public class RegressFrame extends Frame implements IManualSize
   {
      
      private var _back:DisplayObject;
      
      private var _bg:DisplayObject;
      
      private var _left:DisplayObject;
      
      private var _bottom:DisplayObject;
      
      private var _returnNote:DisplayObject;
      
      private var _itemDic:Dictionary;
      
      private var _rechargeBtn:IconButton;
      
      private var _canReceiveNote:Bitmap;
      
      private var _chargeCanTakeCountTxt:FilterFrameText;
      
      private var _canReceiveBtn:IconButton;
      
      private var _receivedNote:Bitmap;
      
      private var _takedCountTxt:FilterFrameText;
      
      private var _canTakeTotalCountTxt:FilterFrameText;
      
      private var _remainTimeText:FilterFrameText;
      
      private var _noOpenTxt:FilterFrameText;
      
      private var _pointIcon1:CustomBitmap;
      
      private var _pointIcon2:CustomBitmap;
      
      private var _pointIcon3:CustomBitmap;
      
      private var _blackGound:Sprite;
      
      public function RegressFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,728,573);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         var _loc2_:RegressTemplateInfo = null;
         var _loc3_:RegressItem = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         titleText = LanguageMgr.GetTranslation("regress.RegressFrame.titleText");
         _back = ComponentFactory.Instance.creatComponentByStylename("regress.BagBack");
         _bg = ComponentFactory.Instance.creatBitmap("asset.regress.regressBg");
         _left = ComponentFactory.Instance.creatBitmap("asset.regress.regressLeftBg");
         _bottom = ComponentFactory.Instance.creatBitmap("asset.regress.regressBottomBg");
         _returnNote = ComponentFactory.Instance.creatBitmap("asset.regress.returnNote");
         _rechargeBtn = ComponentFactory.Instance.creatComponentByStylename("regress.rechargeBtn");
         _canReceiveNote = ComponentFactory.Instance.creatBitmap("asset.regress.canReceiveNote");
         _chargeCanTakeCountTxt = ComponentFactory.Instance.creatComponentByStylename("regress.chargeCanTakeCountTxt");
         _canReceiveBtn = ComponentFactory.Instance.creatComponentByStylename("regress.receiveBtn1");
         _receivedNote = ComponentFactory.Instance.creatBitmap("asset.regress.receivedNote");
         _takedCountTxt = ComponentFactory.Instance.creatComponentByStylename("regress.takedCountTxt");
         _canTakeTotalCountTxt = ComponentFactory.Instance.creatComponentByStylename("regress.canTakeTotalCountTxt");
         _pointIcon1 = ComponentFactory.Instance.creatCustomObject("regress.pointIcon1");
         _pointIcon2 = ComponentFactory.Instance.creatCustomObject("regress.pointIcon2");
         _pointIcon3 = ComponentFactory.Instance.creatCustomObject("regress.pointIcon3");
         _noOpenTxt = ComponentFactory.Instance.creatComponentByStylename("regress.noOpenContentTxt");
         _remainTimeText = ComponentFactory.Instance.creatComponentByStylename("regress.remainTimeText");
         setRemainTime();
         _blackGound = new Sprite();
         _blackGound.graphics.clear();
         _blackGound.graphics.beginFill(0,0.6);
         _blackGound.graphics.drawRect(0,0,695,470);
         _blackGound.graphics.endFill();
         _blackGound.visible = false;
         addToContent(_back);
         addToContent(_bg);
         addToContent(_left);
         addToContent(_bottom);
         addToContent(_returnNote);
         addToContent(_rechargeBtn);
         addToContent(_canReceiveNote);
         addToContent(_chargeCanTakeCountTxt);
         addToContent(_canReceiveBtn);
         addToContent(_receivedNote);
         addToContent(_takedCountTxt);
         addToContent(_canTakeTotalCountTxt);
         addToContent(_pointIcon1);
         addToContent(_pointIcon2);
         addToContent(_pointIcon3);
         addToContent(_remainTimeText);
         _itemDic = new Dictionary();
         var _loc1_:Array = TempleteManager.instance.regressTemplateCate.getTemplates();
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc5_] as RegressTemplateInfo;
            if(_loc2_.Types != 1)
            {
               _loc4_++;
               _loc3_ = ComponentFactory.Instance.creatCustomObject("regress.RegressItem");
               _loc3_.setData(_loc2_.TemplateId);
               _loc3_.x = 317;
               _loc3_.y = 22 + 55 * (_loc4_ - 1);
               addToContent(_loc3_);
               _itemDic[_loc2_.TemplateId] = _loc3_;
            }
            _loc5_++;
         }
         addToContent(_blackGound);
         addToContent(_noOpenTxt);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _rechargeBtn.addEventListener("click",__rechargeBtnHandler);
         _canReceiveBtn.addEventListener("click",__canReceiveBtnHandler);
         NotificationManager.instance.addEventListener("REGRESS_INFO_UPDATE",__regressInfoHandler);
         __regressInfoHandler(null);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _rechargeBtn.removeEventListener("click",__rechargeBtnHandler);
         _canReceiveBtn.removeEventListener("click",__canReceiveBtnHandler);
         NotificationManager.instance.removeEventListener("REGRESS_INFO_UPDATE",__regressInfoHandler);
      }
      
      private function __rechargeBtnHandler(param1:MouseEvent) : void
      {
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      private function __canReceiveBtnHandler(param1:MouseEvent) : void
      {
         var _loc5_:int = 0;
         var _loc6_:RegressRecordMsg = null;
         var _loc3_:RegressTemplateInfo = null;
         var _loc4_:int = 0;
         SoundManager.instance.play("022");
         var _loc2_:RegressRecordListMsg = RegressManager.instance.regressListMsg;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.info.length)
         {
            _loc6_ = _loc2_.info[_loc4_];
            _loc3_ = TempleteManager.instance.regressTemplateCate.getTemplateByID(_loc6_.takeTemplateId);
            if(_loc3_.Types == 1)
            {
               _loc5_ = int(_loc6_.takeTemplateId);
            }
            _loc4_++;
         }
         RegressManager.instance.OperatePoker(_loc5_);
      }
      
      private function __regressInfoHandler(param1:NotificationEvent) : void
      {
         var _loc4_:RegressItem = null;
         var _loc6_:RegressRecordMsg = null;
         var _loc3_:RegressTemplateInfo = null;
         var _loc5_:int = 0;
         var _loc2_:RegressRecordListMsg = RegressManager.instance.regressListMsg;
         if(!_loc2_)
         {
            return;
         }
         _chargeCanTakeCountTxt.text = _loc2_.chargeCanTakeCount.toString();
         _takedCountTxt.text = _loc2_.takedCount.toString();
         _canTakeTotalCountTxt.text = "/" + RegressManager.instance.canTakeTotalCount;
         _canReceiveBtn.enable = _loc2_.chargeCanTakeCount > 0;
         if(!_loc2_.states)
         {
            _blackGound.visible = true;
            _remainTimeText.visible = false;
            _noOpenTxt.text = LanguageMgr.GetTranslation("regress.RegressFrame.noOpenContent",_loc2_.targetSite);
            return;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc2_.info.length)
         {
            _loc6_ = _loc2_.info[_loc5_];
            _loc3_ = TempleteManager.instance.regressTemplateCate.getTemplateByID(_loc6_.takeTemplateId);
            if(!(!_loc3_ || _loc3_.Types == 1))
            {
               _loc4_ = _itemDic[_loc3_.TemplateId] as RegressItem;
               _loc4_.setData(_loc6_.takeTemplateId,_loc2_.loginDateCount,_loc6_.isFinish,_loc6_.isTakeReward);
            }
            _loc5_++;
         }
      }
      
      public function setRemainTime() : void
      {
         var _loc1_:RegressRecordListMsg = RegressManager.instance.regressListMsg;
         var _loc3_:Number = DateFormatter.parse(_loc1_.overDate,"YYYY-MM-DD hh:mm:ss").getTime() / 1000;
         var _loc2_:Number = _loc3_ - playerModel.sysCurTimeBySecond;
         if(_loc2_ >= 60)
         {
            _remainTimeText.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",DateFormatter.getFullTimeString(_loc2_));
         }
         else if(_loc2_ > 0)
         {
            _remainTimeText.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",DateFormatter.getFullDateString(_loc2_));
         }
         else
         {
            _remainTimeText.text = LanguageMgr.GetTranslation("feedback.FeedBackItem.outDate");
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
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
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_left);
         _left = null;
         ObjectUtils.disposeObject(_bottom);
         _bottom = null;
         ObjectUtils.disposeObject(_returnNote);
         _returnNote = null;
         ObjectUtils.disposeObject(_rechargeBtn);
         _rechargeBtn = null;
         ObjectUtils.disposeObject(_canReceiveNote);
         _canReceiveNote = null;
         ObjectUtils.disposeObject(_chargeCanTakeCountTxt);
         _chargeCanTakeCountTxt = null;
         ObjectUtils.disposeObject(_canReceiveBtn);
         _canReceiveBtn = null;
         ObjectUtils.disposeObject(_receivedNote);
         _receivedNote = null;
         ObjectUtils.disposeObject(_takedCountTxt);
         _takedCountTxt = null;
         ObjectUtils.disposeObject(_canTakeTotalCountTxt);
         _canTakeTotalCountTxt = null;
         ObjectUtils.disposeObject(_remainTimeText);
         _remainTimeText = null;
         ObjectUtils.disposeObject(_noOpenTxt);
         _noOpenTxt = null;
         ObjectUtils.disposeObject(_pointIcon1);
         _pointIcon1 = null;
         ObjectUtils.disposeObject(_pointIcon2);
         _pointIcon2 = null;
         ObjectUtils.disposeObject(_pointIcon3);
         _pointIcon3 = null;
         ObjectUtils.disposeObject(_blackGound);
         _blackGound = null;
         if(_itemDic)
         {
            for(var _loc1_:String in _itemDic)
            {
               ObjectUtils.disposeObject(_itemDic[_loc1_]);
               _itemDic[_loc1_] = null;
               delete _itemDic[_loc1_];
            }
         }
         _itemDic = null;
         super.dispose();
      }
   }
}

