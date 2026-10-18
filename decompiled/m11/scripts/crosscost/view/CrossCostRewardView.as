package crosscost.view
{
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import funny.datas.FunnyData;
   import manager.LanguageMgr;
   import yishi.utils.DateFormatter;
   
   public class CrossCostRewardView extends Sprite implements Disposeable, IManualSize
   {
      
      private var _bg:MovieClip;
      
      private var _timeText:FilterFrameText;
      
      private var _contentText:FilterFrameText;
      
      private var _time:FilterFrameText;
      
      private var _content:FilterFrameText;
      
      private var _conditionImage:Bitmap;
      
      private var _condition:FilterFrameText;
      
      private var _rewardImage:MutipleImage;
      
      private var _itemVBox:VBox;
      
      private var _itemList:Vector.<CrossCostRewardItem>;
      
      private var _panel:ScrollPanel;
      
      private var _data:FunnyData;
      
      private var _totalVBox:VBox;
      
      private var _activityDes:MutipleImage;
      
      private var _timeHbox:HBox;
      
      private var _contentHbox:HBox;
      
      private var _conditionHbox:HBox;
      
      public function CrossCostRewardView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("asset.crosscost.rewardview.bg");
         _activityDes = ComponentFactory.Instance.creatComponentByStylename("crosscost.rewardview.activityDes");
         _time = ComponentFactory.Instance.creatComponentByStylename("crosscost.rewardview.time");
         _content = ComponentFactory.Instance.creatComponentByStylename("crosscost.rewardview.content");
         _conditionImage = ComponentFactory.Instance.creatBitmap("asset.crosscost.rewardview.conditionImage");
         _condition = ComponentFactory.Instance.creatComponentByStylename("crosscost.rewardview.condition");
         _rewardImage = ComponentFactory.Instance.creatComponentByStylename("crosscost.rewardview.rewardImage");
         _panel = ComponentFactory.Instance.creatComponentByStylename("crosscost.rewardview.panel");
         _itemVBox = ComponentFactory.Instance.creatComponentByStylename("crosscost.rewardview.itemVBox");
         _timeText = ComponentFactory.Instance.creatComponentByStylename("crosscost.rewardview.timeText");
         _contentText = ComponentFactory.Instance.creatComponentByStylename("crosscost.rewardview.contentText");
         _timeText.text = LanguageMgr.GetTranslation("crosscost.rewarditem.time");
         _contentText.text = LanguageMgr.GetTranslation("crosscost.rewarditem.content");
         _totalVBox = new VBox();
         _totalVBox.spacing = 5;
         _timeHbox = new HBox();
         _contentHbox = new HBox();
         _conditionHbox = new HBox();
         _timeHbox.spacing = _contentHbox.spacing = 7;
         _conditionHbox.spacing = 27;
         _timeHbox.x = _contentHbox.x = _conditionHbox.x = 30;
         addChild(_bg);
         addChild(_activityDes);
         addChild(_panel);
         _timeHbox.addChild(_timeText);
         _timeHbox.addChild(_time);
         _contentHbox.addChild(_contentText);
         _contentHbox.addChild(_content);
         _conditionHbox.addChild(_conditionImage);
         _conditionHbox.addChild(_condition);
         _itemList = new Vector.<CrossCostRewardItem>();
         _totalVBox.addChild(_activityDes);
         _totalVBox.addChild(_timeHbox);
         _totalVBox.addChild(_contentHbox);
         _totalVBox.addChild(_conditionHbox);
         _totalVBox.addChild(_rewardImage);
         _totalVBox.addChild(_itemVBox);
         _panel.setView(_totalVBox);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_activityDes);
         _activityDes = null;
         ObjectUtils.disposeObject(_itemVBox);
         _itemVBox = null;
         ObjectUtils.disposeObject(_totalVBox);
         _totalVBox = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         ObjectUtils.disposeObject(_time);
         _time = null;
         ObjectUtils.disposeObject(_content);
         _content = null;
         ObjectUtils.disposeObject(_condition);
         _condition = null;
         ObjectUtils.disposeObject(_conditionImage);
         _conditionImage = null;
         ObjectUtils.disposeObject(_rewardImage);
         _rewardImage = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_timeText);
         _timeText = null;
         ObjectUtils.disposeObject(_contentText);
         _contentText = null;
         ObjectUtils.disposeObject(_timeHbox);
         _timeHbox = null;
         ObjectUtils.disposeObject(_contentHbox);
         _contentHbox = null;
         ObjectUtils.disposeObject(_conditionHbox);
         _conditionHbox = null;
         if(_itemList)
         {
            while(_itemList.length)
            {
               _itemList.pop().dispose();
            }
            _itemList = null;
         }
      }
      
      public function set data(param1:FunnyData) : void
      {
         var _loc5_:IntPoint = null;
         var _loc3_:IntPoint = null;
         var _loc7_:int = 0;
         var _loc8_:CrossCostRewardItem = null;
         var _loc6_:CrossCostRewardItem2 = null;
         if(!param1)
         {
            return;
         }
         clear();
         if(_data == param1 && _panel && _panel.viewPort)
         {
            _loc3_ = _panel.viewPort.viewPosition;
            _loc5_ = new IntPoint(_loc3_.x,_loc3_.y);
         }
         else
         {
            _loc5_ = new IntPoint();
         }
         _data = param1;
         var _loc4_:String = DateFormatter.transDate(_data.startTime / 1000);
         var _loc2_:String = DateFormatter.transDate(_data.endTime / 1000);
         _time.text = LanguageMgr.GetTranslation("crosscost.rewarditem.timeText",_loc4_.toString(),_loc2_.toString());
         _content.text = LanguageMgr.GetTranslation("crosscost.rewarditem.contentText",_data.condition);
         _condition.text = _data.describe;
         _loc7_ = 0;
         while(_loc7_ < param1.bagList.length)
         {
            _loc8_ = new CrossCostRewardItem();
            _loc8_.data = param1.bagList[_loc7_];
            _itemVBox.addChild(_loc8_);
            _itemList.push(_loc8_);
            _loc7_++;
         }
         if(param1.bagList[0].conditionList[0].id == 73)
         {
            _itemVBox.removeChildAt(1);
            _itemVBox.removeChildAt(1);
            _loc6_ = new CrossCostRewardItem2();
            _loc6_.setData(param1.bagList[1],param1.bagList[2]);
            _itemVBox.addChild(_loc6_);
         }
         _totalVBox.refreshChildPos();
         _panel.invalidateViewport();
         _panel.viewPort.viewPosition = _loc5_;
      }
      
      private function clear() : void
      {
         _time.text = "";
         _content.text = "";
         _condition.text = "";
         if(_itemList)
         {
            while(_itemList.length)
            {
               _itemList.pop().dispose();
            }
            _itemList = new Vector.<CrossCostRewardItem>();
         }
         _itemVBox.disposeAllChildren();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return null;
      }
      
      public function dispose() : void
      {
         uninitView();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

