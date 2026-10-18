package funny.regression
{
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import funny.FunnyHelper;
   import funny.datas.FunnyData;
   import funny.datas.FunnyType;
   import funny.view.FunnyBagItem;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.DateFormatter;
   
   public class RegressChargeView extends Sprite implements Disposeable, IManualSize
   {
      
      private var _back:MutipleImage;
      
      private var _rechargeBtn:IconButton;
      
      private var _panel:ScrollPanel;
      
      private var _totalVBox:VBox;
      
      private var _itemVBox:VBox;
      
      private var _itemList:Vector.<DisplayObject>;
      
      private var _title:GradientText;
      
      private var _describeText:FilterFrameText;
      
      private var _timeImage:Bitmap;
      
      private var _timeText:FilterFrameText;
      
      private var _remainTimeText:FilterFrameText;
      
      private var _conditionSprite:Sprite;
      
      private var _conditionImage:Bitmap;
      
      private var _condition:FilterFrameText;
      
      private var _processSprite:Sprite;
      
      private var _processImage:Bitmap;
      
      private var _process:FilterFrameText;
      
      private var _preSprite:Sprite;
      
      private var _preBack:Bitmap;
      
      private var _previewImage:Bitmap;
      
      private var _data:FunnyData;
      
      private var _txt:FilterFrameText;
      
      public function RegressChargeView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return null;
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("funny.funnyBagViewBack");
         _rechargeBtn = ComponentFactory.Instance.creatComponentByStylename("funny.funnyBagView.rechargeBtn");
         _title = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.title");
         _describeText = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.describeText");
         _timeImage = ComponentFactory.Instance.creatBitmap("asset.funny.timeImage");
         _timeText = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.timeText");
         _remainTimeText = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.remainTimeText");
         _conditionImage = ComponentFactory.Instance.creatBitmap("asset.funny.conditionImage");
         _condition = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.condition");
         _processImage = ComponentFactory.Instance.creatBitmap("asset.funny.processImage");
         _process = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.process");
         _preBack = ComponentFactory.Instance.creatBitmap("asset.funny.rewardTitleBack");
         _previewImage = ComponentFactory.Instance.creatBitmap("asset.funny.rewardTitle");
         _itemVBox = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.itemVBox");
         _totalVBox = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.totalVBox");
         _panel = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.panel");
         _title.text = LanguageMgr.GetTranslation("funny.view.FunnyBagView.title");
         _conditionSprite = new Sprite();
         _conditionSprite.addChild(_conditionImage);
         _conditionSprite.addChild(_condition);
         _processSprite = new Sprite();
         _processSprite.addChild(_processImage);
         _processSprite.addChild(_process);
         _preSprite = new Sprite();
         _txt = new FilterFrameText();
         _preSprite.addChild(_txt);
         _preSprite.addChild(_preBack);
         _preSprite.addChild(_previewImage);
         addChild(_back);
         addChild(_rechargeBtn);
         addChild(_title);
         addChild(_panel);
         _panel.setView(_totalVBox);
         _itemList = new Vector.<DisplayObject>();
         addChild(_timeImage);
         addChild(_timeText);
         addChild(_remainTimeText);
         _timeImage.visible = false;
         _timeText.visible = false;
         _remainTimeText.visible = false;
      }
      
      public function get data() : FunnyData
      {
         return _data;
      }
      
      public function set data(param1:FunnyData) : void
      {
         var _loc4_:IntPoint = null;
         var _loc2_:IntPoint = null;
         var _loc5_:int = 0;
         var _loc3_:Boolean = false;
         var _loc6_:FunnyBagItem = null;
         if(_data == param1 && _panel && _panel.viewPort)
         {
            _loc2_ = _panel.viewPort.viewPosition;
            _loc4_ = new IntPoint(_loc2_.x,_loc2_.y);
         }
         else
         {
            _loc4_ = new IntPoint();
         }
         _data = param1;
         if(_data && _data.type != 1007)
         {
            return;
         }
         cleanView();
         if(param1 == null)
         {
            return;
         }
         _itemVBox = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.itemVBox");
         _totalVBox.addChild(_describeText);
         _totalVBox.addChild(_conditionSprite);
         _conditionSprite.x = 5;
         if(FunnyType.isShowProcess(param1.type))
         {
            _totalVBox.addChild(_processSprite);
            _processSprite.x = 5;
            _process.text = FunnyHelper.processText(param1);
         }
         if(_data.type != 29 && _data.type != 43)
         {
            _totalVBox.addChild(_preSprite);
            _totalVBox.addChild(_itemVBox);
         }
         _describeText.text = param1.describe;
         _condition.htmlText = param1.condition;
         _loc5_ = 0;
         _loc3_ = false;
         while(_loc5_ < param1.bagList.length)
         {
            _loc6_ = new FunnyBagItem();
            _loc6_.data = param1.bagList[_loc5_];
            _itemVBox.addChild(_loc6_);
            _itemList.push(_loc6_);
            _loc5_++;
         }
         _totalVBox.refreshChildPos();
         _panel.invalidateViewport();
         _panel.viewPort.viewPosition = _loc4_;
      }
      
      private function cleanView() : void
      {
         _describeText.text = "";
         _timeText.text = "";
         _remainTimeText.text = "";
         _condition.htmlText = "";
         if(_itemVBox)
         {
            _itemVBox.disposeAllChildren();
         }
         if(_totalVBox)
         {
            _totalVBox.disposeAllChildren();
         }
         cleanList();
         _panel.invalidateViewport();
      }
      
      private function cleanList() : void
      {
         if(!_itemList)
         {
            return;
         }
         while(_itemList.length > 0)
         {
            _itemList.pop()["dispose"]();
         }
      }
      
      private function setTimeText() : void
      {
         _timeText.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.timeText",DateFormatter.getMonthDayString(_data.startTime),DateFormatter.getMonthDayString(_data.endTime));
         setRemainTime();
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function setRemainTime() : void
      {
         if(!_data || _data.type == 1003)
         {
            return;
         }
         var _loc1_:Number = _data.endTime / 1000 - playerModel.sysCurTimeBySecond;
         if(_loc1_ >= 60)
         {
            _remainTimeText.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",DateFormatter.getFullTimeString(_loc1_));
         }
         else if(_loc1_ > 0)
         {
            _remainTimeText.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",DateFormatter.getFullDateString(_loc1_));
         }
         else
         {
            _remainTimeText.text = LanguageMgr.GetTranslation("feedback.FeedBackItem.outDate");
         }
         if(_data.startTime > playerModel.nowDate)
         {
            _timeImage.visible = _timeText.visible = true;
            _remainTimeText.visible = false;
         }
         else
         {
            _timeImage.visible = _timeText.visible = false;
            _remainTimeText.visible = true;
         }
      }
      
      private function initEvent() : void
      {
         if(_rechargeBtn)
         {
            _rechargeBtn.addEventListener("click",__rechargeHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_rechargeBtn)
         {
            _rechargeBtn.removeEventListener("click",__rechargeHandler);
         }
      }
      
      private function __rechargeHandler(param1:MouseEvent) : void
      {
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      public function dispose() : void
      {
         removeEvent();
         cleanList();
         _itemList = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_rechargeBtn);
         _rechargeBtn = null;
         if(_totalVBox)
         {
            _totalVBox.disposeAllChildren();
         }
         ObjectUtils.disposeObject(_totalVBox);
         _totalVBox = null;
         if(_itemVBox)
         {
            _itemVBox.disposeAllChildren();
         }
         ObjectUtils.disposeObject(_itemVBox);
         _itemVBox = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_describeText);
         _describeText = null;
         ObjectUtils.disposeObject(_timeText);
         _timeText = null;
         ObjectUtils.disposeObject(_timeImage);
         _timeImage = null;
         ObjectUtils.disposeObject(_remainTimeText);
         _remainTimeText = null;
         ObjectUtils.disposeObject(_conditionImage);
         _conditionImage = null;
         ObjectUtils.disposeObject(_condition);
         _condition = null;
         _conditionSprite = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_preBack);
         _preBack = null;
         ObjectUtils.disposeObject(_previewImage);
         _previewImage = null;
         ObjectUtils.disposeObject(_processImage);
         _processImage = null;
         if(_process)
         {
            _process.dispose();
         }
         _process = null;
         _preSprite = null;
         _data = null;
         _processSprite = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

